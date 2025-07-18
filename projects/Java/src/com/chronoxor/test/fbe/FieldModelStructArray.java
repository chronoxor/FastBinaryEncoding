//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package com.chronoxor.test.fbe;

// Fast Binary Encoding StructArray field model
public final class FieldModelStructArray extends com.chronoxor.fbe.FieldModel
{
    public final FieldModelArrayByte f1;
    public final FieldModelArrayOptionalByte f2;
    public final FieldModelArrayBytes f3;
    public final FieldModelArrayOptionalBytes f4;
    public final FieldModelArrayEnumSimple f5;
    public final FieldModelArrayOptionalEnumSimple f6;
    public final FieldModelArrayFlagsSimple f7;
    public final FieldModelArrayOptionalFlagsSimple f8;
    public final FieldModelArrayStructSimple f9;
    public final FieldModelArrayOptionalStructSimple f10;

    public FieldModelStructArray(com.chronoxor.fbe.Buffer buffer, long offset)
    {
        super(buffer, offset);
        f1 = new FieldModelArrayByte(buffer, 4 + 4, 2);
        f2 = new FieldModelArrayOptionalByte(buffer, f1.fbeOffset() + f1.fbeSize(), 2);
        f3 = new FieldModelArrayBytes(buffer, f2.fbeOffset() + f2.fbeSize(), 2);
        f4 = new FieldModelArrayOptionalBytes(buffer, f3.fbeOffset() + f3.fbeSize(), 2);
        f5 = new FieldModelArrayEnumSimple(buffer, f4.fbeOffset() + f4.fbeSize(), 2);
        f6 = new FieldModelArrayOptionalEnumSimple(buffer, f5.fbeOffset() + f5.fbeSize(), 2);
        f7 = new FieldModelArrayFlagsSimple(buffer, f6.fbeOffset() + f6.fbeSize(), 2);
        f8 = new FieldModelArrayOptionalFlagsSimple(buffer, f7.fbeOffset() + f7.fbeSize(), 2);
        f9 = new FieldModelArrayStructSimple(buffer, f8.fbeOffset() + f8.fbeSize(), 2);
        f10 = new FieldModelArrayOptionalStructSimple(buffer, f9.fbeOffset() + f9.fbeSize(), 2);
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
            + f4.fbeSize()
            + f5.fbeSize()
            + f6.fbeSize()
            + f7.fbeSize()
            + f8.fbeSize()
            + f9.fbeSize()
            + f10.fbeSize()
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
            + f4.fbeExtra()
            + f5.fbeExtra()
            + f6.fbeExtra()
            + f7.fbeExtra()
            + f8.fbeExtra()
            + f9.fbeExtra()
            + f10.fbeExtra()
            ;

        _buffer.unshift(fbeStructOffset);

        return fbeResult;
    }
    // Get the field type
    public static final long fbeTypeConst = 125;
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

        if ((fbeCurrentSize + f4.fbeSize()) > fbeStructSize)
            return true;
        if (!f4.verify())
            return false;
        fbeCurrentSize += f4.fbeSize();

        if ((fbeCurrentSize + f5.fbeSize()) > fbeStructSize)
            return true;
        if (!f5.verify())
            return false;
        fbeCurrentSize += f5.fbeSize();

        if ((fbeCurrentSize + f6.fbeSize()) > fbeStructSize)
            return true;
        if (!f6.verify())
            return false;
        fbeCurrentSize += f6.fbeSize();

        if ((fbeCurrentSize + f7.fbeSize()) > fbeStructSize)
            return true;
        if (!f7.verify())
            return false;
        fbeCurrentSize += f7.fbeSize();

        if ((fbeCurrentSize + f8.fbeSize()) > fbeStructSize)
            return true;
        if (!f8.verify())
            return false;
        fbeCurrentSize += f8.fbeSize();

        if ((fbeCurrentSize + f9.fbeSize()) > fbeStructSize)
            return true;
        if (!f9.verify())
            return false;
        fbeCurrentSize += f9.fbeSize();

        if ((fbeCurrentSize + f10.fbeSize()) > fbeStructSize)
            return true;
        if (!f10.verify())
            return false;
        fbeCurrentSize += f10.fbeSize();

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
    public com.chronoxor.test.StructArray get() { return get(new com.chronoxor.test.StructArray()); }
    public com.chronoxor.test.StructArray get(com.chronoxor.test.StructArray fbeValue)
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
    public void getFields(com.chronoxor.test.StructArray fbeValue, long fbeStructSize)
    {
        long fbeCurrentSize = 4 + 4;

        if ((fbeCurrentSize + f1.fbeSize()) <= fbeStructSize)
            f1.get(fbeValue.f1);
        else
            fbeValue.f1 = new byte[2];
        fbeCurrentSize += f1.fbeSize();

        if ((fbeCurrentSize + f2.fbeSize()) <= fbeStructSize)
            f2.get(fbeValue.f2);
        else
            fbeValue.f2 = new Byte[2];
        fbeCurrentSize += f2.fbeSize();

        if ((fbeCurrentSize + f3.fbeSize()) <= fbeStructSize)
            f3.get(fbeValue.f3);
        else
            fbeValue.f3 = new java.nio.ByteBuffer[2];
        fbeCurrentSize += f3.fbeSize();

        if ((fbeCurrentSize + f4.fbeSize()) <= fbeStructSize)
            f4.get(fbeValue.f4);
        else
            fbeValue.f4 = new java.nio.ByteBuffer[2];
        fbeCurrentSize += f4.fbeSize();

        if ((fbeCurrentSize + f5.fbeSize()) <= fbeStructSize)
            f5.get(fbeValue.f5);
        else
            fbeValue.f5 = new com.chronoxor.test.EnumSimple[2];
        fbeCurrentSize += f5.fbeSize();

        if ((fbeCurrentSize + f6.fbeSize()) <= fbeStructSize)
            f6.get(fbeValue.f6);
        else
            fbeValue.f6 = new com.chronoxor.test.EnumSimple[2];
        fbeCurrentSize += f6.fbeSize();

        if ((fbeCurrentSize + f7.fbeSize()) <= fbeStructSize)
            f7.get(fbeValue.f7);
        else
            fbeValue.f7 = new com.chronoxor.test.FlagsSimple[2];
        fbeCurrentSize += f7.fbeSize();

        if ((fbeCurrentSize + f8.fbeSize()) <= fbeStructSize)
            f8.get(fbeValue.f8);
        else
            fbeValue.f8 = new com.chronoxor.test.FlagsSimple[2];
        fbeCurrentSize += f8.fbeSize();

        if ((fbeCurrentSize + f9.fbeSize()) <= fbeStructSize)
            f9.get(fbeValue.f9);
        else
            fbeValue.f9 = new com.chronoxor.test.StructSimple[2];
        fbeCurrentSize += f9.fbeSize();

        if ((fbeCurrentSize + f10.fbeSize()) <= fbeStructSize)
            f10.get(fbeValue.f10);
        else
            fbeValue.f10 = new com.chronoxor.test.StructSimple[2];
        fbeCurrentSize += f10.fbeSize();
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
    public void set(com.chronoxor.test.StructArray fbeValue)
    {
        long fbeBegin = setBegin();
        if (fbeBegin == 0)
            return;

        setFields(fbeValue);
        setEnd(fbeBegin);
    }

    // Set the struct fields values
    public void setFields(com.chronoxor.test.StructArray fbeValue)
    {
        f1.set(fbeValue.f1);
        f2.set(fbeValue.f2);
        f3.set(fbeValue.f3);
        f4.set(fbeValue.f4);
        f5.set(fbeValue.f5);
        f6.set(fbeValue.f6);
        f7.set(fbeValue.f7);
        f8.set(fbeValue.f8);
        f9.set(fbeValue.f9);
        f10.set(fbeValue.f10);
    }
}
