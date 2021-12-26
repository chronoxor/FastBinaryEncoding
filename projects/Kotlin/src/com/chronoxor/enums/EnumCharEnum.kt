// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.8.0.0

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.enums

@Suppress("EnumEntryName", "MemberVisibilityCanBePrivate", "RemoveRedundantCallsOfConversionMethods")
enum class EnumCharEnum
{
    ENUM_VALUE_0(0 + 0)
    , ENUM_VALUE_1('1' + 0)
    , ENUM_VALUE_2('1' + 1)
    , ENUM_VALUE_3('3' + 0)
    , ENUM_VALUE_4('3' + 1)
    , ENUM_VALUE_5(ENUM_VALUE_3.raw)
    ;

    var raw: Byte = 0
        private set

    constructor(value: Char) { this.raw = value.toByte() }
    constructor(value: Byte) { this.raw = value.toByte() }
    constructor(value: Short) { this.raw = value.toByte() }
    constructor(value: Int) { this.raw = value.toByte() }
    constructor(value: Long) { this.raw = value.toByte() }
    constructor(value: EnumCharEnum) { this.raw = value.raw }

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
        private val mapping = java.util.HashMap<Byte, EnumCharEnum>()

        init
        {
            for (value in EnumCharEnum.values())
                mapping[value.raw] = value
        }

        fun mapValue(value: Byte): EnumCharEnum? { return mapping[value] }
    }
}
