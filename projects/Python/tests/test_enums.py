import fbe
from proto import enums
from unittest import TestCase


class TestEnums(TestCase):

    def test_serialization_enums(self):
        enums1 = enums.Enums()

        # Serialize enums to the FBE stream
        writer = enums.EnumsModel(fbe.WriteBuffer())
        self.assertEqual(writer.model.fbe_offset, 4)
        serialized = writer.serialize(enums1)
        self.assertEqual(serialized, writer.buffer.size)
        self.assertTrue(writer.verify())
        writer.next(serialized)
        self.assertEqual(writer.model.fbe_offset, (4 + writer.buffer.size))

        # Check the serialized FBE size
        self.assertEqual(writer.buffer.size, 232)

        # Deserialize enums from the FBE stream
        enums2 = enums.Enums()
        reader = enums.EnumsModel(fbe.ReadBuffer())
        self.assertEqual(reader.model.fbe_offset, 4)
        reader.attach_buffer(writer.buffer)
        self.assertTrue(reader.verify())
        (enums2, deserialized) = reader.deserialize(enums2)
        self.assertEqual(deserialized, reader.buffer.size)
        reader.next(deserialized)
        self.assertEqual(reader.model.fbe_offset, (4 + reader.buffer.size))

        self.assertEqual(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        self.assertEqual(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        self.assertEqual(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        self.assertEqual(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        self.assertEqual(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        self.assertEqual(enums2.byte5, enums1.byte3)

        self.assertEqual(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        self.assertEqual(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        self.assertEqual(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        self.assertEqual(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        self.assertEqual(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        self.assertEqual(enums2.char5, enums1.char3)

        self.assertEqual(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        self.assertEqual(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        self.assertEqual(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        self.assertEqual(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        self.assertEqual(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        self.assertEqual(enums2.wchar5, enums1.wchar3)

        self.assertEqual(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.int8b5, enums1.int8b3)

        self.assertEqual(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.uint8b5, enums1.uint8b3)

        self.assertEqual(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.int16b5, enums1.int16b3)

        self.assertEqual(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.uint16b5, enums1.uint16b3)

        self.assertEqual(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.int32b5, enums1.int32b3)

        self.assertEqual(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.uint32b5, enums1.uint32b3)

        self.assertEqual(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.int64b5, enums1.int64b3)

        self.assertEqual(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.uint64b5, enums1.uint64b3)

    def test_serialization_final_enums(self):
        enums1 = enums.Enums()

        # Serialize enums to the FBE stream
        writer = enums.EnumsFinalModel(fbe.WriteBuffer())
        serialized = writer.serialize(enums1)
        self.assertEqual(serialized, writer.buffer.size)
        self.assertTrue(writer.verify())
        writer.next(serialized)

        # Check the serialized FBE size
        self.assertEqual(writer.buffer.size, 224)

        # Deserialize enums from the FBE stream
        enums2 = enums.Enums()
        reader = enums.EnumsFinalModel(fbe.ReadBuffer())
        reader.attach_buffer(writer.buffer)
        self.assertTrue(reader.verify())
        (enums2, deserialized) = reader.deserialize(enums2)
        self.assertEqual(deserialized, reader.buffer.size)
        reader.next(deserialized)

        self.assertEqual(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        self.assertEqual(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        self.assertEqual(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        self.assertEqual(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        self.assertEqual(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        self.assertEqual(enums2.byte5, enums1.byte3)

        self.assertEqual(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        self.assertEqual(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        self.assertEqual(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        self.assertEqual(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        self.assertEqual(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        self.assertEqual(enums2.char5, enums1.char3)

        self.assertEqual(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        self.assertEqual(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        self.assertEqual(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        self.assertEqual(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        self.assertEqual(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        self.assertEqual(enums2.wchar5, enums1.wchar3)

        self.assertEqual(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.int8b5, enums1.int8b3)

        self.assertEqual(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.uint8b5, enums1.uint8b3)

        self.assertEqual(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.int16b5, enums1.int16b3)

        self.assertEqual(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.uint16b5, enums1.uint16b3)

        self.assertEqual(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.int32b5, enums1.int32b3)

        self.assertEqual(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.uint32b5, enums1.uint32b3)

        self.assertEqual(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.int64b5, enums1.int64b3)

        self.assertEqual(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.uint64b5, enums1.uint64b3)

    def test_serialization_json_enums(self):
        enums1 = enums.Enums()

        # Serialize enums to the JSON string
        json = enums1.to_json()

        # Check the serialized JSON size
        self.assertGreater(len(json), 0)

        # Deserialize enums from the JSON string
        enums2 = enums.Enums.from_json(json)

        self.assertEqual(enums2.byte0, enums.EnumByte.ENUM_VALUE_0)
        self.assertEqual(enums2.byte1, enums.EnumByte.ENUM_VALUE_1)
        self.assertEqual(enums2.byte2, enums.EnumByte.ENUM_VALUE_2)
        self.assertEqual(enums2.byte3, enums.EnumByte.ENUM_VALUE_3)
        self.assertEqual(enums2.byte4, enums.EnumByte.ENUM_VALUE_4)
        self.assertEqual(enums2.byte5, enums1.byte3)

        self.assertEqual(enums2.char0, enums.EnumChar.ENUM_VALUE_0)
        self.assertEqual(enums2.char1, enums.EnumChar.ENUM_VALUE_1)
        self.assertEqual(enums2.char2, enums.EnumChar.ENUM_VALUE_2)
        self.assertEqual(enums2.char3, enums.EnumChar.ENUM_VALUE_3)
        self.assertEqual(enums2.char4, enums.EnumChar.ENUM_VALUE_4)
        self.assertEqual(enums2.char5, enums1.char3)

        self.assertEqual(enums2.wchar0, enums.EnumWChar.ENUM_VALUE_0)
        self.assertEqual(enums2.wchar1, enums.EnumWChar.ENUM_VALUE_1)
        self.assertEqual(enums2.wchar2, enums.EnumWChar.ENUM_VALUE_2)
        self.assertEqual(enums2.wchar3, enums.EnumWChar.ENUM_VALUE_3)
        self.assertEqual(enums2.wchar4, enums.EnumWChar.ENUM_VALUE_4)
        self.assertEqual(enums2.wchar5, enums1.wchar3)

        self.assertEqual(enums2.int8b0, enums.EnumInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.int8b1, enums.EnumInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.int8b2, enums.EnumInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.int8b3, enums.EnumInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.int8b4, enums.EnumInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.int8b5, enums1.int8b3)

        self.assertEqual(enums2.uint8b0, enums.EnumUInt8.ENUM_VALUE_0)
        self.assertEqual(enums2.uint8b1, enums.EnumUInt8.ENUM_VALUE_1)
        self.assertEqual(enums2.uint8b2, enums.EnumUInt8.ENUM_VALUE_2)
        self.assertEqual(enums2.uint8b3, enums.EnumUInt8.ENUM_VALUE_3)
        self.assertEqual(enums2.uint8b4, enums.EnumUInt8.ENUM_VALUE_4)
        self.assertEqual(enums2.uint8b5, enums1.uint8b3)

        self.assertEqual(enums2.int16b0, enums.EnumInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.int16b1, enums.EnumInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.int16b2, enums.EnumInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.int16b3, enums.EnumInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.int16b4, enums.EnumInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.int16b5, enums1.int16b3)

        self.assertEqual(enums2.uint16b0, enums.EnumUInt16.ENUM_VALUE_0)
        self.assertEqual(enums2.uint16b1, enums.EnumUInt16.ENUM_VALUE_1)
        self.assertEqual(enums2.uint16b2, enums.EnumUInt16.ENUM_VALUE_2)
        self.assertEqual(enums2.uint16b3, enums.EnumUInt16.ENUM_VALUE_3)
        self.assertEqual(enums2.uint16b4, enums.EnumUInt16.ENUM_VALUE_4)
        self.assertEqual(enums2.uint16b5, enums1.uint16b3)

        self.assertEqual(enums2.int32b0, enums.EnumInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.int32b1, enums.EnumInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.int32b2, enums.EnumInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.int32b3, enums.EnumInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.int32b4, enums.EnumInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.int32b5, enums1.int32b3)

        self.assertEqual(enums2.uint32b0, enums.EnumUInt32.ENUM_VALUE_0)
        self.assertEqual(enums2.uint32b1, enums.EnumUInt32.ENUM_VALUE_1)
        self.assertEqual(enums2.uint32b2, enums.EnumUInt32.ENUM_VALUE_2)
        self.assertEqual(enums2.uint32b3, enums.EnumUInt32.ENUM_VALUE_3)
        self.assertEqual(enums2.uint32b4, enums.EnumUInt32.ENUM_VALUE_4)
        self.assertEqual(enums2.uint32b5, enums1.uint32b3)

        self.assertEqual(enums2.int64b0, enums.EnumInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.int64b1, enums.EnumInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.int64b2, enums.EnumInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.int64b3, enums.EnumInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.int64b4, enums.EnumInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.int64b5, enums1.int64b3)

        self.assertEqual(enums2.uint64b0, enums.EnumUInt64.ENUM_VALUE_0)
        self.assertEqual(enums2.uint64b1, enums.EnumUInt64.ENUM_VALUE_1)
        self.assertEqual(enums2.uint64b2, enums.EnumUInt64.ENUM_VALUE_2)
        self.assertEqual(enums2.uint64b3, enums.EnumUInt64.ENUM_VALUE_3)
        self.assertEqual(enums2.uint64b4, enums.EnumUInt64.ENUM_VALUE_4)
        self.assertEqual(enums2.uint64b5, enums1.uint64b3)
