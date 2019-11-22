/*!
    \file generator.cpp
    \brief Fast binary encoding generator implementation
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

#include "generator.h"

namespace FBE {

void Generator::Open(const CppCommon::Path& filename)
{
    // Take the write file-lock
    _lock = filename + ".lock";
    _lock.LockWrite();

    _cursor = 0;
    _file = filename;

    // Sometimes it happens that Visual Studio opens generated files on a fly to analyze.
    // It opens them with mapping into its process with CreateFileMapping/MapViewOfFile.
    // As the result files cannot be replaced or removed. Therefore we need to have some
    // retry attempts with small delay to give a change for file to be created.
    // https://stackoverflow.com/questions/41844842/when-error-1224-error-user-mapped-file-occurs
    const int attempts = 10;
    const int sleep = 100;
    for (int attempt = 0; attempt < attempts; ++attempt)
    {
        try
        {
            _file.OpenOrCreate(false, true, true);
        }
        catch (const CppCommon::FileSystemException& ex)
        {
            if (ex.system_error() == 1224)
                continue;
        }
        break;
    }
}

void Generator::Close()
{
    _file.Close();

    // Release the write file-lock
    _lock.UnlockWrite();
    _lock.Reset();
}

} // namespace FBE
