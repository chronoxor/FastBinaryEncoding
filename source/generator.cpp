/*!
    \file generator.cpp
    \brief Fast binary encoding generator implementation
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

#include "generator.h"

#if defined(_WIN32) || defined(_WIN64) || defined(__CYGWIN__)
#include <windows.h>
#endif

namespace FBE {

void Generator::Store(const CppCommon::Path& filename)
{
    std::string previous;

    // Try to read the previous file content
    if (filename.IsExists())
    {
        CppCommon::File file = filename;
        file.Open(true, false);
        previous = file.ReadAllText();
        file.Close();
    }

    // Compare the buffer with previous content in order to store only new content
    if (_buffer == previous)
        return;

    // Store the buffer into unique file
    CppCommon::Path unique = filename.parent() / CppCommon::Path::unique();
    CppCommon::File::WriteAllText(unique, _buffer);

#if defined(_WIN32) || defined(_WIN64) || defined(__CYGWIN__)
    // Sometimes it happens that Visual Studio opens generated files on a fly to analyze.
    // It opens them with mapping into its process with CreateFileMapping/MapViewOfFile.
    // As the result files cannot be replaced or removed. Therefore we need to have some
    // retry attempts with small delay to give a change for the file to be created.
    // https://stackoverflow.com/questions/41844842/when-error-1224-error-user-mapped-file-occurs
    const int attempts = 1000;
    const int sleep = 100;
    for (int attempt = 0; attempt < attempts; ++attempt)
    {
        try
        {
            // Rename the unique file inside a loop with retries
            CppCommon::Path::Rename(unique, filename);
            return;
        }
        catch (const CppCommon::FileSystemException& ex)
        {
            if ((ex.system_error() == ERROR_ACCESS_DENIED) || (ex.system_error() == ERROR_USER_MAPPED_FILE))
            {
                CppCommon::Thread::Sleep(sleep);
                continue;
            }
            throw;
        }
    }
    throwex CppCommon::FileSystemException("Cannot generate the output file!").Attach(filename);
#else
    // Rename the unique file inside a loop with retries
    CppCommon::Path::Rename(unique, filename);
#endif
}

} // namespace FBE
