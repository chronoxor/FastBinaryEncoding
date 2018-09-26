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

## byte

![byte](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/byte.png)

## char, wchar

![char](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/char.png)

![wchar](https://github.com/chronoxor/FastBinaryEncoding/raw/master/images/wchar.png)

## int8, uint8, int16, uint16, int32, uint32, int64, uint64

## float, double
