package tests;

import java.math.*;
import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.fbe.*;

public class TestDecimal
{
    private BigDecimal verifyDecimal(int low, int mid, int high, boolean negative, byte scale) throws Exception
    {
        int flags = negative ? ((scale << 16) | 0x80000000) : (scale << 16);

        var buffer = new byte[16];
        Buffer.write(buffer, 0, low);
        Buffer.write(buffer, 4, mid);
        Buffer.write(buffer, 8, high);
        Buffer.write(buffer, 12, flags);

        var model = new FieldModelDecimal(new Buffer(buffer), 0);
        BigDecimal value1 = model.get();
        model.set(value1);
        if ((Buffer.readInt32(buffer, 0) != low) ||
            (Buffer.readInt32(buffer, 4) != mid) ||
            (Buffer.readInt32(buffer, 8) != high) ||
            (Buffer.readInt32(buffer, 12) != flags))
            throw new Exception("Invalid decimal serialization!");

        var finalModel = new FinalModelDecimal(new Buffer(buffer), 0);
        var size = new Size();
        BigDecimal value2 = finalModel.get(size);
        finalModel.set(value2);
        if ((Buffer.readInt32(buffer, 0) != low) ||
            (Buffer.readInt32(buffer, 4) != mid) ||
            (Buffer.readInt32(buffer, 8) != high) ||
            (Buffer.readInt32(buffer, 12) != flags) ||
            (size.value != 16) || (value1.compareTo(value2) != 0))
            throw new Exception("Invalid decimal final serialization!");

        return value1;
    }

    @Test()
    public void DecimalTests() throws Exception
    {
        Assert.assertEquals(verifyDecimal(0x00000000, 0x00000000, 0x00000000, false, (byte)0x00000000), new BigDecimal("0"));
        Assert.assertEquals(verifyDecimal(0x00000001, 0x00000000, 0x00000000, false, (byte)0x00000000), new BigDecimal("1"));
        Assert.assertEquals(verifyDecimal(0x107A4000, 0x00005AF3, 0x00000000, false, (byte)0x00000000), new BigDecimal("100000000000000"));
        Assert.assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (byte)(0x000E0000 >> 16)), new BigDecimal("100000000000000.00000000000000"));
        Assert.assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (byte)0x00000000), new BigDecimal("10000000000000000000000000000"));
        Assert.assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (byte)(0x001C0000 >> 16)), new BigDecimal("1.0000000000000000000000000000"));
        Assert.assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (byte)0x00000000), new BigDecimal("123456789"));
        Assert.assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (byte)(0x00090000 >> 16)), new BigDecimal("0.123456789"));
        Assert.assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (byte)(0x00120000 >> 16)), new BigDecimal("0.000000000123456789"));
        Assert.assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (byte)(0x001B0000 >> 16)), new BigDecimal("0.000000000000000000123456789"));
        Assert.assertEquals(verifyDecimal(0xFFFFFFFF, 0x00000000, 0x00000000, false, (byte)0x00000000), new BigDecimal("4294967295"));
        Assert.assertEquals(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, false, (byte)0x00000000), new BigDecimal("18446744073709551615"));
        Assert.assertEquals(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, false, (byte)0x00000000), new BigDecimal("79228162514264337593543950335"));
        Assert.assertEquals(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, (byte)0x00000000), new BigDecimal("-79228162514264337593543950335"));
        Assert.assertEquals(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, (byte)(0x001C0000 >> 16)), new BigDecimal("-7.9228162514264337593543950335"));
    }
}
