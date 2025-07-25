//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: proto.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.proto.fbe

// Fast Binary Encoding BalanceMessage final model
@Suppress("MemberVisibilityCanBePrivate", "RemoveRedundantCallsOfConversionMethods", "ReplaceGetOrSet")
class FinalModelBalanceMessage(buffer: com.chronoxor.fbe.Buffer, offset: Long) : com.chronoxor.fbe.FinalModel(buffer, offset)
{
    val body: FinalModelBalance = FinalModelBalance(buffer, 0)

    // Get the allocation size
    @Suppress("UNUSED_PARAMETER")
    fun fbeAllocationSize(fbeValue: com.chronoxor.proto.BalanceMessage): Long = (0
        + body.fbeAllocationSize(fbeValue.body)
        )

    // Field type
    var fbeType: Long = fbeTypeConst

    companion object
    {
        const val fbeTypeConst: Long = 2
    }

    // Check if the struct value is valid
    override fun verify(): Long
    {
        _buffer.shift(fbeOffset)
        val fbeResult = verifyFields()
        _buffer.unshift(fbeOffset)
        return fbeResult
    }

    // Check if the struct fields are valid
    fun verifyFields(): Long
    {
        var fbeCurrentOffset = 0L
        @Suppress("VARIABLE_WITH_REDUNDANT_INITIALIZER")
        var fbeFieldSize = 0L

        body.fbeOffset = fbeCurrentOffset
        fbeFieldSize = body.verify()
        if (fbeFieldSize == Long.MAX_VALUE)
            return Long.MAX_VALUE
        fbeCurrentOffset += fbeFieldSize

        return fbeCurrentOffset
    }

    // Get the struct value
    fun get(fbeSize: com.chronoxor.fbe.Size, fbeValue: com.chronoxor.proto.BalanceMessage = com.chronoxor.proto.BalanceMessage()): com.chronoxor.proto.BalanceMessage
    {
        _buffer.shift(fbeOffset)
        fbeSize.value = getFields(fbeValue)
        _buffer.unshift(fbeOffset)
        return fbeValue
    }

    // Get the struct fields values
    @Suppress("UNUSED_PARAMETER")
    fun getFields(fbeValue: com.chronoxor.proto.BalanceMessage): Long
    {
        var fbeCurrentOffset = 0L
        var fbeCurrentSize = 0L
        val fbeFieldSize = com.chronoxor.fbe.Size()

        body.fbeOffset = fbeCurrentOffset
        fbeValue.body = body.get(fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        return fbeCurrentSize
    }

    // Set the struct value
    fun set(fbeValue: com.chronoxor.proto.BalanceMessage): Long
    {
        _buffer.shift(fbeOffset)
        val fbeSize = setFields(fbeValue)
        _buffer.unshift(fbeOffset)
        return fbeSize
    }

    // Set the struct fields values
    @Suppress("UNUSED_PARAMETER")
    fun setFields(fbeValue: com.chronoxor.proto.BalanceMessage): Long
    {
        var fbeCurrentOffset = 0L
        var fbeCurrentSize = 0L
        val fbeFieldSize = com.chronoxor.fbe.Size()

        body.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = body.set(fbeValue.body)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        return fbeCurrentSize
    }
}
