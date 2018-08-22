package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

public class TestEnums
{
    @Test()
    public void SerializationEnums()
    {
        var enums1 = new enums.Enums();

        // Serialize enums to the FBE stream
        var writer = new enums.fbe.EnumsModel();
        Assert.assertEquals(writer.model.FBEOffset(), 4);
        long serialized = writer.serialize(enums1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.FBEOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 232);

        // Deserialize enums from the FBE stream
        var enums2 = new enums.Enums();
        var reader = new enums.fbe.EnumsModel();
        Assert.assertEquals(reader.model.FBEOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(enums2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.FBEOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0);
        Assert.assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1);
        Assert.assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2);
        Assert.assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3);
        Assert.assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4);
        Assert.assertEquals(enums2.byte5, enums1.byte3);

        Assert.assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.char5, enums1.char3);

        Assert.assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.wchar5, enums1.wchar3);

        Assert.assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int8b5, enums1.int8b3);

        Assert.assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint8b5, enums1.uint8b3);

        Assert.assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int16b5, enums1.int16b3);

        Assert.assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint16b5, enums1.uint16b3);

        Assert.assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int32b5, enums1.int32b3);

        Assert.assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint32b5, enums1.uint32b3);

        Assert.assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int64b5, enums1.int64b3);

        Assert.assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint64b5, enums1.uint64b3);
    }

    @Test()
    public void SerializationFinalEnums()
    {
        var enums1 = new enums.Enums();

        // Serialize enums to the FBE stream
        var writer = new enums.fbe.EnumsFinalModel();
        long serialized = writer.serialize(enums1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 224);

        // Deserialize enums from the FBE stream
        var enums2 = new enums.Enums();
        var reader = new enums.fbe.EnumsFinalModel();
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(enums2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);

        Assert.assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0);
        Assert.assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1);
        Assert.assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2);
        Assert.assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3);
        Assert.assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4);
        Assert.assertEquals(enums2.byte5, enums1.byte3);

        Assert.assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.char5, enums1.char3);

        Assert.assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.wchar5, enums1.wchar3);

        Assert.assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int8b5, enums1.int8b3);

        Assert.assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint8b5, enums1.uint8b3);

        Assert.assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int16b5, enums1.int16b3);

        Assert.assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint16b5, enums1.uint16b3);

        Assert.assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int32b5, enums1.int32b3);

        Assert.assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint32b5, enums1.uint32b3);

        Assert.assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int64b5, enums1.int64b3);

        Assert.assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint64b5, enums1.uint64b3);
    }

    @Test()
    public void SerializationJsonEnums()
    {
        var enums1 = new enums.Enums();

        // Serialize enums to the JSON string
        var json = enums1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize enums from the JSON string
        var enums2 = enums.Enums.fromJson(json);

        Assert.assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0);
        Assert.assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1);
        Assert.assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2);
        Assert.assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3);
        Assert.assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4);
        Assert.assertEquals(enums2.byte5, enums1.byte3);

        Assert.assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.char5, enums1.char3);

        Assert.assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0);
        Assert.assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1);
        Assert.assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2);
        Assert.assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3);
        Assert.assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4);
        Assert.assertEquals(enums2.wchar5, enums1.wchar3);

        Assert.assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int8b5, enums1.int8b3);

        Assert.assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint8b5, enums1.uint8b3);

        Assert.assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int16b5, enums1.int16b3);

        Assert.assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint16b5, enums1.uint16b3);

        Assert.assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int32b5, enums1.int32b3);

        Assert.assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint32b5, enums1.uint32b3);

        Assert.assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.int64b5, enums1.int64b3);

        Assert.assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0);
        Assert.assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1);
        Assert.assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2);
        Assert.assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3);
        Assert.assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4);
        Assert.assertEquals(enums2.uint64b5, enums1.uint64b3);
    }
}
