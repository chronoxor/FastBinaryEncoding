// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// Version: 1.8.0.0

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.test

@Suppress("MemberVisibilityCanBePrivate", "RemoveRedundantCallsOfConversionMethods")
class FlagsTyped : Comparable<FlagsTyped>
{
    companion object
    {
        val FLAG_VALUE_0 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_0)
        val FLAG_VALUE_1 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_1)
        val FLAG_VALUE_2 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_2)
        val FLAG_VALUE_3 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_3)
        val FLAG_VALUE_4 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_4)
        val FLAG_VALUE_5 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_5)
        val FLAG_VALUE_6 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_6)
        val FLAG_VALUE_7 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_7)
        val FLAG_VALUE_8 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_8)
        val FLAG_VALUE_9 = FlagsTyped(FlagsTypedEnum.FLAG_VALUE_9)

        fun fromSet(set: java.util.EnumSet<FlagsTypedEnum>): FlagsTyped
        {
            @Suppress("CanBeVal")
            var result = 0uL
            if (set.contains(FLAG_VALUE_0.value!!))
            {
                result = result.toULong() or FLAG_VALUE_0.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_1.value!!))
            {
                result = result.toULong() or FLAG_VALUE_1.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_2.value!!))
            {
                result = result.toULong() or FLAG_VALUE_2.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_3.value!!))
            {
                result = result.toULong() or FLAG_VALUE_3.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_4.value!!))
            {
                result = result.toULong() or FLAG_VALUE_4.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_5.value!!))
            {
                result = result.toULong() or FLAG_VALUE_5.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_6.value!!))
            {
                result = result.toULong() or FLAG_VALUE_6.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_7.value!!))
            {
                result = result.toULong() or FLAG_VALUE_7.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_8.value!!))
            {
                result = result.toULong() or FLAG_VALUE_8.raw.toULong()
            }
            if (set.contains(FLAG_VALUE_9.value!!))
            {
                result = result.toULong() or FLAG_VALUE_9.raw.toULong()
            }
            return FlagsTyped(result.toULong())
        }
    }

    var value: FlagsTypedEnum? = FlagsTypedEnum.values()[0]
        private set

    var raw: ULong = value!!.raw
        private set

    constructor()
    constructor(value: ULong) { setEnum(value) }
    constructor(value: FlagsTypedEnum) { setEnum(value) }
    constructor(value: java.util.EnumSet<FlagsTypedEnum>) { setEnum(value) }
    constructor(value: FlagsTyped) { setEnum(value) }

    fun setDefault() { setEnum(0.toULong()) }

    fun setEnum(value: ULong) { this.raw = value; this.value = FlagsTypedEnum.mapValue(value) }
    fun setEnum(value: FlagsTypedEnum) { this.value = value; this.raw = value.raw; }
    fun setEnum(value: java.util.EnumSet<FlagsTypedEnum>) { setEnum(FlagsTyped.fromSet(value)) }
    fun setEnum(value: FlagsTyped) { this.value = value.value; this.raw = value.raw }

    fun hasFlags(flags: ULong): Boolean = ((raw.toULong() and flags.toULong()) != 0uL) && ((raw.toULong() and flags.toULong()) == flags.toULong())
    fun hasFlags(flags: FlagsTypedEnum): Boolean = hasFlags(flags.raw)
    fun hasFlags(flags: FlagsTyped): Boolean = hasFlags(flags.raw)

    fun setFlags(flags: ULong): FlagsTyped { setEnum((raw.toULong() or flags.toULong()).toULong()); return this }
    fun setFlags(flags: FlagsTypedEnum): FlagsTyped { setFlags(flags.raw); return this }
    fun setFlags(flags: FlagsTyped): FlagsTyped { setFlags(flags.raw); return this }

    fun removeFlags(flags: ULong): FlagsTyped { setEnum((raw.toULong() and flags.toULong().inv()).toULong()); return this }
    fun removeFlags(flags: FlagsTypedEnum): FlagsTyped { removeFlags(flags.raw); return this }
    fun removeFlags(flags: FlagsTyped): FlagsTyped { removeFlags(flags.raw); return this }

    val allSet: java.util.EnumSet<FlagsTypedEnum> get() = value!!.allSet
    val noneSet: java.util.EnumSet<FlagsTypedEnum> get() = value!!.noneSet
    val currentSet: java.util.EnumSet<FlagsTypedEnum> get() = value!!.currentSet

    override fun compareTo(other: FlagsTyped): Int
    {
        return (raw - other.raw).toInt()
    }

    override fun equals(other: Any?): Boolean
    {
        if (other == null)
            return false

        if (!FlagsTyped::class.java.isAssignableFrom(other.javaClass))
            return false

        val flg = other as FlagsTyped? ?: return false

        if (raw != flg.raw)
            return false
        return true
    }

    override fun hashCode(): Int
    {
        var hash = 17uL
        hash = hash * 31uL + raw.toULong()
        return hash.toInt()
    }

    override fun toString(): String
    {
        val sb = StringBuilder()
        var first = true
        if (hasFlags(FLAG_VALUE_0.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_0")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_1.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_1")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_2.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_2")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_3.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_3")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_4.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_4")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_5.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_5")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_6.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_6")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_7.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_7")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_8.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_8")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        if (hasFlags(FLAG_VALUE_9.raw))
        {
            sb.append(if (first) "" else "|").append("FLAG_VALUE_9")
            @Suppress("UNUSED_VALUE")
            first = false
        }
        return sb.toString()
    }
}
