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
byte field4 = 255;
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

## float, double
