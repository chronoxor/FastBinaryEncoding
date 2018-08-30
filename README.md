# FastBinaryEncoding

[![Linux build status](https://img.shields.io/travis/chronoxor/FastBinaryEncoding/master.svg?label=Linux)](https://travis-ci.org/chronoxor/FastBinaryEncoding)
[![OSX build status](https://img.shields.io/travis/chronoxor/FastBinaryEncoding/master.svg?label=OSX)](https://travis-ci.org/chronoxor/FastBinaryEncoding)
[![Cygwin build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=Cygwin)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)
[![MinGW build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=MinGW)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)
[![Windows build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=Windows)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)

Fast Binary Encoding Library allows to define any domain models, complex data
structures, client/server requests & responses and create models for different
programming languages and platforms.

Typical usage workflow is the following:
1) Declare a data model using base types, enums, flags and structs
2) Generate domain model for any of supported programming languages
   (C++, C#, Java, JavaScript, Python)
3) Build the model library
4) Serialize/Deserialize objects from the model in unified FastBinaryEncoding
   format (fast and compact)
5) JSON convert objects from the model in order to use them in Web API
6) Implement Sender/Receiver interfaces to create a communication protocol

[FastBinaryEncoding documentation](https://chronoxor.github.io/FastBinaryEncoding)<br/>
[FastBinaryEncoding downloads](https://github.com/chronoxor/FastBinaryEncoding/releases)<br/>

# Contents
  * [Features](#features)
  * [Requirements](#requirements)
  * [How to build?](#how-to-build)
    * [Clone repository with submodules](#clone-repository-with-submodules)
    * [Linux](#linux)
    * [OSX](#osx)
    * [Windows (Cygwin)](#windows-cygwin)
    * [Windows (MinGW)](#windows-mingw)
    * [Windows (MinGW with MSYS)](#windows-mingw-with-msys)
    * [Windows (Visual Studio)](#windows-visual-studio)

# Features
* Cross platform (Linux, OSX, Windows)
* Generators for C++, C#, Java, JavaScript, Python
* Supported base types (byte, bool, char, wchar, int8, int16, int32, int64, float, double)
* Supported complex types (bytes, decimal, string, timestamp, uuid)
* Supported collections (array, vector, list, map, hash)
* Fast binary encoding format
* Serialization/Deserialization to binary format
* Serialization/Deserialization to JSON
* Sender/Receiver interfaces for communication protocols

# Requirements
* Linux (gcc g++ cmake doxygen graphviz binutils-dev uuid-dev flex bison)
* OSX (clang cmake doxygen graphviz flex bison)
* Windows 7 / Windows 10
* [cmake](https://www.cmake.org)
* [git](https://git-scm.com)
* [gcc](https://gcc.gnu.org)

Optional:
* [clang](https://clang.llvm.org)
* [clion](https://www.jetbrains.com/clion)
* [Cygwin](https://cygwin.com)
* [MinGW](https://mingw-w64.org/doku.php)
* [Visual Studio](https://www.visualstudio.com)
* [WinFlexBison](https://github.com/lexxmark/winflexbison)

# How to build?

## Clone repository with submodules
```shell
git clone https://github.com/chronoxor/CppTemplate.git
cd CppTemplate
git submodule update --init --recursive --remote
```

## Linux
```shell
cd build
./unix.sh
```

## OSX
```shell
cd build
./unix.sh
```

## Windows (Cygwin)
```shell
cd build
cygwin.bat
```

## Windows (MinGW)
```shell
cd build
mingw.bat
```

## Windows (Visual Studio)
```shell
cd build
vs.bat
```
