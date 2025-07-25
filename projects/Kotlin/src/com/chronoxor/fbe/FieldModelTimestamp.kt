//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: FBE
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.fbe

// Fast Binary Encoding timestamp field model
class FieldModelTimestamp(buffer: Buffer, offset: Long) : FieldModel(buffer, offset)
{
    // Field size
    override val fbeSize: Long = 8

    // Get the timestamp value
    fun get(defaults: java.time.Instant = java.time.Instant.EPOCH): java.time.Instant
    {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size)
            return defaults

        val nanoseconds = readInt64(fbeOffset)
        return java.time.Instant.ofEpochSecond(nanoseconds / 1000000000, nanoseconds % 1000000000)
    }

    // Set the timestamp value
    fun set(value: java.time.Instant)
    {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size) { "Model is broken!" }
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size)
            return

        val nanoseconds = value.epochSecond * 1000000000 + value.nano
        write(fbeOffset, nanoseconds.toULong())
    }
}
