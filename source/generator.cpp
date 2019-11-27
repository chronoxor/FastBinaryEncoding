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

void Generator::Open(const CppCommon::Path& filename)
{
    // Take the write file-lock
    _lock = filename + ".lock";
    _lock.LockWrite();

    _cursor = 0;
    _file = filename;

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
            _file.OpenOrCreate(false, true, true);
            return;
        }
        catch (const CppCommon::FileSystemException& ex)
        {
            if (ex.system_error() == ERROR_USER_MAPPED_FILE)
            {
                CppCommon::Thread::Sleep(sleep);
                continue;
            }
            throw;
        }
    }
    throwex CppCommon::FileSystemException("Cannot generate output file!").Attach(filename);
#else
    _file.OpenOrCreate(false, true, true);
#endif
}

void Generator::Close()
{
    _file.Close();

    // Release the write file-lock
    _lock.UnlockWrite();
    _lock.Reset();
}

} // namespace FBE
