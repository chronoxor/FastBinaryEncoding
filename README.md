# Fast Binary Encoding (FBE)

[![Awesome C++](https://awesome.re/badge.svg)](https://github.com/fffaraz/awesome-cpp)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Release](https://img.shields.io/github/release/chronoxor/FastBinaryEncoding.svg?sort=semver)](https://github.com/chronoxor/FastBinaryEncoding/releases)
<br/>
[![Linux (clang)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-linux-clang.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-linux-clang.yml)
[![Linux (gcc)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-linux-gcc.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-linux-gcc.yml)
[![MacOS](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-macos.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-macos.yml)
<br/>
[![Windows (Cygwin)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-cygwin.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-cygwin.yml)
[![Windows (MSYS2)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-msys2.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-msys2.yml)
[![Windows (MinGW)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-mingw.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-mingw.yml)
[![Windows (Visual Studio)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-vs.yml/badge.svg)](https://github.com/chronoxor/FastBinaryEncoding/actions/workflows/build-windows-vs.yml)

Fast Binary Encoding allows to describe any domain models, business
objects, complex data structures, client/server requests & responses
and generate native code for different programming languages and platforms.

[Fast Binary Encoding documentation](https://chronoxor.github.io/FastBinaryEncoding)<br/>
[Fast Binary Encoding downloads](https://github.com/chronoxor/FastBinaryEncoding/releases)<br/>
[Fast Binary Encoding specification](https://chronoxor.github.io/FastBinaryEncoding/documents/FBE.html)

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
   programming languages (C++, C#, Go, Java, JavaScript, Kotlin, Python, Ruby, Swift)
3. [Build domain model](#build-domain-model) library
4. [Serialize/Deserialize](#fbe-serialization) objects from the domain model
   in unified, fast and compact FastBinaryEncoding (FBE) format
5. [JSON convert](#json-serialization) objects from the domain model in order
   to use them in Web API
6. Implement [Sender/Receiver interfaces](#senderreceiver-protocol) to create a communication protocol

Sample projects:
* [C++ sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/examples)
* [C# sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/CSharp)
* [Go sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Go)
* [Java sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Java)
* [JavaScript sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/JavaScript)
* [Kotlin sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Kotlin)
* [Python sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Python)
* [Ruby sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Ruby)
* [Swift sample](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Swift)

# Contents
  * [Features](#features)
  * [Requirements](#requirements)
  * [How to build?](#how-to-build)
  * [Create domain model](#create-domain-model)
  * [Generate domain model](#generate-domain-model)
  * [Build domain model](#build-domain-model)
  * [FBE serialization](#fbe-serialization)
  * [FBE final serialization](#fbe-final-serialization)
  * [JSON serialization](#json-serialization)
  * [Packages and import](#packages-and-import)
  * [Struct keys](#struct-keys)
  * [Struct numeration](#struct-numeration)
  * [Struct inheritance](#struct-inheritance)
  * [Versioning](#versioning)
  * [Sender/Receiver protocol](#senderreceiver-protocol)
  * [Performance benchmarks](#performance-benchmarks)
    * [Benchmark 1: Serialization](#benchmark-1-serialization)
    * [Benchmark 2: Deserialization](#benchmark-2-deserialization)
    * [Benchmark 3: Verify](#benchmark-3-verify)

# Features
* Cross platform (Linux, MacOS, Windows)
* [Generators for C++, C#, Go, Java, JavaScript, Kotlin, Python, Ruby, Swift](#generate-domain-model)
* [Fast binary encoding format](documents/FBE.md)
* [Supported base types (byte, bool, char, wchar, int8, int16, int32, int64, float, double)](documents/FBE.md#base-types)
* [Supported complex types (bytes, decimal, string, timestamp, uuid)](documents/FBE.md#complex-types)
* [Supported collections (array, vector, list, map, hash)](documents/FBE.md#collections)
* [Supported nullable optional types, enums, flags and structs](documents/FBE.md#optional-type)
* [Serialization/Deserialization to/from binary format](#fbe-serialization)
* [Serialization/Deserialization to/from JSON](#json-serialization)
* [Sender/Receiver interfaces for communication protocols](#senderreceiver-protocol)
* [Versioning solution](#versioning)
* [Excellent performance](#performance-benchmarks)

# Requirements
* Linux
* MacOS
* Windows
* [cmake](https://www.cmake.org)
* [gcc](https://gcc.gnu.org)
* [git](https://git-scm.com)
* [gil](https://github.com/chronoxor/gil.git)
* [python3](https://www.python.org)

Optional:
* [clang](https://clang.llvm.org)
* [CLion](https://www.jetbrains.com/clion)
* [Cygwin](https://cygwin.com)
* [MSYS2](https://www.msys2.org)
* [MinGW](https://mingw-w64.org/doku.php)
* [Visual Studio](https://www.visualstudio.com)
* [WinFlexBison](https://github.com/lexxmark/winflexbison)

# How to build?

### Linux: install required packages
```shell
sudo apt-get install -y binutils-dev uuid-dev flex bison
```

### MacOS: install required packages
```shell
brew install flex bison
```

### Windows: install required packages
```shell
choco install winflexbison3
```

### Install [gil (git links) tool](https://github.com/chronoxor/gil)
```shell
pip3 install gil
```

### Setup repository
```shell
git clone https://github.com/chronoxor/FastBinaryEncoding.git
cd FastBinaryEncoding
gil update
```

### Linux
```shell
cd build
./unix.sh
```

### MacOS
```shell
cd build
./unix.sh
```

### Windows (Cygwin)
```shell
cd build
unix.bat
```

### Windows (MSYS2)
```shell
cd build
unix.bat
```

### Windows (MinGW)
```shell
cd build
mingw.bat
```

### Windows (Visual Studio)
```shell
cd build
vs.bat
```

# Create domain model
To use Fast Binary Encoding you should provide
a domain model (aka business objects). A domain model is a set of enums, flags
and structures that relate to each other and might be aggregated in some
hierarchy.

[Fast Binary Encoding (FBE) format specification](documents/FBE.md)

There is a [sample domain model](https://github.com/chronoxor/FastBinaryEncoding/blob/master/proto/proto.fbe)
which describes Account-Balance-Orders relation of some abstract trading
platform:

```proto
// Package declaration
package proto

// Domain declaration
domain com.chronoxor

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
  --cpp-logging         Generate C++ logging code
  --csharp              Generate C# code
  --go                  Generate Go code
  --java                Generate Java code
  --javascript          Generate JavaScript code
  --kotlin              Generate Kotlin code
  --python              Generate Python code
  --ruby                Generate Ruby code
  --swift               Generate Swift code
  --final               Generate Final serialization code
  --json                Generate JSON serialization code
  --proto               Generate Sender/Receiver protocol code
```

# Build domain model
Generated domain model is represented with source code for the particular language.
Just add it to your project and build it.
There are several issues and dependencies that should be mentioned:

### C++
* C++ standard is limited to C++17 in order to have the implementation of
  [std::optional](https://en.cppreference.com/w/cpp/utility/optional);
* C++ has no native support for decimal type. Currently decimal type is
  emulated with a double type. FBE does not use [GMPLib](https://gmplib.org)
  because of heavy dependency in generated source code;
* C++ formatting is supported with [{fmt}](https://fmt.dev) library of version
  started from 9.0.0. Required include headers are `<fmt/format.h>` and
  `<fmt/ostream.h>`;
* JSON serialization is implemented using [RapidJSON](https://rapidjson.org)
  library;

### C#
* JSON serialization is implemented using [Json.NET](https://www.newtonsoft.com/json) library.
  Therefore it should be imported using NuGet;
* Fast JSON serialization libraty is also available - [Utf8Json ](https://github.com/neuecc/Utf8Json).
  If you want to try it, you should import is with NuGet and build domain model
  with 'UTF8JSON' definition;

### Go
* Assert testing is based on [stretchr/testify](https://github.com/stretchr/testify) package (`go get github.com/stretchr/testify`);
* JSON serialization is based on [jsoniter](https://github.com/json-iterator/go) package (`go get github.com/json-iterator/go`);
* Decimal type is based on [shopspring/decimal](https://github.com/shopspring/decimal) package (`go get github.com/shopspring/decimal`);
* UUID type is based on [google/uuid](https://github.com/google/uuid) package (`go get github.com/google/uuid`);

### Java
* JSON serialization is implemented using [Gson](https://github.com/google/gson) package.
  Therefore it should be imported using Maven;

### JavaScript
* JavaScript domain model is implemented using [ECMAScript 6](http://es6-features.org)
  (classes, etc.);
* JSON serialization of set, map and hash types is limited to key with string type;

### Kotlin
* Starting from the version 1.3 [Kotlin supports unsigned integer numbers (UByte, UShort, UInt, ULong)](https://github.com/Kotlin/KEEP/blob/unsigned_types/proposals/unsigned-types.md).
  This gives ability to represent FBE domain model more accurately than Java
  language does;
* JSON serialization is implemented using [Gson](https://github.com/google/gson) package.
  Therefore it should be imported using Maven;

### Python
* Python 3.7 is required because of [time.time_ns()](https://docs.python.org/3/library/time.html#time.time_ns);

### Ruby
* Some Ruby dependencies should be installed from Gems:
```shell
gem install json
gem install uuidtools
```

### Swift
* Swift domain model is implemented using  uses [SwiftPM](https://github.com/apple/swift-package-manager) as its build tool;
* JSON serialization is implemented using [Codable](https://developer.apple.com/documentation/swift/codable) protocol;
* JSON serialization of set, map and hash types is limited to key with string type.

# FBE serialization
Fast Binary Encoding (FBE) is a fast and compact binary format of representing
single domain models in different programming languages and platforms.
Also FBE format [solves protocol versioning problem](#versioning).

Follow the steps below in order to serialize any domain object:
1. Create a new domain object and fill its fields and collections (*proto::Account account*);
2. Create a domain model with a write buffer (*FBE::proto::AccountModel<FBE::WriteBuffer> writer*)
3. Serialize the domain object into the domain model buffer (*writer.serialize(account)*)
4. (Optional) Verify the domain object in the domain model buffer (*assert(writer.verify())*)
5. Access the domain model buffer to store or send data (*writer.buffer()*)

Follow the steps below in order to deserialize any domain object:
1. Create a domain model with a read buffer (*FBE::proto::AccountModel<FBE::ReadBuffer> reader*)
2. Attach a source buffer to the domain model (*reader.attach(writer.buffer())*)
3. (Optional) Verify the domain object in the domain model buffer (*assert(reader.verify())*)
4. Deserialize the domain object from the domain model buffer (*reader.deserialize(account)*)

Here is an exmple of FBE serialization in C++ language:
```c++
#include "../proto/proto_models.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the FBE stream
    FBE::proto::AccountModel<FBE::WriteBuffer> writer;
    writer.serialize(account);
    assert(writer.verify());

    // Show the serialized FBE size
    std::cout << "FBE size: " << writer.buffer().size() << std::endl;

    // Deserialize the account from the FBE stream
    FBE::proto::AccountModel<FBE::ReadBuffer> reader;
    reader.attach(writer.buffer());
    assert(reader.verify());
    reader.deserialize(account);

    // Show account content
    std::cout << std::endl;
    std::cout << account;

    return 0;
}
```

Output is the following:
```
FBE size: 252

Account(
  uid=1,
  name="Test",
  state=initialized|calculated|good,
  wallet=Balance(currency="USD",amount=1000),
  asset=Balance(currency="EUR",amount=100),
  orders=[3][
    Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000),
    Order(uid=2,symbol="EURUSD",side=sell,type=limit,price=1,volume=100),
    Order(uid=3,symbol="EURUSD",side=buy,type=stop,price=1.5,volume=10)
  ]
)
```

# FBE final serialization
It is possible to achieve more serialization speed if your protocol is mature
enough so you can fix its final version and disable [versioning](#versioning)
which requires extra size and time to process.

| Protocol  | Message size | Serialization time | Deserialization time | Verify time |
| :-------: | -----------: | -----------------: | -------------------: | ----------: |
| FBE       |    252 bytes |              88 ns |                98 ns |       33 ns |
| FBE final |    152 bytes |              57 ns |                81 ns |       28 ns |

Final domain model can be compiled with [--final](#generate-domain-model) flag.
As the result additional final models will be available for serialization.

Follow the steps below in order to serialize any domain object in final format:
1. Create a new domain object and fill its fields and collections (*proto::Account account*);
2. Create a domain final model with a write buffer (*FBE::proto::AccountFinalModel<FBE::WriteBuffer> writer*)
3. Serialize the domain object into the domain model buffer (*writer.serialize(account)*)
4. (Optional) Verify the domain object in the domain model buffer (*assert(writer.verify())*)
5. Access the domain model buffer to store or send data (*writer.buffer()*)

Follow the steps below in order to deserialize any domain object:
1. Create a domain final model with a read buffer (*FBE::proto::AccountFinalModel<FBE::ReadBuffer> reader*)
2. Attach a source buffer to the domain final model (*reader.attach(writer.buffer())*)
3. (Optional) Verify the domain object in the domain model buffer (*assert(reader.verify())*)
4. Deserialize the domain object from the domain model buffer (*reader.deserialize(account)*)

Here is an exmple of FBE final serialization in C++ language:
```c++
#include "../proto/proto_models.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the FBE stream
    FBE::proto::AccountFinalModel<FBE::WriteBuffer> writer;
    writer.serialize(account);
    assert(writer.verify());

    // Show the serialized FBE size
    std::cout << "FBE final size: " << writer.buffer().size() << std::endl;

    // Deserialize the account from the FBE stream
    FBE::proto::AccountFinalModel<FBE::ReadBuffer> reader;
    reader.attach(writer.buffer());
    assert(reader.verify());
    reader.deserialize(account);

    // Show account content
    std::cout << std::endl;
    std::cout << account;

    return 0;
}
```

Output is the following:
```
FBE final size: 152

Account(
  uid=1,
  name="Test",
  state=initialized|calculated|good,
  wallet=Balance(currency="USD",amount=1000),
  asset=Balance(currency="EUR",amount=100),
  orders=[3][
    Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000),
    Order(uid=2,symbol="EURUSD",side=sell,type=limit,price=1,volume=100),
    Order(uid=3,symbol="EURUSD",side=buy,type=stop,price=1.5,volume=10)
  ]
)
```

# JSON serialization
If the domain model compiled with [--json](#generate-domain-model) flag,
then JSON serialization code will be generated in all domain objects.
As the result each domain object can be serialized/deserialized into/from
[JSON format](https://www.json.org).

Please note that some programming languages have native JSON support
(JavaScript, Python). Other languages requires third-party library
to get work with JSON:
* C++ requires [RapidJSON](http://rapidjson.org) library
* C# requires [Json.NET](https://www.newtonsoft.com/json) package or more faster [Utf8Json](https://github.com/neuecc/Utf8Json) package
* Go requires [jsoniter](https://github.com/json-iterator/go) package
* Java and Kotlin requires [Gson](https://github.com/google/gson) package
* Ruby requires [json](https://rubygems.org/gems/json) gem

Here is an exmple of JSON serialization in C++ language:
```c++
#include "../proto/proto.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the JSON stream
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
    FBE::JSON::to_json(writer, account);

    // Show the serialized JSON and its size
    std::cout << "JSON: " << buffer.GetString() << std::endl;
    std::cout << "JSON size: " << buffer.GetSize() << std::endl;

    // Parse the JSON document
    rapidjson::Document json;
    json.Parse(buffer.GetString());

    // Deserialize the account from the JSON stream
    FBE::JSON::from_json(json, account);

    // Show account content
    std::cout << std::endl;
    std::cout << account;

    return 0;
}
```

Output is the following:
```
JSON: {
  "uid":1,
  "name":
  "Test",
  "state":6,
  "wallet":{"currency":"USD","amount":1000.0},
  "asset":{"currency":"EUR","amount":100.0},
  "orders":[
    {"uid":1,"symbol":"EURUSD","side":0,"type":0,"price":1.23456,"volume":1000.0},
    {"uid":2,"symbol":"EURUSD","side":1,"type":1,"price":1.0,"volume":100.0},
    {"uid":3,"symbol":"EURUSD","side":0,"type":2,"price":1.5,"volume":10.0}
  ]
}
JSON size: 353

Account(
  uid=1,
  name="Test",
  state=initialized|calculated|good,
  wallet=Balance(currency="USD",amount=1000),
  asset=Balance(currency="EUR",amount=100),
  orders=[3][
    Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000),
    Order(uid=2,symbol="EURUSD",side=sell,type=limit,price=1,volume=100),
    Order(uid=3,symbol="EURUSD",side=buy,type=stop,price=1.5,volume=10)
  ]
)
```

# Packages and import
Packages are declared with package name and structs offset (optional). Offset
will be add to incremented structure type if is was not provided explicit.

Here is an example of the simple package declaration:
```proto
// Package declaration. Offset is 0.
package proto

// Struct type number is 1 (proto offset 0 + 1)
struct Struct1
{
    ...
}

// Struct type number is 2 (proto offset 0 + 2)
struct Struct2
{
    ...
}
```

One package can be imported into another and all enums, flags and structs can
be reused in the current package. Package offset is used here to avoid structs
types intersection:
```proto
// Package declaration. Offset is 10.
package protoex offset 10

// Package import
import proto

// Struct type number is 11 (protoex offset 10 + 1)
struct Struct11
{
    // Struct1 is reused form the imported package
    proto.Struct1 s1;
    ...
}

// Struct type number is 12 (protoex offset 10 + 2)
struct Struct12
{
    ...
}
```

Multiple package import is possible as well:
```proto
// Package declaration. Offset is 100.
package test offset 100

// Package import
import proto
import protoex

...
```

Package import is implemented using:
* #include "..." directive in C++
* Namespaces in C#
* Packages in Go
* Packages in Java and Kotlin
* Modules in JavaScript
* Modules in Python
* Ruby require statement

# Struct keys
Some of struct fileds (one or many) can be marked with '[key]' attribute. As
the result corresponding compare operators will be generated which allow to
compare two instances of the struct (equality, ordering, hashing) by marked
fields. This ability allows to use the struct as a key in associative map and
hash containers.

Example below demonstrates the usage of '[key]' attribute:
```proto
struct MyKeyStruct
{
    [key] int32 uid;
    [key] stirng login;
    string name;
    string address;
}
```

After code generation for C++ language the following comparable class will be
generated:
```c++
struct MyKeyStruct
{
    int32_t uid;
    ::sample::stirng login;
    std::string name;
    std::string address;

    ...

    bool operator==(const MyKeyStruct& other) const noexcept
    {
        return (
            (uid == other.uid)
            && (login == other.login)
            );
    }
    bool operator!=(const MyKeyStruct& other) const noexcept { return !operator==(other); }
    bool operator<(const MyKeyStruct& other) const noexcept
    {
        if (uid < other.uid)
            return true;
        if (other.uid < uid)
            return false;
        if (login < other.login)
            return true;
        if (other.login < login)
            return false;
        return false;
    }
    bool operator<=(const MyKeyStruct& other) const noexcept { return operator<(other) || operator==(other); }
    bool operator>(const MyKeyStruct& other) const noexcept { return !operator<=(other); }
    bool operator>=(const MyKeyStruct& other) const noexcept { return !operator<(other); }

    ...
};
```

# Struct numeration
Struct type numbers are automatically increased until you provide it manually.
There are two possibilities:
1. Shift the current struct type number using '(+X)' suffix. As the result
   all new structs will have incremented type.
2. Force set struct type number using '(X)' of '(base)' suffix. It will
   affect only one struct.

Example below demonstrates the idea:
```proto
// Package declaration. Offset is 0.
package proto

// Struct type number is 1 (implicit declared)
struct Struct1
{
    ...
}

// Struct type number is 2 (implicit declared)
struct Struct2
{
    ...
}

// Struct type number is 10 (explicit declared, shifted to 10)
struct Struct10(+10)
{
    ...
}

// Struct type number is 11 (implicit declared)
struct Struct11
{
    ...
}

// Struct type number is 100 (explicit declared, forced to 100)
struct Struct100(100)
{
    ...
}

// Struct type number is 12 (implicit declared)
struct Struct12
{
    ...
}
```

# Struct inheritance
Structs can be inherited from another struct. In this case all fields from the
base struct will be present in a child one.
```proto
package proto

// Struct type number is 1
struct StructBase
{
    bool f1;
    int8 f2;
}

// Struct type number is 2
struct StructChild : StructBase
{
    // bool f1 - will be inherited from StructBase
    // int8 f2 - will be inherited from StructBase
    int16 f3;
    int32 f4;
}
```

Also it is possible to reuse the base struct type number in a child one using
'= base' operator. It is useful when you extend the struct from third-party
imported package:
```proto
// Package declaration. Offset is 10.
package protoex offset 10

// Package import
import proto

// Struct type number is 1
struct StructChild(base) : proto.StructBase
{
    // bool f1 - will be inherited from proto.StructBase
    // int8 f2 - will be inherited from proto.StructBase
    int16 f3;
    int32 f4;
}
```

# Versioning
Versioning is simple with Fast Binary Encoding.

Assume you have an original protocol:
```proto
package proto

enum MyEnum
{
    value1;
    value2;
}

flags MyFlags
{
    none = 0x00;
    flag1 = 0x01;
    flag2 = 0x02;
    flag3 = 0x04;
}

struct MyStruct
{
    bool field1;
    byte field2;
    char field3;
}
```

You need to extend it with new enum, flag and struct values. Just add required
values to the end of the corresponding declarations:
```proto
package proto

enum MyEnum
{
    value1;
    value2;
    value3; // New value
    value4; // New value
}

flags MyFlags
{
    none = 0x00;
    flag1 = 0x01;
    flag2 = 0x02;
    flag3 = 0x04;
    flag4 = 0x08; // New value
    flag5 = 0x10; // New value
}

struct MyStruct
{
    bool field1;
    byte field2;
    char field3;
    int32 field4;          // New field (default value is 0)
    int64 field5 = 123456; // New field (default value is 123456)
}
```

Now you can serialize and deserialize structs in different combinations:
* Serialize old, deserialize old - nothing will be lost (best case);
* Serialize old, deserialize new - all old fields will be deserialized, all new
  fields will be initialized with 0 or default values according to definition;
* Serialize new, deserialize old - all old fields will be deserialized, all new
  fields will be discarded;
* Serialize new, deserialize new - nothing will be lost (best case);

### Versioning of the third-party protocol
If you are not able to modify some third-party protocol, you can still have a
solution of extending it. Just create a new protocol and import third-party
one into it. Then extend structs with inheritance:
```proto
package protoex

import proto

struct MyStructEx(base) : proto.MyStruct
{
    int32 field4;          // New field (default value is 0)
    int64 field5 = 123456; // New field (default value is 123456)
}
```

# Sender/Receiver protocol
If the domain model compiled with [--sender](#generate-domain-model) flag,
then Sender/Receiver protocol code will be generated.

Sender interface contains 'send(struct)' methods for all domain model structs.
Also it has abstract 'onSend(data, size)' method which should be implemented
to send serialized data to a socket, pipe, etc.

Receiver interface contains 'onReceive(struct)' handlers for all domain
model structs. Also it has public 'onReceive(type, data, size)' method
which should be used to feed the Receiver with received data from a socket,
pipe, etc.

Here is an exmple of using Sender/Receiver communication protocol in C++ language:
```c++
#include "../proto/proto_protocol.h"

#include <iostream>

class MySender : public FBE::proto::Sender<FBE::WriteBuffer>
{
protected:
    size_t onSend(const void* data, size_t size) override
    {
        // Send nothing...
        return 0;
    }

    void onSendLog(const std::string& message) const override
    {
        std::cout << "onSend: " << message << std::endl;
    }
};

class MyReceiver : public FBE::proto::Receiver<FBE::WriteBuffer>
{
protected:
    void onReceive(const proto::Order& value) override {}
    void onReceive(const proto::Balance& value) override {}
    void onReceive(const proto::Account& value) override {}

    void onReceiveLog(const std::string& message) const override
    {
        std::cout << "onReceive: " << message << std::endl;
    }
};

int main(int argc, char** argv)
{
    MySender sender;

    // Enable logging
    sender.logging(true);

    // Create and send a new order
    proto::Order order = { 1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0 };
    sender.send(order);

    // Create and send a new balance wallet
    proto::Balance balance = { "USD", 1000.0 };
    sender.send(balance);

    // Create and send a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    sender.send(account);

    MyReceiver receiver;

    // Enable logging
    receiver.logging(true);

    // Receive all data from the sender
    receiver.receive(sender.buffer().data(), sender.buffer().size());

    return 0;
}
```

Output is the following:
```
onSend: Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000)
onSend: Balance(currency="USD",amount=1000)
onSend: Account(uid=1,name="Test",state=initialized|calculated|good,wallet=Balance(currency="USD",amount=1000),asset=Balance(currency="EUR",amount=100),orders=[3][Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000),Order(uid=2,symbol="EURUSD",side=sell,type=limit,price=1,volume=100),Order(uid=3,symbol="EURUSD",side=buy,type=stop,price=1.5,volume=10)])
onReceive: Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000)
onReceive: Balance(currency="USD",amount=1000)
onReceive: Account(uid=1,name="Test",state=initialized|calculated|good,wallet=Balance(currency="USD",amount=1000),asset=Balance(currency="EUR",amount=100),orders=[3][Order(uid=1,symbol="EURUSD",side=buy,type=market,price=1.23456,volume=1000),Order(uid=2,symbol="EURUSD",side=sell,type=limit,price=1,volume=100),Order(uid=3,symbol="EURUSD",side=buy,type=stop,price=1.5,volume=10)])
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
* [Go benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Go/benchmarks) results were taken using [testing package](https://golang.org/pkg/testing)
* [Java benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Java/src/benchmarks) results were taken using [JMH library](http://openjdk.java.net/projects/code-tools/jmh)
* [JavaScript benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/JavaScript/benchmarks) results were taken using [Benchmark.js library](https://benchmarkjs.com)
* [Kotlin benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Kotlin/src/benchmarks) results were taken using [JMH library](http://openjdk.java.net/projects/code-tools/jmh)
* [Python benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Python/benchmarks) results were taken using [timeit module](https://docs.python.org/3/library/timeit.html)
* [Ruby benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Ruby/benchmarks) results were taken using [Benchmark module](http://ruby-doc.org/stdlib/libdoc/benchmark/rdoc/Benchmark.html)
* [Swift benchmarks](https://github.com/chronoxor/FastBinaryEncoding/tree/master/projects/Swift/Tests/Benchmark) results were taken using [XCTest framework](https://developer.apple.com/documentation/xctest/xctestcase/1496290-measure)

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

| Language & Platform      | Message size | Serialization rate | Serialization time |
| :----------------------- | -----------: | -----------------: | -----------------: |
| C++ Win64                |    252 bytes |   10 416 667 ops/s |              96 ns |
| C++ Win64 (Final)        |    152 bytes |   16 129 032 ops/s |              62 ns |
| C++ Win64 (JSON)         |    353 bytes |      926 784 ops/s |           1 079 ns |
| C# Win64                 |    252 bytes |    1 432 665 ops/s |             698 ns |
| C# Win64 (Final)         |    152 bytes |    1 597 444 ops/s |             626 ns |
| C# Win64 (JSON)          |    341 bytes |      434 783 ops/s |           2 300 ns |
| Go Win64                 |    252 bytes |    2 739 726 ops/s |             365 ns |
| Go Win64 (Final)         |    152 bytes |    2 949 852 ops/s |             339 ns |
| Go Win64 (JSON)          |    341 bytes |      258 732 ops/s |           3 865 ns |
| Java Win64               |    252 bytes |    4 247 162 ops/s |             236 ns |
| Java Win64 (Final)       |    152 bytes |    4 883 205 ops/s |             205 ns |
| Java Win64 (JSON)        |    353 bytes |      213 983 ops/s |           4 673 ns |
| JavaScript Win64         |    252 bytes |       93 416 ops/s |          10 705 ns |
| JavaScript Win64 (Final) |    152 bytes |      112 665 ops/s |           8 876 ns |
| JavaScript Win64 (JSON)  |    341 bytes |      217 637 ops/s |           4 595 ns |
| Kotlin Win64             |    252 bytes |    3 546 694 ops/s |             282 ns |
| Kotlin Win64 (Final)     |    152 bytes |    4 096 406 ops/s |             244 ns |
| Kotlin Win64 (JSON)      |    353 bytes |      185 788 ops/s |           5 382 ns |
| Python Win64             |    252 bytes |        9 434 ops/s |         105 999 ns |
| Python Win64 (Final)     |    152 bytes |       11 635 ops/s |          85 945 ns |
| Python Win64 (JSON)      |    324 bytes |       61 737 ops/s |          16 198 ns |
| Ruby Win64               |    252 bytes |       23 013 ops/s |          43 453 ns |
| Ruby Win64 (Final)       |    152 bytes |       33 361 ops/s |          29 975 ns |
| Ruby Win64 (JSON)        |    353 bytes |       50 842 ops/s |          19 669 ns |
| Swift macOS              |    252 bytes |       74 002 ops/s |          13 513 ns |
| Swift macOS (Final)      |    152 bytes |      100 755 ops/s |           9 925 ns |
| Swift macOS (JSON)       |    353 bytes |       18 534 ops/s |          53 953 ns |

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

| Language & Platform      | Message size | Deserialization rate | Deserialization time |
| :----------------------- | -----------: | -------------------: | -------------------: |
| C++ Win64                |    252 bytes |      9 523 810 ops/s |               105 ns |
| C++ Win64 (Final)        |    152 bytes |     10 989 011 ops/s |                91 ns |
| C++ Win64 (JSON)         |    353 bytes |      1 375 516 ops/s |               727 ns |
| C# Win64                 |    252 bytes |      1 014 199 ops/s |               986 ns |
| C# Win64 (Final)         |    152 bytes |      1 607 717 ops/s |               622 ns |
| C# Win64 (JSON)          |    341 bytes |        258 532 ops/s |             3 868 ns |
| Go Win64                 |    252 bytes |      1 510 574 ops/s |               662 ns |
| Go Win64 (Final)         |    152 bytes |      1 540 832 ops/s |               649 ns |
| Go Win64 (JSON)          |    341 bytes |        251 825 ops/s |             3 971 ns |
| Java Win64               |    252 bytes |      2 688 084 ops/s |               372 ns |
| Java Win64 (Final)       |    152 bytes |      3 036 020 ops/s |               329 ns |
| Java Win64 (JSON)        |    353 bytes |        308 675 ops/s |             3 240 ns |
| JavaScript Win64         |    252 bytes |        133 892 ops/s |             7 469 ns |
| JavaScript Win64 (Final) |    152 bytes |        292 273 ops/s |             3 422 ns |
| JavaScript Win64 (JSON)  |    341 bytes |        289 417 ops/s |             3 455 ns |
| Kotlin Win64             |    252 bytes |      2 280 923 ops/s |               438 ns |
| Kotlin Win64 (Final)     |    152 bytes |      2 652 728 ops/s |               277 ns |
| Kotlin Win64 (JSON)      |    353 bytes |        250 524 ops/s |             3 992 ns |
| Python Win64             |    252 bytes |          8 305 ops/s |           120 411 ns |
| Python Win64 (Final)     |    152 bytes |         11 661 ops/s |            85 758 ns |
| Python Win64 (JSON)      |    324 bytes |         48 859 ops/s |            20 467 ns |
| Ruby Win64               |    252 bytes |         24 351 ops/s |            41 066 ns |
| Ruby Win64 (Final)       |    152 bytes |         33 555 ops/s |            29 802 ns |
| Ruby Win64 (JSON)        |    353 bytes |         42 860 ops/s |            23 331 ns |
| Swift macOS              |    252 bytes |         86 288 ops/s |            11 589 ns |
| Swift macOS (Final)      |    152 bytes |        10 3519 ops/s |             9 660 ns |
| Swift macOS (JSON)       |    353 bytes |         17 077 ops/s |            58 558 ns |

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

| Language & Platform      | Message size |      Verify rate | Verify time |
| :----------------------- | -----------: | ---------------: | ----------: |
| C++ Win64                |    252 bytes | 31 250 000 ops/s |       32 ns |
| C++ Win64 (Final)        |    152 bytes | 35 714 286 ops/s |       28 ns |
| C# Win64                 |    252 bytes |  4 504 505 ops/s |      222 ns |
| C# Win64 (Final)         |    152 bytes |  8 064 516 ops/s |      124 ns |
| Go Win64                 |    252 bytes |  8 474 576 ops/s |      118 ns |
| Go Win64 (Final)         |    152 bytes |  9 090 909 ops/s |      110 ns |
| Java Win64               |    252 bytes | 11 790 374 ops/s |       85 ns |
| Java Win64 (Final)       |    152 bytes | 16 205 533 ops/s |       62 ns |
| JavaScript Win64         |    252 bytes |  1 105 627 ops/s |      905 ns |
| JavaScript Win64 (Final) |    152 bytes |  5 700 408 ops/s |      175 ns |
| Kotlin Win64             |    252 bytes |  8 625 935 ops/s |      116 ns |
| Kotlin Win64 (Final)     |    152 bytes | 13 373 757 ops/s |       75 ns |
| Python Win64             |    252 bytes |     20 825 ops/s |   48 019 ns |
| Python Win64 (Final)     |    152 bytes |     23 590 ops/s |   42 391 ns |
| Ruby Win64               |    252 bytes |     57 201 ops/s |   17 482 ns |
| Ruby Win64 (Final)       |    152 bytes |     74 262 ops/s |   13 466 ns |
| Swift macOS              |    252 bytes |    164 446 ops/s |    6 081 ns |
| Swift macOS (Final)      |    152 bytes |    228 154 ops/s |    4 383 ns |
