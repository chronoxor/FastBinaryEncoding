//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.enums

@Suppress("EnumEntryName", "MemberVisibilityCanBePrivate", "RemoveRedundantCallsOfConversionMethods")
enum class EnumWCharEnum
{
    ENUM_VALUE_0(0 + 0)
    , ENUM_VALUE_1(0x0444 + 0)
    , ENUM_VALUE_2(0x0444 + 1)
    , ENUM_VALUE_3(0x0555 + 0)
    , ENUM_VALUE_4(0x0555 + 1)
    , ENUM_VALUE_5(ENUM_VALUE_3.raw)
    ;

    var raw: Int = 0
        private set

    constructor(value: Char) { this.raw = value.code.toInt() }
    constructor(value: Byte) { this.raw = value.toInt() }
    constructor(value: Short) { this.raw = value.toInt() }
    constructor(value: Int) { this.raw = value.toInt() }
    constructor(value: Long) { this.raw = value.toInt() }
    constructor(value: EnumWCharEnum) { this.raw = value.raw }

    override fun toString(): String
    {
        if (this == ENUM_VALUE_0) return "ENUM_VALUE_0"
        if (this == ENUM_VALUE_1) return "ENUM_VALUE_1"
        if (this == ENUM_VALUE_2) return "ENUM_VALUE_2"
        if (this == ENUM_VALUE_3) return "ENUM_VALUE_3"
        if (this == ENUM_VALUE_4) return "ENUM_VALUE_4"
        if (this == ENUM_VALUE_5) return "ENUM_VALUE_5"
        return "<unknown>"
    }

    companion object
    {
        private val mapping = java.util.HashMap<Int, EnumWCharEnum>()

        init
        {
            for (value in EnumWCharEnum.values())
                mapping[value.raw] = value
        }

        fun mapValue(value: Int): EnumWCharEnum? { return mapping[value] }
    }
}
