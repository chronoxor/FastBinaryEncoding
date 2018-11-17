# Fast Binary Encoding (FBE) format specification

Fast Binary Encoding (FBE) format describes domain model with as a set of
enums, flags and structs. Structs fields are described with base or complex
types, optional fields and collections.

Example of the domain model:
```proto
// Package declaration
package proto

// Order side declaration
enum OrderSide
{
    buy;
    sell;
}

// Order type declaration
enum OrderType
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
flags State
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

# Contents
  * [Base types](#base-types)
    * [bool](#bool)
    * [byte](#byte)
    * [char, wchar](#char-wchar)
    * [int8, uint8, int16, uint16, int32, uint32, int64, uint64](#int8-uint8-int16-uint16-int32-uint32-int64-uint64)
    * [float, double](#float-double)
  * [Complex types](#complex-types)
    * [bytes](#bytes)
    * [decimal](#decimal)
    * [string](#string)
    * [timestamp](#timestamp)
    * [uuid](#uuid)
  * [Collections](#collections)
    * [array](#array)
    * [vector](#vector)
    * [list](#list)
    * [map](#map)
    * [hash](#hash)
  * [Optional type](#optional-type)
  * [Enums](#enums)
  * [Flags](#flags)
  * [Structs](#structs)

# Base types

## bool

![bool](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bool.png)

Properties:
* Size = 1 byte
* Default value = 0
* Min value = 0
* Max value = 1
* Constants:
  * false = 0
  * true = 1

Examples:
```proto
bool field1;
bool field2 = false;
bool field3 = true;
```

## byte

![byte](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/byte.png)

Properties:
* Size = 1 byte
* Default value = 0
* Min value = 0
* Max value = 255
* Unsigned

Examples:
```proto
byte field1;
byte field2 = 0;
byte field3 = 128;
byte field4 = 0xFF;
```

## char, wchar

![char](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/char.png)

Properties:
* Size = 1 byte
* Default value = 0
* Min value = 0
* Max value = 255
* Unsigned

Examples:
```proto
char field1;
char field2 = 48;
char field3 = 0x41;
char field4 = '!';
```

![wchar](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/wchar.png)

Properties:
* Size = 4 bytes
* Default value = 0
* Min value = 0
* Max value = 0xFFFFFFFF
* Little-endian
* Unsigned

Examples:
```proto
wchar field1;
wchar field2 = 1025;
wchar field3 = 0x0410;
wchar field4 = '!';
```

## int8, uint8, int16, uint16, int32, uint32, int64, uint64

![int8](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/int8.png)

int8 properties:
* Size = 1 byte
* Default value = 0
* Min value = -128
* Max value = 127
* Signed

Examples:
```proto
int8 field1;
int8 field2 = 0;
int8 field3 = -128;
int8 field4 = 127;
```

uint8 properties:
* Size = 1 byte
* Default value = 0
* Min value = 0
* Max value = 255
* Unsigned

Examples:
```proto
uint8 field1;
uint8 field2 = 0;
uint8 field3 = 128;
uint8 field4 = 0xFF;
```

![int16](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/int16.png)

int16 properties:
* Size = 2 bytes
* Default value = 0
* Min value = -32768
* Max value = 32767
* Little-endian
* Signed

Examples:
```proto
int16 field1;
int16 field2 = 0;
int16 field3 = -32768;
int16 field4 = 32767;
```

uint16 properties:
* Size = 2 bytes
* Default value = 0
* Min value = 0
* Max value = 65535
* Little-endian
* Unsigned

Examples:
```proto
uint16 field1;
uint16 field2 = 0;
uint16 field3 = 32768;
uint16 field4 = 0xFFFF;
```

![int32](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/int32.png)

int32 properties:
* Size = 4 bytes
* Default value = 0
* Min value = -2147483648
* Max value = 2147483647
* Little-endian
* Signed

Examples:
```proto
int32 field1;
int32 field2 = 0;
int32 field3 = -2147483648;
int32 field4 = 2147483647;
```

uint32 properties:
* Size = 4 bytes
* Default value = 0
* Min value = 0
* Max value = 4294967295
* Little-endian
* Unsigned

Examples:
```proto
uint32 field1;
uint32 field2 = 0;
uint32 field3 = 2147483648;
uint32 field4 = 0xFFFFFFFF;
```

![int64](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/int64.png)

int64 properties:
* Size = 8 bytes
* Default value = 0
* Min value = -9223372036854775808
* Max value = 9223372036854775807
* Little-endian
* Signed

Examples:
```proto
int64 field1;
int64 field2 = 0;
int64 field3 = -9223372036854775808;
int64 field4 = 9223372036854775807;
```

uint64 properties:
* Size = 8 bytes
* Default value = 0
* Min value = 0
* Max value = 18446744073709551615
* Little-endian
* Unsigned

Examples:
```proto
uint64 field1;
uint64 field2 = 0;
uint64 field3 = 9223372036854775808;
uint64 field4 = 0xFFFFFFFFFFFFFFFF;
```

## float, double

![float](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/float.png)

float properties:
* Size = 4 bytes
* Default value = 0.0
* Min value = 1.175494351e-38
* Max value = 3.402823466e+38
* Little-endian
* Signed

Examples:
```proto
float field1;
float field2 = 0.0;
float field3 = -123.456;
float field4 = 123.456e+12;
```

![double](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/double.png)

double properties:
* Size = 8 bytes
* Default value = 0.0
* Min value = 2.2250738585072014e-308
* Max value = 1.7976931348623158e+308
* Little-endian
* Signed

Examples:
```proto
double field1;
double field2 = 0.0;
double field3 = -123.456;
double field4 = 123.456e+123;
```

# Complex types

## bytes

Represents a byte array that can be changed in user code.
Works like a [BLOB](https://en.wikipedia.org/wiki/Binary_large_object) that
can be changed in random index.

*Implementation of the bytes type depends on equivalent type in each
programming language (e.g. std::vector<uint8_t> in C++, byte[] in C#
and Java).*

![bytes](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bytes.png)

bytes properties:
* Size = 8 + N bytes

Examples:
```proto
bytes field1;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![bytes-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bytes-final.png)

Final model bytes properties:
* Size = 4 + N bytes

## decimal

A decimal number is a floating-point value that consists of a sign, a numeric
value where each digit in the value ranges from 0 to 9, and a scaling factor
that indicates the position of a floating decimal point that separates the
integral and fractional parts of the numeric value.

The binary representation of a Decimal value consists of a 1-bit sign,
a 96-bit integer number, and a scaling factor used to divide the 96-bit
integer and specify what portion of it is a decimal fraction.

The scaling factor is implicitly the number 10, raised to an exponent ranging
from 0 to 28. Therefore, the binary representation of a decimal value the form,
((-29^6 to 29^6) / 10^(0 to 28)), where -(2^96-1) is equal to min value, and
2^96-1 is equal to max value.

![decimal](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/decimal.png)

decimal properties:
* Equivalent of the [.NET Decimal type](https://docs.microsoft.com/en-us/dotnet/api/system.decimal)
* Size = 16 bytes
* Default value = 0
* Min value = -79228162514264337593543950335
* Max value = 79228162514264337593543950335
* Little-endian
* Signed

Examples:
```proto
decimal field1;
decimal field2 = 0.0;
decimal field3 = 123456.123456;
```

References:
* [Decimal Struct](https://docs.microsoft.com/en-us/dotnet/api/system.decimal)

## string

Represents a string as an array of bytes in [UTF8 encoding](https://en.wikipedia.org/wiki/UTF-8).

*Implementation of the string type depends on equivalent type in each
programming language (e.g. std::string in C++, String class in C# and
Java).*

![string](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string.png)

string properties:
* Encoding = [UTF8](https://en.wikipedia.org/wiki/UTF-8)
* Size = 8 + N bytes

Examples:
```proto
string field1;
string field2 = "";
string field3 = "Initial string";
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![string-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string-final.png)

Final model string properties:
* Size = 4 + N bytes

## timestamp

Represents a timestamp as 64-bit count of nanoseconds from the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time).
Timestamp range is enough to store any timestamp value from 1970 to 2554 year
in nanoseconds (2^64 nanoseconds is ~584.554531 years).

*Implementation of the timestamp type depends on equivalent type in each
programming language (e.g. uint64_t in C++, DateTime struct in C#, Instant
class in Java).*

![timestamp](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/timestamp.png)

timestamp properties:
* Resolution: nanoseconds
* Size = 8 bytes
* Default value = 0
* Min value = 0 (1970-01-01T00:00:00Z)
* Max value = 18446744073709551615 (2554-07-21T23:34:33Z and 709551615ns)
* Constants:
  * epoch = [Unix epoch](https://en.wikipedia.org/wiki/Unix_time) (1970-01-01T00:00:00Z)
  * utc = Current timestamp in UTC
* Little-endian
* Unsigned

Examples:
```proto
timestamp field1;
timestamp field2 = epoch;
timestamp field3 = now;
```

## uuid

A universally unique identifier (uuid) is a 128-bit number used to identify
information in computer systems.

Supported uuid types:
* Nil UUID0 (all bits set to zero)
* Sequential UUID1 (time based version)
* Random UUID4 (randomly or pseudo-randomly generated version)

*Implementation of the uuid type depends on equivalent type in each
programming language (e.g. custom uuid_t in C++, Guid in C#, UUID in
Java).*

![uuid](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/uuid.png)

In its canonical textual representation, the sixteen octets of a uuid are
represented as 32 hexadecimal (base 16) digits, displayed in five groups
separated by hyphens, in the form 8-4-4-4-12 for a total of 36 characters
(32 alphanumeric characters and four hyphens). For example:

```
123e4567-e89b-12d3-a456-426655440000
xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx
```

The four bits of digit M indicate the uuid version, and the one to three
most significant bits of digit N indicate the uuid variant. In the example,
M is 1 and N is a (10xx), meaning that the uuid is a variant 1, version 1
uuid; that is, a time-based DCE/RFC 4122 uuid.

The canonical 8-4-4-4-12 format string is based on the "record layout" for
the 16 bytes of the uuid:

| Field               | Size    | Comments                                                                                 |
| :------------------ | :------ | :--------------------------------------------------------------------------------------- |
| Time low            | 4 bytes | Integer giving the low 32 bits of the time                                               |
| Time mid            | 2 bytes | Integer giving the middle 16 bits of the time                                            |
| Time hi and version | 2 bytes | 4-bit "version" in the most significant bits, followed by the high 12 bits of the time   |
| Clock sequence      | 2 bytes | 1-3 bit "variant" in the most significant bits, followed by the 13-15 bit clock sequence |
| Node                | 6 bytes | 48-bit Node Id                                                                           |

**All fields are stored in big-endian format!**

uuid properties:
* Size = 16 bytes
* Default value = UUID0 (00000000-0000-0000-0000-000000000000)
* Constants:
  * uuid0 = Nil UUID0
  * uuid1 = Sequential UUID1
  * uuid4 = Random UUID4

Examples:
```proto
uuid field1;
uuid field2 = uuid0;
uuid field3 = uuid1;
uuid field4 = uuid4;
uuid field5 = "123e4567-e89b-12d3-a456-426655440000";
```

References:
* [Universally unique identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier)
* [RFC 4122: A Universally Unique IDentifier (UUID) URN Namespace](https://tools.ietf.org/html/rfc4122)

# Collections

## array

Represents a fixed size array of the given type.

*Implementation of the array type depends on equivalent type in each
programming language (e.g. std::array<T, N> in C++, T[] in C# and Java).*

![array](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/array.png)

array properties:
* Size = N * sizeof(T)

Examples:
```proto
byte[2] field1;
string?[4] field2;
MyEnum[8] field3;
MyStruct?[16] field4;
```

## vector

Represents a dynamic size vector of the given type.

*Implementation of the vector type depends on equivalent type in each
programming language (e.g. std::vector<T> in C++, List<T> in C#, ArrayList<T>
in Java).*

![vector](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/vector.png)

vector properties:
* Size = 8 + N * sizeof(T)

Examples:
```proto
byte[] field1;
string?[] field2;
MyEnum[] field3;
MyStruct?[] field4;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![vector-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/vector-final.png)

Final model vector properties:
* Size = 4 + N * sizeof(T)

## list

Represents a linked list of the given type.

*Implementation of the list type depends on equivalent type in each
programming language (e.g. std::list<T> in C++, LinkedList<T> in C#
and Java).*

![list](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/list.png)

list properties:
* Size = 8 + N * sizeof(T)

Examples:
```proto
byte() field1;
string?() field2;
MyEnum() field3;
MyStruct?() field4;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![list-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/list-final.png)

Final model list properties:
* Size = 4 + N * sizeof(T)

## map

Represents an associative map of the given type.

*Implementation of the map type depends on equivalent type in each
programming language (e.g. std::map<K, V> in C++, SortedDictionary<K, V>
in C#, TreeMap<K, V> in Java).*

![map](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/map.png)

map properties:
* Size = 8 + N * (sizeof(K) + sizeof(V))

Examples:
```proto
byte<int32> field1;
string?<string> field2;
MyEnum<uuid> field3;
MyStruct?<MyKey> field4;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![map-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/map-final.png)

Final model map properties:
* Size = 4 + N * sizeof(T)

## hash

Represents an associative hash table of the given type.

*Implementation of the hash type depends on equivalent type in each
programming language (e.g. std::unordered_map<K, V> in C++, Dictionary<K, V>
in C#, HashMap<K, V> in Java).*

![hash](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/hash.png)

hash properties:
* Size = 8 + N * (sizeof(K) + sizeof(V))

Examples:
```proto
byte{int32} field1;
string?{string} field2;
MyEnum{uuid} field3;
MyStruct?{MyKey} field4;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![hash-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/hash-final.png)

Final model hash properties:
* Size = 4 + N * sizeof(T)

# Optional type

Represents an optional wrapper of the given type.

*Implementation of the optional type depends on equivalent type in each
programming language (e.g. std::optional<T> in C++, Nullable<T> struct
or any reference type in C#, reference type in Java).*

![optional](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/optional.png)

optional properties:
* Size = 5 | 5 + sizeof(T)

Examples:
```proto
byte? field1;
int32? field2 = 0;
string? field3 = "Initial string";
uuid? field4 = null;
MyEnum? field5 = null;
MyStruct? field6 = null;
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![optional-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/optional-final.png)

Final model optional properties:
* Size = 1 | 1 + sizeof(T)

# Enums

Represents an enumerable data type. It contains several identificators with
incremental values or given integer constants.

![enum](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/enum.png)

By default the enum identificator starts from 0 and increments by 1. It is
possible to provide a custom valid enum value for any identificator or
even some existing enum identificator.

Examples:
```proto
// Default enum declaration (enum type is int32)
enum MyEnum
{
    value0;          // value0 ==  0
    value1;          // value1 ==  1
    value2;          // value2 ==  2
    value3 = -2;     // value3 == -2
    value4;          // value4 == -1
    value5;          // value5 ==  0
    value6 = 10;     // value6 == 10
    value7;          // value7 == 11
    value8;          // value8 == 12
    value9 = value1; // value9 ==  1
    value10;         // value10 == 2
    value11;         // value11 == 3
}

// byte enum declaration
enum MyByteEnum : byte
{
    value0;          // value0 == 0
    value1 = 0;      // value1 == 0
    value2;          // value2 == 1
    value3 = 254;    // value3 == 254
    value4;          // value4 == 255
    value5 = value3; // value5 == 254
}

// char enum declaration
enum MyCharEnum : char
{
    value0;          // value0 ==  0
    value1 = '1';    // value1 == '1'
    value2;          // value2 == '2'
    value3 = '3';    // value3 == '3'
    value4;          // value4 == '4'
    value5 = value3; // value5 == '3'
}
```

# Flags

Represents a bit flags data type. It contains several identificators with
their bits values.

![flags](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/flags.png)

All flags identificators must have values!

Examples:
```proto
// Default flags declaration (flags type is int32)
enum MyFlags
{
    flag0 = 0x00;                    // flag0 == 0x00
    flag1 = 0x01;                    // flag1 == 0x01
    flag2 = 0x02;                    // flag2 == 0x02
    flag4 = 0x04;                    // flag4 == 0x04
    flagc = flag2;                   // flagc == 0x02
    flags = flag1 | flag4;           // flags == 0x05
}

// uint64 flags declaration
enum MyUInt64Flags : uint64
{
    flag0  = 0x00;                   // flag0  == 0x00
    flag1  = 0x01;                   // flag1  == 0x01
    flag2  = 0x02;                   // flag2  == 0x02
    flag4  = 0x04;                   // flag4  == 0x04
    flag8  = 0x08;                   // flag8  == 0x08
    flag16 = 0x10;                   // flag16 == 0x10
    flag32 = 0x20;                   // flag32 == 0x20
    flag64 = 0x40;                   // flag64 == 0x40
    flagc  = flag4;                  // flagc  == 0x04
    flags  = flag2 | flag8 | flag32; // flags  == 0x2A
}
```

# Structs

Represents a struct data type. It aggregates several fields of different
types into one logic structure. Moreover structs can be extended using
inheritance.

[Struct keys](../README.md#struct-keys)<br/>
[Struct numeration](../README.md#struct-numeration)<br/>
[Struct inheritance](../README.md#struct-inheritance)<br/>

*Implementation of the struct type depends on equivalent type in each
programming language (e.g. struct in C++ and C#, class in Java).*

Schema legend:
* **Root struct** is a top level struct serialized in buffer;
* **Inner struct** is a struct serialized as a field value. FBE supports any
  depth of struct nesting;

![struct](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/struct.png)

struct properties:
* Root struct size = 16 + sizeof(fileds)
* Inner struct size = 12 + sizeof(fileds)

Examples:
```proto
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

[Final model](../README.md#fbe-final-serialization) is more compact, but you
will loose [versioning](../README.md#versioning) and the possibility to extend
the struct with new fields:

![struct-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/struct-final.png)

Final model struct properties:
* Root struct size = 8 + sizeof(fileds)
* Inner struct size = sizeof(fileds)
* [More compact and fast](../README.md#fbe-final-serialization)
