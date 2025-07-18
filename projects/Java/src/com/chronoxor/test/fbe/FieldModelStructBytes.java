//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package com.chronoxor.test.fbe;

// Fast Binary Encoding StructBytes field model
public final class FieldModelStructBytes extends com.chronoxor.fbe.FieldModel
{
    public final com.chronoxor.fbe.FieldModelBytes f1;
    public final FieldModelOptionalBytes f2;
    public final FieldModelOptionalBytes f3;

    public FieldModelStructBytes(com.chronoxor.fbe.Buffer buffer, long offset)
    {
        super(buffer, offset);
        f1 = new com.chronoxor.fbe.FieldModelBytes(buffer, 4 + 4);
        f2 = new FieldModelOptionalBytes(buffer, f1.fbeOffset() + f1.fbeSize());
        f3 = new FieldModelOptionalBytes(buffer, f2.fbeOffset() + f2.fbeSize());
    }

    // Get the field size
    @Override
    public long fbeSize() { return 4; }
    // Get the field body size
    public long fbeBody()
    {
        long fbeResult = 4 + 4
            + f1.fbeSize()
            + f2.fbeSize()
            + f3.fbeSize()
            ;
        return fbeResult;
    }
    // Get the field extra size
    @Override
    public long fbeExtra()
    {
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return 0;

        int fbeStructOffset = readInt32(fbeOffset());
        if ((fbeStructOffset == 0) || ((_buffer.getOffset() + fbeStructOffset + 4) > _buffer.getSize()))
            return 0;

        _buffer.shift(fbeStructOffset);

        long fbeResult = fbeBody()
            + f1.fbeExtra()
            + f2.fbeExtra()
            + f3.fbeExtra()
            ;

        _buffer.unshift(fbeStructOffset);

        return fbeResult;
    }
    // Get the field type
    public static final long fbeTypeConst = 120;
    public long fbeType() { return fbeTypeConst; }

    // Check if the struct value is valid
    @Override
    public boolean verify() { return verify(true); }
    public boolean verify(boolean fbeVerifyType)
    {
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return true;

        int fbeStructOffset = readInt32(fbeOffset());
        if ((fbeStructOffset == 0) || ((_buffer.getOffset() + fbeStructOffset + 4 + 4) > _buffer.getSize()))
            return false;

        int fbeStructSize = readInt32(fbeStructOffset);
        if (fbeStructSize < (4 + 4))
            return false;

        int fbeStructType = readInt32(fbeStructOffset + 4);
        if (fbeVerifyType && (fbeStructType != fbeType()))
            return false;

        _buffer.shift(fbeStructOffset);
        boolean fbeResult = verifyFields(fbeStructSize);
        _buffer.unshift(fbeStructOffset);
        return fbeResult;
    }

    // Check if the struct fields are valid
    public boolean verifyFields(long fbeStructSize)
    {
        long fbeCurrentSize = 4 + 4;

        if ((fbeCurrentSize + f1.fbeSize()) > fbeStructSize)
            return true;
        if (!f1.verify())
            return false;
        fbeCurrentSize += f1.fbeSize();

        if ((fbeCurrentSize + f2.fbeSize()) > fbeStructSize)
            return true;
        if (!f2.verify())
            return false;
        fbeCurrentSize += f2.fbeSize();

        if ((fbeCurrentSize + f3.fbeSize()) > fbeStructSize)
            return true;
        if (!f3.verify())
            return false;
        fbeCurrentSize += f3.fbeSize();

        return true;
    }

    // Get the struct value (begin phase)
    public long getBegin()
    {
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return 0;

        int fbeStructOffset = readInt32(fbeOffset());
        assert ((fbeStructOffset > 0) && ((_buffer.getOffset() + fbeStructOffset + 4 + 4) <= _buffer.getSize())) : "Model is broken!";
        if ((fbeStructOffset == 0) || ((_buffer.getOffset() + fbeStructOffset + 4 + 4) > _buffer.getSize()))
            return 0;

        int fbeStructSize = readInt32(fbeStructOffset);
        assert (fbeStructSize >= (4 + 4)) : "Model is broken!";
        if (fbeStructSize < (4 + 4))
            return 0;

        _buffer.shift(fbeStructOffset);
        return fbeStructOffset;
    }

    // Get the struct value (end phase)
    public void getEnd(long fbeBegin)
    {
        _buffer.unshift(fbeBegin);
    }

    // Get the struct value
    public com.chronoxor.test.StructBytes get() { return get(new com.chronoxor.test.StructBytes()); }
    public com.chronoxor.test.StructBytes get(com.chronoxor.test.StructBytes fbeValue)
    {
        long fbeBegin = getBegin();
        if (fbeBegin == 0)
            return fbeValue;

        int fbeStructSize = readInt32(0);
        getFields(fbeValue, fbeStructSize);
        getEnd(fbeBegin);
        return fbeValue;
    }

    // Get the struct fields values
    public void getFields(com.chronoxor.test.StructBytes fbeValue, long fbeStructSize)
    {
        long fbeCurrentSize = 4 + 4;

        if ((fbeCurrentSize + f1.fbeSize()) <= fbeStructSize)
            fbeValue.f1 = f1.get();
        else
            fbeValue.f1 = java.nio.ByteBuffer.allocate(0);
        fbeCurrentSize += f1.fbeSize();

        if ((fbeCurrentSize + f2.fbeSize()) <= fbeStructSize)
            fbeValue.f2 = f2.get();
        else
            fbeValue.f2 = null;
        fbeCurrentSize += f2.fbeSize();

        if ((fbeCurrentSize + f3.fbeSize()) <= fbeStructSize)
            fbeValue.f3 = f3.get(null);
        else
            fbeValue.f3 = null;
        fbeCurrentSize += f3.fbeSize();
    }

    // Set the struct value (begin phase)
    public long setBegin()
    {
        assert ((_buffer.getOffset() + fbeOffset() + fbeSize()) <= _buffer.getSize()) : "Model is broken!";
        if ((_buffer.getOffset() + fbeOffset() + fbeSize()) > _buffer.getSize())
            return 0;

        int fbeStructSize = (int)fbeBody();
        int fbeStructOffset = (int)(_buffer.allocate(fbeStructSize) - _buffer.getOffset());
        assert ((fbeStructOffset > 0) && ((_buffer.getOffset() + fbeStructOffset + fbeStructSize) <= _buffer.getSize())) : "Model is broken!";
        if ((fbeStructOffset <= 0) || ((_buffer.getOffset() + fbeStructOffset + fbeStructSize) > _buffer.getSize()))
            return 0;

        write(fbeOffset(), fbeStructOffset);
        write(fbeStructOffset, fbeStructSize);
        write(fbeStructOffset + 4, (int)fbeType());

        _buffer.shift(fbeStructOffset);
        return fbeStructOffset;
    }

    // Set the struct value (end phase)
    public void setEnd(long fbeBegin)
    {
        _buffer.unshift(fbeBegin);
    }

    // Set the struct value
    public void set(com.chronoxor.test.StructBytes fbeValue)
    {
        long fbeBegin = setBegin();
        if (fbeBegin == 0)
            return;

        setFields(fbeValue);
        setEnd(fbeBegin);
    }

    // Set the struct fields values
    public void setFields(com.chronoxor.test.StructBytes fbeValue)
    {
        f1.set(fbeValue.f1);
        f2.set(fbeValue.f2);
        f3.set(fbeValue.f3);
    }
}
