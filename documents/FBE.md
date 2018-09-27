# FastBinaryEncoding format specification

FastBinaryEncoding format describes domain model with as a set of enums, flags and structs.
Structs fields are described with a base or complex types or collection.

Example of the order domain model:
```proto
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
bool? field3 = true;
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
byte? field4 = 0xFF;
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
char? field4 = '!';
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
wchar? field4 = '!';
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
int8? field4 = 127;
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
uint8? field4 = 0xFF;
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
int16? field4 = 32767;
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
uint16? field4 = 0xFFFF;
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
int32? field4 = 2147483647;
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
uint32? field4 = 0xFFFFFFFF;
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
int64? field4 = 9223372036854775807;
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
uint64? field4 = 0xFFFFFFFFFFFFFFFF;
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
float? field4 = 123.456e+12;
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
double? field4 = 123.456e+123;
```

# Complex types

## bytes

Represents the byte array with dynamic size that can be changed in user code.
Works like a [BLOB](https://en.wikipedia.org/wiki/Binary_large_object) that
can be changed by inserting or removin bytes by random index.

Implementation depends on equivalent bytes type in each programming language
(e.g. std::vector<uint8_t> in C++, byte[] in C# and Java).

![bytes](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bytes.png)

bytes properties:
* Size = 8 + N bytes

Examples:
```proto
bytes field1;
bytes? field2;
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
from 0 to 28. Therefore, the binary representation of a âecimal value the form,
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
decimal? field4 = 987654.987654;
```

## string

Represents the string as an array of bytes in [UTF8 encoding](https://en.wikipedia.org/wiki/UTF-8).

Implementation depends on equivalent string type in each programming language
(e.g. std::string in C++, String class in C# and Java).

![string](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string.png)

string properties:
* Encoding = [UTF8](https://en.wikipedia.org/wiki/UTF-8)
* Size = 8 + N bytes

Examples:
```proto
string field1;
string field2 = "";
string field3 = "Initial string";
string? field4 = "Another initial string";
```

[Final model](../README.md#fbe-final-serialization) is more compact:

![string-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string-final.png)

Final model string properties:
* Size = 4 + N bytes

## timestamp

Represents the timestamp as 64-bit count of nanoseconds from the [Unix epoch](https://en.wikipedia.org/wiki/Unix_time).
Timestamp range is enough to store any timestamp value from 1970 to 2554 year
in nanoseconds (2^64 nanoseconds is ~584.554531 years).

Implementation depends on equivalent string type in each programming language
(e.g. uint64_t in C++, DateTime struct in C#, Instant class in Java).

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
timestamp? field4 = now;
```

## uuid

![uuid](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/uuid.png)
