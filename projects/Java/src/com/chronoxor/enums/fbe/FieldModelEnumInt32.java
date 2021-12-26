// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.8.0.0

package com.chronoxor.enums.fbe;

// Fast Binary Encoding EnumInt32 field model
public final class FieldModelEnumInt32 extends com.chronoxor.fbe.FieldModel
{
    public FieldModelEnumInt32(com.chronoxor.fbe.Buffer buffer, long offset) { super(buffer, offset); }

    // Get the field size
    @Override
    public long fbeSize() { return 4; }

    // Get the value
    public com.chronoxor.enums.EnumInt32 get() { return get(new com.chronoxor.enums.EnumInt32()); }
    public com.chronoxor.enums.EnumInt32 get(com.chronoxor.enums.EnumInt32 defaults)
    {
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return defaults;

        return new com.chronoxor.enums.EnumInt32(readInt32(fbeOffset()));
    }

    // Set the value
    public void set(com.chronoxor.enums.EnumInt32 value)
    {
        assert ((_buffer.getOffset() + fbeOffset() + fbeSize()) <= _buffer.getSize()) : "Model is broken!";
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return;

        write(fbeOffset(), value.getRaw());
    }
}
