package tests;

import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.test.*;

public class TestConstants
{
    @Test()
    public void readOnlyConstants()
    {
        // A constant is shared by every user of its type, so changing it in place is refused
        Assert.assertThrows(UnsupportedOperationException.class, () -> FlagsTyped.FLAG_VALUE_2.setFlags(FlagsTyped.FLAG_VALUE_4));
        Assert.assertThrows(UnsupportedOperationException.class, () -> FlagsTyped.FLAG_VALUE_9.removeFlags(FlagsTyped.FLAG_VALUE_4));
        Assert.assertThrows(UnsupportedOperationException.class, () -> FlagsTyped.FLAG_VALUE_9.setDefault());
        Assert.assertThrows(UnsupportedOperationException.class, () -> EnumSimple.ENUM_VALUE_1.setEnum(EnumSimple.ENUM_VALUE_2));
        Assert.assertEquals(FlagsTyped.FLAG_VALUE_2.getRaw(), 0x02L);
        Assert.assertEquals(FlagsTyped.FLAG_VALUE_9.getRaw(), 0x2AL);
        Assert.assertEquals(EnumSimple.ENUM_VALUE_1.getRaw(), 1);

        // A copy is the caller's own to change
        var flags = new FlagsTyped(FlagsTyped.FLAG_VALUE_2).setFlags(FlagsTyped.FLAG_VALUE_4);
        Assert.assertEquals(flags.getRaw(), 0x0AL);
        var value = new EnumSimple(EnumSimple.ENUM_VALUE_1);
        value.setEnum(EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(value, EnumSimple.ENUM_VALUE_2);

        // So is a struct field whose default is a constant
        var struct1 = new StructNested();
        var struct2 = new StructNested();
        struct1.f1002.setEnum(EnumTyped.ENUM_VALUE_1);
        struct1.f1006.removeFlags(FlagsTyped.FLAG_VALUE_4);
        Assert.assertEquals(struct1.f1002, EnumTyped.ENUM_VALUE_1);
        Assert.assertEquals(struct1.f1006.getRaw(), 0x22L);
        Assert.assertEquals(struct2.f1002, EnumTyped.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f1006.getRaw(), 0x2AL);
    }
}
