# FastBinaryEncoding

[![Linux build status](https://img.shields.io/travis/chronoxor/FastBinaryEncoding/master.svg?label=Linux)](https://travis-ci.org/chronoxor/FastBinaryEncoding)
[![OSX build status](https://img.shields.io/travis/chronoxor/FastBinaryEncoding/master.svg?label=OSX)](https://travis-ci.org/chronoxor/FastBinaryEncoding)
[![Cygwin build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=Cygwin)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)
[![MinGW build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=MinGW)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)
[![Windows build status](https://img.shields.io/appveyor/ci/chronoxor/FastBinaryEncoding/master.svg?label=Windows)](https://ci.appveyor.com/project/chronoxor/FastBinaryEncoding)

Fast Binary Encoding Library allows to define any domain models, complex data
structures, client/server requests & responses and create models for different
programming languages and platforms.

[FastBinaryEncoding documentation](https://chronoxor.github.io/FastBinaryEncoding)<br/>
[FastBinaryEncoding downloads](https://github.com/chronoxor/FastBinaryEncoding/releases)<br/>

Performance comparison to other protocols can be found [here](https://github.com/chronoxor/CppSerialization):

| Protocol                                                              | Message size | Serialization time | Deserialization time |
| :-------------------------------------------------------------------: | -----------: | -----------------: | -------------------: |
| [Cap'n'Proto](https://capnproto.org)                                  |    208 bytes |             558 ns |               359 ns |
| [FastBinaryEncoding](https://github.com/chronoxor/FastBinaryEncoding) |    234 bytes |              66 ns |                82 ns |
| [FlatBuffers](https://google.github.io/flatbuffers)                   |    280 bytes |             830 ns |               290 ns |
| [Protobuf](https://developers.google.com/protocol-buffers)            |    120 bytes |             628 ns |               759 ns |
| [JSON](http://rapidjson.org)                                          |    301 bytes |             740 ns |               500 ns |

Typical usage workflow is the following:
1. [Create domain model](#create-domain-model) using base types, enums,
   flags and structs
2. [Generate domain model](#generate-domain-model) for any supported
   programming languages (C++, C#, Java, JavaScript, Python)
3. Build the domain model library
4. Serialize/Deserialize objects from the domain model in unified
   FastBinaryEncoding format (fast and compact)
5. JSON convert objects from the domain model in order to use them in Web API
6. Implement Sender/Receiver interfaces to create a communication protocol

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
  * [Performance benchmarks](#performance-benchmarks)
    * [Benchmark 1: Serialization](#benchmark-1-serialization)
    * [Benchmark 2: Deserialization](#benchmark-2-deserialization)
    * [Benchmark 3: Verify](#benchmark-3-verify)

# Features
* Cross platform (Linux, OSX, Windows)
* Generators for C++, C#, Java, JavaScript, Python
* Supported base types (byte, bool, char, wchar, int8, int16, int32, int64, float, double)
* Supported complex types (bytes, decimal, string, timestamp, uuid)
* Supported collections (array, vector, list, map, hash)
* [Fast binary encoding format](#performance-benchmarks)
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

There is an [example domain model](https://github.com/chronoxor/FastBinaryEncoding/blob/master/proto/proto.fbe)
which describes Account-Balance-Orders relation of some abstract trading
platform:

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
struct Order
{
    [key] int32 uid;
    string symbol;
    OrderSide side;
    OrderType type;
    double price = 0.0;
    double volume = 0.0;
}

// Account balance declaration
struct Balance
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
struct Account
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
The next step is a domain model compilation using 'fbec' compiler which will
create a generated code for required programming language.

The following command will create a C++ generated code:
```shell
fbec --c++ --input=proto.fbe --output=.
```

All possible options for the 'fbec' compiler are the following:
```shell
Usage: fbec [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -h HELP, --help=HELP  Show help
  -i INPUT, --input=INPUT
                        Input path
  -o OUTPUT, --output=OUTPUT
                        Output path
  -q, --quiet           Launch in quiet mode. No progress will be shown!
  -n INDENT, --indent=INDENT
                        Format indent. Default: 0
  -t, --tabs            Format with tabs. Default: off
  --cpp                 Generate C++ code
  --csharp              Generate C# code
  --java                Generate Java code
  --javascript          Generate JavaScript code
  --python              Generate Python code
  --final               Generate Final protocol code
  --json                Generate JSON protocol code
```

# Performance benchmarks

All benchmarks use the same [domain model](#create-domain-model) to create a
single account with three orders:
```c++
Account account = { 1, "Test", State::good, { "USD", 1000.0 }, std::make_optional<Balance>({ "EUR", 100.0 }), {} };
account.orders.emplace_back(1, "EURUSD", OrderSide::buy, OrderType::market, 1.23456, 1000.0);
account.orders.emplace_back(2, "EURUSD", OrderSide::sell, OrderType::limit, 1.0, 100.0);
account.orders.emplace_back(3, "EURUSD", OrderSide::buy, OrderType::stop, 1.5, 10.0);
```

* [C++ benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/performance) results were taken using [CppBenchmark library](https://github.com/chronoxor/CppBenchmark)
* [C# benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/CSharp/Benchmarks) results were taken using [BenchmarkDotNet library](https://benchmarkdotnet.org)
* [.NET Core benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/.NETCore/Benchmarks) results were taken using [BenchmarkDotNet library](https://benchmarkdotnet.org)
* [Java benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Java/src/benchmarks) results were taken using [JMH library](http://openjdk.java.net/projects/code-tools/jmh)
* [JavaScript benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/JavaScript/benchmarks) results were taken using [Benchmark.js library](https://benchmarkjs.com)
* [Python benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Python/benchmarks) results were taken using [timeit module](https://docs.python.org/3/library/timeit.html)

## Benchmark 1: Serialization

Serialization benchmark C++ code:
```c++
BENCHMARK_FIXTURE(SerializationFixture, "Serialize")
{
    // Reset FBE stream
    writer.reset();

    // Serialize the account to the FBE stream
    writer.serialize(account);
}
```

Serialization benchmark results:

| Language & Platform      | Message size (bytes) | Serialization rate (ops/s) | Serialization time (ns) |
| :----------------------- | -------------------: | -------------------------: | ----------------------: |
| C++ Win64                |                  252 |                 10 416 667 |                      96 |
| C++ Win64 (Final)        |                  152 |                 16 129 032 |                      62 |
| C++ Win64 (JSON)         |                  353 |                    926 784 |                   1 079 |
| C# Win64                 |                  252 |                  1 432 665 |                     698 |
| C# Win64 (Final)         |                  152 |                  1 597 444 |                     626 |
| C# Win64 (JSON)          |                  341 |                    434 783 |                   2 300 |
| .NET Core Linux          |                  252 |                  1 189 768 |                     841 |
| .NET Core Linux (Final)  |                  152 |                  1 315 270 |                     760 |
| .NET Core Linux (JSON)   |                  341 |                    366 435 |                   2 729 |
| Java Win64               |                  252 |                  4 247 162 |                     236 |
| Java Win64 (Final)       |                  152 |                  4 883 205 |                     205 |
| Java Win64 (JSON)        |                  353 |                    213 983 |                   4 673 |
| JavaScript Win64         |                  252 |                     93 416 |                  10 705 |
| JavaScript Win64 (Final) |                  152 |                    112 665 |                   8 876 |
| JavaScript Win64 (JSON)  |                  341 |                    217 637 |                   4 595 |
| Python Win64             |                  252 |                      9 434 |                 105 999 |
| Python Win64 (Final)     |                  152 |                     11 635 |                  85 945 |
| Python Win64 (JSON)      |                  324 |                     61 737 |                  16 198 |

## Benchmark 2: Deserialization

Deserialization benchmark C++ code:
```c++
BENCHMARK_FIXTURE(DeserializationFixture, "Deserialize")
{
    // Deserialize the account from the FBE stream
    reader.deserialize(deserialized);
}
```

Deserialization benchmark results:

| Language & Platform      | Message size (bytes) | Deserialization rate (ops/s) | Deserialization time (ns) |
| :----------------------- | -------------------: | ---------------------------: | ------------------------: |
| C++ Win64                |                  252 |                    9 523 810 |                       105 |
| C++ Win64 (Final)        |                  152 |                   10 989 011 |                        91 |
| C++ Win64 (JSON)         |                  353 |                    1 375 516 |                       727 |
| C# Win64                 |                  252 |                    1 014 199 |                       986 |
| C# Win64 (Final)         |                  152 |                    1 607 717 |                       622 |
| C# Win64 (JSON)          |                  341 |                      258 532 |                     3 868 |
| .NET Core Linux          |                  252 |                      804 052 |                     1 244 |
| .NET Core Linux (Final)  |                  152 |                    1 343 544 |                       744 |
| .NET Core Linux (JSON)   |                  341 |                      222 074 |                     4 503 |
| Java Win64               |                  252 |                    2 688 084 |                       372 |
| Java Win64 (Final)       |                  152 |                    3 036 020 |                       329 |
| Java Win64 (JSON)        |                  353 |                      308 675 |                     3 240 |
| JavaScript Win64         |                  252 |                      133 892 |                     7 469 |
| JavaScript Win64 (Final) |                  152 |                      292 273 |                     3 422 |
| JavaScript Win64 (JSON)  |                  341 |                      289 417 |                     3 455 |
| Python Win64             |                  252 |                        8 305 |                   120 411 |
| Python Win64 (Final)     |                  152 |                       11 661 |                    85 758 |
| Python Win64 (JSON)      |                  324 |                       48 859 |                    20 467 |

## Benchmark 3: Verify

Verify benchmark C++ code:
```c++
BENCHMARK_FIXTURE(VerifyFixture, "Verify")
{
    // Verify the account
    model.verify();
}
```

Verify benchmark results:

| Language & Platform      | Message size (bytes) | Verify rate (ops/s) | Verify time (ns) |
| :----------------------- | -------------------: | ------------------: | ---------------: |
| C++ Win64                |                  252 |          31 250 000 |              105 |
| C++ Win64 (Final)        |                  152 |          35 714 286 |               91 |
| C# Win64                 |                  252 |           4 504 505 |              222 |
| C# Win64 (Final)         |                  152 |           8 064 516 |              124 |
| .NET Core Linux          |                  252 |           3 718 855 |              269 |
| .NET Core Linux (Final)  |                  152 |           6 653 360 |              150 |
| Java Win64               |                  252 |          11 790 374 |               85 |
| Java Win64 (Final)       |                  152 |          16 205 533 |               62 |
| JavaScript Win64         |                  252 |           1 105 627 |              905 |
| JavaScript Win64 (Final) |                  152 |           5 700 408 |              175 |
| Python Win64             |                  252 |              20 825 |           48 019 |
| Python Win64 (Final)     |                  152 |              23 590 |           42 391 |
