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
1. Create a domain model using base types, enums, flags and structs
2. Generate domain model for any supported programming languages
   (C++, C#, Java, JavaScript, Python)
3. Build the domain model library
4. Serialize/Deserialize objects from the domain model in unified
   FastBinaryEncoding format (fast and compact)
5. JSON convert objects from the domain model in order to use them in Web API
6. Implement Sender/Receiver interfaces to create a communication protocol

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
  * [Create domain model](#create-domain-model)
  * [Generate domain model](#generate-domain-model)

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

# Create domain model
The first step you should perform to use FastBinaryEncoding is to provide a
domain model (aka business objects). Domain model is a set of enums, flags
and structures that related to each other and might be aggregated in some
hierarchy.

There is an example domain model which describes Account-Balance-Orders
relation of some abstract trading platform:

```proto
// Package declaration
package proto

// Order side declaration
enum OrderSide : byte
{
    buy;
    sell;
}

// Order type declaration
enum OrderType : byte
{
    market;
    limit;
    stop;
}

// Order declaration
struct Order = 1
{
    [key] int32 uid;
    string symbol;
    OrderSide side;
    OrderType type;
    double price = 0.0;
    double volume = 0.0;
}

// Account balance declaration
struct Balance = 2
{
    [key] string currency;
    double amount = 0.0;
}

// Account state declaration
flags State : byte
{
    unknown = 0x00;
    invalid = 0x01;
    initialized = 0x02;
    calculated = 0x04;
    broken = 0x08;
    good = initialized | calculated;
    bad = unknown | invalid | broken;
}

// Account declaration
struct Account = 3
{
    [key] int32 uid;
    string name;
    State state = State.initialized | State.bad;
    Balance wallet;
    Balance? asset;
    Order[] orders;
}
```

# Generate domain model
