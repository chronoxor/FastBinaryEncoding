// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.8.0.0

package com.chronoxor.enums;

public enum EnumUInt64Enum
{
    ENUM_VALUE_0((long)0L + 0)
    , ENUM_VALUE_1((long)0L + 0)
    , ENUM_VALUE_2((long)0L + 1)
    , ENUM_VALUE_3((long)0xFFFFFFFFFFFFFFFEL + 0)
    , ENUM_VALUE_4((long)0xFFFFFFFFFFFFFFFEL + 1)
    , ENUM_VALUE_5(ENUM_VALUE_3.getRaw())
    ;

    private long value;

    EnumUInt64Enum(long value) { this.value = value; }
    EnumUInt64Enum(int value) { this.value = (long)value; }
    EnumUInt64Enum(EnumUInt64Enum value) { this.value = value.value; }

    public long getRaw() { return value; }

    public static EnumUInt64Enum mapValue(long value) { return mapping.get(value); }

    @Override
    public String toString()
    {
        if (this == ENUM_VALUE_0) return "ENUM_VALUE_0";
        if (this == ENUM_VALUE_1) return "ENUM_VALUE_1";
        if (this == ENUM_VALUE_2) return "ENUM_VALUE_2";
        if (this == ENUM_VALUE_3) return "ENUM_VALUE_3";
        if (this == ENUM_VALUE_4) return "ENUM_VALUE_4";
        if (this == ENUM_VALUE_5) return "ENUM_VALUE_5";
        return "<unknown>";
    }

    private static final java.util.Map<Long, EnumUInt64Enum> mapping = new java.util.HashMap<>();
    static
    {
        for (var value : EnumUInt64Enum.values())
            mapping.put(value.value, value);
    }
}
