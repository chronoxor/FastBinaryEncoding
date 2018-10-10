package tests

import kotlin.test.*
import org.testng.annotations.*

class TestEnums
{
    @Test
    fun serializationEnums()
    {
        val enums1 = enums.Enums()

        // Serialize enums to the FBE stream
        val writer = enums.fbe.EnumsModel()
        assertEquals(writer.model.fbeOffset, 4)
        val serialized = writer.serialize(enums1)
        assertEquals(serialized, writer.buffer.size)
        assertTrue(writer.verify())
        writer.next(serialized)
        assertEquals(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        assertEquals(writer.buffer.size, 232)

        // Deserialize enums from the FBE stream
        val enums2 = enums.Enums()
        val reader = enums.fbe.EnumsModel()
        assertEquals(reader.model.fbeOffset, 4)
        reader.attach(writer.buffer)
        assertTrue(reader.verify())
        val deserialized = reader.deserialize(enums2)
        assertEquals(deserialized, reader.buffer.size)
        reader.next(deserialized)
        assertEquals(reader.model.fbeOffset, 4 + reader.buffer.size)

        assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        assertEquals(enums2.byte5, enums1.byte3)

        assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        assertEquals(enums2.char5, enums1.char3)

        assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        assertEquals(enums2.wchar5, enums1.wchar3)

        assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        assertEquals(enums2.int8b5, enums1.int8b3)

        assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        assertEquals(enums2.uint8b5, enums1.uint8b3)

        assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        assertEquals(enums2.int16b5, enums1.int16b3)

        assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        assertEquals(enums2.uint16b5, enums1.uint16b3)

        assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        assertEquals(enums2.int32b5, enums1.int32b3)

        assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        assertEquals(enums2.uint32b5, enums1.uint32b3)

        assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        assertEquals(enums2.int64b5, enums1.int64b3)

        assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        assertEquals(enums2.uint64b5, enums1.uint64b3)
    }

    @Test
    fun serializationFinalEnums()
    {
        val enums1 = enums.Enums()

        // Serialize enums to the FBE stream
        val writer = enums.fbe.EnumsFinalModel()
        val serialized = writer.serialize(enums1)
        assertEquals(serialized, writer.buffer.size)
        assertTrue(writer.verify())
        writer.next(serialized)

        // Check the serialized FBE size
        assertEquals(writer.buffer.size, 224)

        // Deserialize enums from the FBE stream
        val enums2 = enums.Enums()
        val reader = enums.fbe.EnumsFinalModel()
        reader.attach(writer.buffer)
        assertTrue(reader.verify())
        val deserialized = reader.deserialize(enums2)
        assertEquals(deserialized, reader.buffer.size)
        reader.next(deserialized)

        assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        assertEquals(enums2.byte5, enums1.byte3)

        assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        assertEquals(enums2.char5, enums1.char3)

        assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        assertEquals(enums2.wchar5, enums1.wchar3)

        assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        assertEquals(enums2.int8b5, enums1.int8b3)

        assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        assertEquals(enums2.uint8b5, enums1.uint8b3)

        assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        assertEquals(enums2.int16b5, enums1.int16b3)

        assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        assertEquals(enums2.uint16b5, enums1.uint16b3)

        assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        assertEquals(enums2.int32b5, enums1.int32b3)

        assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        assertEquals(enums2.uint32b5, enums1.uint32b3)

        assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        assertEquals(enums2.int64b5, enums1.int64b3)

        assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        assertEquals(enums2.uint64b5, enums1.uint64b3)
    }
/*
    @Test
    fun serializationJsonEnums()
    {
        val enums1 = enums.Enums()

        // Serialize enums to the JSON string
        val json = enums1.toJson()

        // Check the serialized JSON size
        assertTrue(json.length() > 0)

        // Deserialize enums from the JSON string
        val enums2 = enums.Enums.fromJson(json)

        assertEquals(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        assertEquals(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        assertEquals(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        assertEquals(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        assertEquals(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        assertEquals(enums2.byte5, enums1.byte3)

        assertEquals(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        assertEquals(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        assertEquals(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        assertEquals(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        assertEquals(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        assertEquals(enums2.char5, enums1.char3)

        assertEquals(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        assertEquals(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        assertEquals(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        assertEquals(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        assertEquals(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        assertEquals(enums2.wchar5, enums1.wchar3)

        assertEquals(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        assertEquals(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        assertEquals(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        assertEquals(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        assertEquals(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        assertEquals(enums2.int8b5, enums1.int8b3)

        assertEquals(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        assertEquals(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        assertEquals(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        assertEquals(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        assertEquals(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        assertEquals(enums2.uint8b5, enums1.uint8b3)

        assertEquals(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        assertEquals(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        assertEquals(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        assertEquals(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        assertEquals(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        assertEquals(enums2.int16b5, enums1.int16b3)

        assertEquals(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        assertEquals(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        assertEquals(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        assertEquals(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        assertEquals(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        assertEquals(enums2.uint16b5, enums1.uint16b3)

        assertEquals(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        assertEquals(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        assertEquals(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        assertEquals(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        assertEquals(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        assertEquals(enums2.int32b5, enums1.int32b3)

        assertEquals(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        assertEquals(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        assertEquals(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        assertEquals(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        assertEquals(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        assertEquals(enums2.uint32b5, enums1.uint32b3)

        assertEquals(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        assertEquals(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        assertEquals(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        assertEquals(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        assertEquals(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        assertEquals(enums2.int64b5, enums1.int64b3)

        assertEquals(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        assertEquals(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        assertEquals(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        assertEquals(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        assertEquals(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        assertEquals(enums2.uint64b5, enums1.uint64b3)
    }
*/
}
