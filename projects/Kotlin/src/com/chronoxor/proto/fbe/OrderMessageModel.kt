//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: proto.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

@file:Suppress("UnusedImport", "unused")

package com.chronoxor.proto.fbe

// Fast Binary Encoding OrderMessage model
class OrderMessageModel : com.chronoxor.fbe.Model
{
    val model: FieldModelOrderMessage

    constructor() { model = FieldModelOrderMessage(buffer, 4) }
    constructor(buffer: com.chronoxor.fbe.Buffer) : super(buffer) { model = FieldModelOrderMessage(buffer, 4) }

    // Model size
    fun fbeSize(): Long = model.fbeSize + model.fbeExtra
    // Model type
    var fbeType: Long = fbeTypeConst

    companion object
    {
        const val fbeTypeConst: Long = FieldModelOrderMessage.fbeTypeConst
    }

    // Check if the struct value is valid
    fun verify(): Boolean
    {
        if ((buffer.offset + model.fbeOffset - 4) > buffer.size)
            return false

        val fbeFullSize = readUInt32(model.fbeOffset - 4).toLong()
        if (fbeFullSize < model.fbeSize)
            return false

        return model.verify()
    }

    // Create a new model (begin phase)
    fun createBegin(): Long
    {
        return buffer.allocate(4 + model.fbeSize)
    }

    // Create a new model (end phase)
    fun createEnd(fbeBegin: Long): Long
    {
        val fbeEnd = buffer.size
        val fbeFullSize = fbeEnd - fbeBegin
        write(model.fbeOffset - 4, fbeFullSize.toUInt())
        return fbeFullSize
    }

    // Serialize the struct value
    fun serialize(value: com.chronoxor.proto.OrderMessage): Long
    {
        val fbeBegin = createBegin()
        model.set(value)
        return createEnd(fbeBegin)
    }

    // Deserialize the struct value
    fun deserialize(): com.chronoxor.proto.OrderMessage { val value = com.chronoxor.proto.OrderMessage(); deserialize(value); return value }
    @Suppress("UNUSED_VALUE")
    fun deserialize(value: com.chronoxor.proto.OrderMessage): Long
    {
        var valueRef = value

        if ((buffer.offset + model.fbeOffset - 4) > buffer.size)
        {
            valueRef = com.chronoxor.proto.OrderMessage()
            return 0
        }

        val fbeFullSize = readUInt32(model.fbeOffset - 4).toLong()
        assert(fbeFullSize >= model.fbeSize) { "Model is broken!" }
        if (fbeFullSize < model.fbeSize)
        {
            valueRef = com.chronoxor.proto.OrderMessage()
            return 0
        }

        valueRef = model.get(valueRef)
        return fbeFullSize
    }

    // Move to the next struct value
    fun next(prev: Long)
    {
        model.fbeShift(prev)
    }
}
