//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.enums

@Suppress("MemberVisibilityCanBePrivate", "RemoveRedundantCallsOfConversionMethods")
class EnumUInt32 : Comparable<EnumUInt32>
{
    companion object
    {
        val ENUM_VALUE_0 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_0)
        val ENUM_VALUE_1 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_1)
        val ENUM_VALUE_2 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_2)
        val ENUM_VALUE_3 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_3)
        val ENUM_VALUE_4 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_4)
        val ENUM_VALUE_5 = EnumUInt32(EnumUInt32Enum.ENUM_VALUE_5)
    }

    var value: EnumUInt32Enum? = EnumUInt32Enum.values()[0]
        private set

    val raw: UInt
        get() = value!!.raw

    constructor()
    constructor(value: UInt) { setEnum(value) }
    constructor(value: EnumUInt32Enum) { setEnum(value) }
    constructor(value: EnumUInt32) { setEnum(value) }

    fun setDefault() { setEnum(0.toUInt()) }

    fun setEnum(value: UInt) { this.value = EnumUInt32Enum.mapValue(value) }
    fun setEnum(value: EnumUInt32Enum) { this.value = value }
    fun setEnum(value: EnumUInt32) { this.value = value.value }

    override fun compareTo(other: EnumUInt32): Int
    {
        if (value == null)
            return -1
        if (other.value == null)
            return 1
        return (value!!.raw - other.value!!.raw).toInt()
    }

    override fun equals(other: Any?): Boolean
    {
        if (other == null)
            return false

        if (!EnumUInt32::class.java.isAssignableFrom(other.javaClass))
            return false

        val enm = other as EnumUInt32? ?: return false

        if (enm.value == null)
            return false
        if (value!!.raw != enm.value!!.raw)
            return false
        return true
    }

    override fun hashCode(): Int
    {
        var hash = 17
        hash = hash * 31 + if (value != null) value!!.hashCode() else 0
        return hash
    }

    override fun toString(): String
    {
        return if (value != null) value!!.toString() else "<unknown>"
    }
}
