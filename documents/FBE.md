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

Examples:
```proto
double field1;
double field2 = 0.0;
double field3 = -123.456;
double? field4 = 123.456e+123;
```

# Complex types

## bytes

![bytes](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bytes.png)

bytes properties:
* Size = 8 + N bytes

Examples:
```proto
bytes field1;
bytes? field2;
```

[Final model](../README.md#fbe-final-serialization) is more compact, but does not support
[versioning](../README.md#versioning):

![bytes-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/bytes-final.png)

Final model bytes properties:
* Size = 4 + N bytes

## decimal

![decimal](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/decimal.png)

## string

![string](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string.png)

![string-final](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/string-final.png)

## timestamp

## uuid
