require 'test/unit'

require_relative '../proto/enums'

class TestEnums < Test::Unit::TestCase
  def test_serialization_enums
    enums1 = Enums::Enums.new

    # Serialize enums to the FBE stream
    writer = Enums::EnumsModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(enums1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 232)

    # Deserialize enums from the FBE stream
    # noinspection RubyUnusedLocalVariable
    enums2 = Enums::Enums.new
    reader = Enums::EnumsModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    enums2, deserialized = reader.deserialize(enums2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(enums2.byte0, Enums::EnumByte.ENUM_VALUE_0)
    assert_equal(enums2.byte1, Enums::EnumByte.ENUM_VALUE_1)
    assert_equal(enums2.byte2, Enums::EnumByte.ENUM_VALUE_2)
    assert_equal(enums2.byte3, Enums::EnumByte.ENUM_VALUE_3)
    assert_equal(enums2.byte4, Enums::EnumByte.ENUM_VALUE_4)
    assert_equal(enums2.byte5, enums1.byte3)

    assert_equal(enums2.char0, Enums::EnumChar.ENUM_VALUE_0)
    assert_equal(enums2.char1, Enums::EnumChar.ENUM_VALUE_1)
    assert_equal(enums2.char2, Enums::EnumChar.ENUM_VALUE_2)
    assert_equal(enums2.char3, Enums::EnumChar.ENUM_VALUE_3)
    assert_equal(enums2.char4, Enums::EnumChar.ENUM_VALUE_4)
    assert_equal(enums2.char5, enums1.char3)

    assert_equal(enums2.wchar0, Enums::EnumWChar.ENUM_VALUE_0)
    assert_equal(enums2.wchar1, Enums::EnumWChar.ENUM_VALUE_1)
    assert_equal(enums2.wchar2, Enums::EnumWChar.ENUM_VALUE_2)
    assert_equal(enums2.wchar3, Enums::EnumWChar.ENUM_VALUE_3)
    assert_equal(enums2.wchar4, Enums::EnumWChar.ENUM_VALUE_4)
    assert_equal(enums2.wchar5, enums1.wchar3)

    assert_equal(enums2.int8b0, Enums::EnumInt8.ENUM_VALUE_0)
    assert_equal(enums2.int8b1, Enums::EnumInt8.ENUM_VALUE_1)
    assert_equal(enums2.int8b2, Enums::EnumInt8.ENUM_VALUE_2)
    assert_equal(enums2.int8b3, Enums::EnumInt8.ENUM_VALUE_3)
    assert_equal(enums2.int8b4, Enums::EnumInt8.ENUM_VALUE_4)
    assert_equal(enums2.int8b5, enums1.int8b3)

    assert_equal(enums2.uint8b0, Enums::EnumUInt8.ENUM_VALUE_0)
    assert_equal(enums2.uint8b1, Enums::EnumUInt8.ENUM_VALUE_1)
    assert_equal(enums2.uint8b2, Enums::EnumUInt8.ENUM_VALUE_2)
    assert_equal(enums2.uint8b3, Enums::EnumUInt8.ENUM_VALUE_3)
    assert_equal(enums2.uint8b4, Enums::EnumUInt8.ENUM_VALUE_4)
    assert_equal(enums2.uint8b5, enums1.uint8b3)

    assert_equal(enums2.int16b0, Enums::EnumInt16.ENUM_VALUE_0)
    assert_equal(enums2.int16b1, Enums::EnumInt16.ENUM_VALUE_1)
    assert_equal(enums2.int16b2, Enums::EnumInt16.ENUM_VALUE_2)
    assert_equal(enums2.int16b3, Enums::EnumInt16.ENUM_VALUE_3)
    assert_equal(enums2.int16b4, Enums::EnumInt16.ENUM_VALUE_4)
    assert_equal(enums2.int16b5, enums1.int16b3)

    assert_equal(enums2.uint16b0, Enums::EnumUInt16.ENUM_VALUE_0)
    assert_equal(enums2.uint16b1, Enums::EnumUInt16.ENUM_VALUE_1)
    assert_equal(enums2.uint16b2, Enums::EnumUInt16.ENUM_VALUE_2)
    assert_equal(enums2.uint16b3, Enums::EnumUInt16.ENUM_VALUE_3)
    assert_equal(enums2.uint16b4, Enums::EnumUInt16.ENUM_VALUE_4)
    assert_equal(enums2.uint16b5, enums1.uint16b3)

    assert_equal(enums2.int32b0, Enums::EnumInt32.ENUM_VALUE_0)
    assert_equal(enums2.int32b1, Enums::EnumInt32.ENUM_VALUE_1)
    assert_equal(enums2.int32b2, Enums::EnumInt32.ENUM_VALUE_2)
    assert_equal(enums2.int32b3, Enums::EnumInt32.ENUM_VALUE_3)
    assert_equal(enums2.int32b4, Enums::EnumInt32.ENUM_VALUE_4)
    assert_equal(enums2.int32b5, enums1.int32b3)

    assert_equal(enums2.uint32b0, Enums::EnumUInt32.ENUM_VALUE_0)
    assert_equal(enums2.uint32b1, Enums::EnumUInt32.ENUM_VALUE_1)
    assert_equal(enums2.uint32b2, Enums::EnumUInt32.ENUM_VALUE_2)
    assert_equal(enums2.uint32b3, Enums::EnumUInt32.ENUM_VALUE_3)
    assert_equal(enums2.uint32b4, Enums::EnumUInt32.ENUM_VALUE_4)
    assert_equal(enums2.uint32b5, enums1.uint32b3)

    assert_equal(enums2.int64b0, Enums::EnumInt64.ENUM_VALUE_0)
    assert_equal(enums2.int64b1, Enums::EnumInt64.ENUM_VALUE_1)
    assert_equal(enums2.int64b2, Enums::EnumInt64.ENUM_VALUE_2)
    assert_equal(enums2.int64b3, Enums::EnumInt64.ENUM_VALUE_3)
    assert_equal(enums2.int64b4, Enums::EnumInt64.ENUM_VALUE_4)
    assert_equal(enums2.int64b5, enums1.int64b3)

    assert_equal(enums2.uint64b0, Enums::EnumUInt64.ENUM_VALUE_0)
    assert_equal(enums2.uint64b1, Enums::EnumUInt64.ENUM_VALUE_1)
    assert_equal(enums2.uint64b2, Enums::EnumUInt64.ENUM_VALUE_2)
    assert_equal(enums2.uint64b3, Enums::EnumUInt64.ENUM_VALUE_3)
    assert_equal(enums2.uint64b4, Enums::EnumUInt64.ENUM_VALUE_4)
    assert_equal(enums2.uint64b5, enums1.uint64b3)
  end

  def test_serialization_final_enums
    enums1 = Enums::Enums.new

    # Serialize enums to the FBE stream
    writer = Enums::EnumsFinalModel.new(FBE::WriteBuffer.new)
    serialized = writer.serialize(enums1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 224)

    # Deserialize enums from the FBE stream
    # noinspection RubyUnusedLocalVariable
    enums2 = Enums::Enums.new
    reader = Enums::EnumsFinalModel.new(FBE::ReadBuffer.new)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    enums2, deserialized = reader.deserialize(enums2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)

    assert_equal(enums2.byte0, Enums::EnumByte.ENUM_VALUE_0)
    assert_equal(enums2.byte1, Enums::EnumByte.ENUM_VALUE_1)
    assert_equal(enums2.byte2, Enums::EnumByte.ENUM_VALUE_2)
    assert_equal(enums2.byte3, Enums::EnumByte.ENUM_VALUE_3)
    assert_equal(enums2.byte4, Enums::EnumByte.ENUM_VALUE_4)
    assert_equal(enums2.byte5, enums1.byte3)

    assert_equal(enums2.char0, Enums::EnumChar.ENUM_VALUE_0)
    assert_equal(enums2.char1, Enums::EnumChar.ENUM_VALUE_1)
    assert_equal(enums2.char2, Enums::EnumChar.ENUM_VALUE_2)
    assert_equal(enums2.char3, Enums::EnumChar.ENUM_VALUE_3)
    assert_equal(enums2.char4, Enums::EnumChar.ENUM_VALUE_4)
    assert_equal(enums2.char5, enums1.char3)

    assert_equal(enums2.wchar0, Enums::EnumWChar.ENUM_VALUE_0)
    assert_equal(enums2.wchar1, Enums::EnumWChar.ENUM_VALUE_1)
    assert_equal(enums2.wchar2, Enums::EnumWChar.ENUM_VALUE_2)
    assert_equal(enums2.wchar3, Enums::EnumWChar.ENUM_VALUE_3)
    assert_equal(enums2.wchar4, Enums::EnumWChar.ENUM_VALUE_4)
    assert_equal(enums2.wchar5, enums1.wchar3)

    assert_equal(enums2.int8b0, Enums::EnumInt8.ENUM_VALUE_0)
    assert_equal(enums2.int8b1, Enums::EnumInt8.ENUM_VALUE_1)
    assert_equal(enums2.int8b2, Enums::EnumInt8.ENUM_VALUE_2)
    assert_equal(enums2.int8b3, Enums::EnumInt8.ENUM_VALUE_3)
    assert_equal(enums2.int8b4, Enums::EnumInt8.ENUM_VALUE_4)
    assert_equal(enums2.int8b5, enums1.int8b3)

    assert_equal(enums2.uint8b0, Enums::EnumUInt8.ENUM_VALUE_0)
    assert_equal(enums2.uint8b1, Enums::EnumUInt8.ENUM_VALUE_1)
    assert_equal(enums2.uint8b2, Enums::EnumUInt8.ENUM_VALUE_2)
    assert_equal(enums2.uint8b3, Enums::EnumUInt8.ENUM_VALUE_3)
    assert_equal(enums2.uint8b4, Enums::EnumUInt8.ENUM_VALUE_4)
    assert_equal(enums2.uint8b5, enums1.uint8b3)

    assert_equal(enums2.int16b0, Enums::EnumInt16.ENUM_VALUE_0)
    assert_equal(enums2.int16b1, Enums::EnumInt16.ENUM_VALUE_1)
    assert_equal(enums2.int16b2, Enums::EnumInt16.ENUM_VALUE_2)
    assert_equal(enums2.int16b3, Enums::EnumInt16.ENUM_VALUE_3)
    assert_equal(enums2.int16b4, Enums::EnumInt16.ENUM_VALUE_4)
    assert_equal(enums2.int16b5, enums1.int16b3)

    assert_equal(enums2.uint16b0, Enums::EnumUInt16.ENUM_VALUE_0)
    assert_equal(enums2.uint16b1, Enums::EnumUInt16.ENUM_VALUE_1)
    assert_equal(enums2.uint16b2, Enums::EnumUInt16.ENUM_VALUE_2)
    assert_equal(enums2.uint16b3, Enums::EnumUInt16.ENUM_VALUE_3)
    assert_equal(enums2.uint16b4, Enums::EnumUInt16.ENUM_VALUE_4)
    assert_equal(enums2.uint16b5, enums1.uint16b3)

    assert_equal(enums2.int32b0, Enums::EnumInt32.ENUM_VALUE_0)
    assert_equal(enums2.int32b1, Enums::EnumInt32.ENUM_VALUE_1)
    assert_equal(enums2.int32b2, Enums::EnumInt32.ENUM_VALUE_2)
    assert_equal(enums2.int32b3, Enums::EnumInt32.ENUM_VALUE_3)
    assert_equal(enums2.int32b4, Enums::EnumInt32.ENUM_VALUE_4)
    assert_equal(enums2.int32b5, enums1.int32b3)

    assert_equal(enums2.uint32b0, Enums::EnumUInt32.ENUM_VALUE_0)
    assert_equal(enums2.uint32b1, Enums::EnumUInt32.ENUM_VALUE_1)
    assert_equal(enums2.uint32b2, Enums::EnumUInt32.ENUM_VALUE_2)
    assert_equal(enums2.uint32b3, Enums::EnumUInt32.ENUM_VALUE_3)
    assert_equal(enums2.uint32b4, Enums::EnumUInt32.ENUM_VALUE_4)
    assert_equal(enums2.uint32b5, enums1.uint32b3)

    assert_equal(enums2.int64b0, Enums::EnumInt64.ENUM_VALUE_0)
    assert_equal(enums2.int64b1, Enums::EnumInt64.ENUM_VALUE_1)
    assert_equal(enums2.int64b2, Enums::EnumInt64.ENUM_VALUE_2)
    assert_equal(enums2.int64b3, Enums::EnumInt64.ENUM_VALUE_3)
    assert_equal(enums2.int64b4, Enums::EnumInt64.ENUM_VALUE_4)
    assert_equal(enums2.int64b5, enums1.int64b3)

    assert_equal(enums2.uint64b0, Enums::EnumUInt64.ENUM_VALUE_0)
    assert_equal(enums2.uint64b1, Enums::EnumUInt64.ENUM_VALUE_1)
    assert_equal(enums2.uint64b2, Enums::EnumUInt64.ENUM_VALUE_2)
    assert_equal(enums2.uint64b3, Enums::EnumUInt64.ENUM_VALUE_3)
    assert_equal(enums2.uint64b4, Enums::EnumUInt64.ENUM_VALUE_4)
    assert_equal(enums2.uint64b5, enums1.uint64b3)
  end

  def test_serialization_json_enums
    # Define a source JSON string
    json = '{"byte0":0,"byte1":0,"byte2":1,"byte3":254,"byte4":255,"byte5":254,"char0":0,"char1":49,"char2":50,"char3":51,"char4":52,"char5":51,"wchar0":0,"wchar1":1092,"wchar2":1093,"wchar3":1365,"wchar4":1366,"wchar5":1365,"int8b0":0,"int8b1":-128,"int8b2":-127,"int8b3":126,"int8b4":127,"int8b5":126,"uint8b0":0,"uint8b1":0,"uint8b2":1,"uint8b3":254,"uint8b4":255,"uint8b5":254,"int16b0":0,"int16b1":-32768,"int16b2":-32767,"int16b3":32766,"int16b4":32767,"int16b5":32766,"uint16b0":0,"uint16b1":0,"uint16b2":1,"uint16b3":65534,"uint16b4":65535,"uint16b5":65534,"int32b0":0,"int32b1":-2147483648,"int32b2":-2147483647,"int32b3":2147483646,"int32b4":2147483647,"int32b5":2147483646,"uint32b0":0,"uint32b1":0,"uint32b2":1,"uint32b3":4294967294,"uint32b4":4294967295,"uint32b5":4294967294,"int64b0":0,"int64b1":-9223372036854775807,"int64b2":-9223372036854775806,"int64b3":9223372036854775806,"int64b4":9223372036854775807,"int64b5":9223372036854775806,"uint64b0":0,"uint64b1":0,"uint64b2":1,"uint64b3":18446744073709551614,"uint64b4":18446744073709551615,"uint64b5":18446744073709551614}'

    # Create enums from the source JSON string
    enums1 = Enums::Enums.from_json(json)

    # Serialize enums to the JSON string
    json = enums1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize enums from the JSON string
    enums2 = Enums::Enums.from_json(json)

    assert_equal(enums2.byte0, Enums::EnumByte.ENUM_VALUE_0)
    assert_equal(enums2.byte1, Enums::EnumByte.ENUM_VALUE_1)
    assert_equal(enums2.byte2, Enums::EnumByte.ENUM_VALUE_2)
    assert_equal(enums2.byte3, Enums::EnumByte.ENUM_VALUE_3)
    assert_equal(enums2.byte4, Enums::EnumByte.ENUM_VALUE_4)
    assert_equal(enums2.byte5, enums1.byte3)

    assert_equal(enums2.char0, Enums::EnumChar.ENUM_VALUE_0)
    assert_equal(enums2.char1, Enums::EnumChar.ENUM_VALUE_1)
    assert_equal(enums2.char2, Enums::EnumChar.ENUM_VALUE_2)
    assert_equal(enums2.char3, Enums::EnumChar.ENUM_VALUE_3)
    assert_equal(enums2.char4, Enums::EnumChar.ENUM_VALUE_4)
    assert_equal(enums2.char5, enums1.char3)

    assert_equal(enums2.wchar0, Enums::EnumWChar.ENUM_VALUE_0)
    assert_equal(enums2.wchar1, Enums::EnumWChar.ENUM_VALUE_1)
    assert_equal(enums2.wchar2, Enums::EnumWChar.ENUM_VALUE_2)
    assert_equal(enums2.wchar3, Enums::EnumWChar.ENUM_VALUE_3)
    assert_equal(enums2.wchar4, Enums::EnumWChar.ENUM_VALUE_4)
    assert_equal(enums2.wchar5, enums1.wchar3)

    assert_equal(enums2.int8b0, Enums::EnumInt8.ENUM_VALUE_0)
    assert_equal(enums2.int8b1, Enums::EnumInt8.ENUM_VALUE_1)
    assert_equal(enums2.int8b2, Enums::EnumInt8.ENUM_VALUE_2)
    assert_equal(enums2.int8b3, Enums::EnumInt8.ENUM_VALUE_3)
    assert_equal(enums2.int8b4, Enums::EnumInt8.ENUM_VALUE_4)
    assert_equal(enums2.int8b5, enums1.int8b3)

    assert_equal(enums2.uint8b0, Enums::EnumUInt8.ENUM_VALUE_0)
    assert_equal(enums2.uint8b1, Enums::EnumUInt8.ENUM_VALUE_1)
    assert_equal(enums2.uint8b2, Enums::EnumUInt8.ENUM_VALUE_2)
    assert_equal(enums2.uint8b3, Enums::EnumUInt8.ENUM_VALUE_3)
    assert_equal(enums2.uint8b4, Enums::EnumUInt8.ENUM_VALUE_4)
    assert_equal(enums2.uint8b5, enums1.uint8b3)

    assert_equal(enums2.int16b0, Enums::EnumInt16.ENUM_VALUE_0)
    assert_equal(enums2.int16b1, Enums::EnumInt16.ENUM_VALUE_1)
    assert_equal(enums2.int16b2, Enums::EnumInt16.ENUM_VALUE_2)
    assert_equal(enums2.int16b3, Enums::EnumInt16.ENUM_VALUE_3)
    assert_equal(enums2.int16b4, Enums::EnumInt16.ENUM_VALUE_4)
    assert_equal(enums2.int16b5, enums1.int16b3)

    assert_equal(enums2.uint16b0, Enums::EnumUInt16.ENUM_VALUE_0)
    assert_equal(enums2.uint16b1, Enums::EnumUInt16.ENUM_VALUE_1)
    assert_equal(enums2.uint16b2, Enums::EnumUInt16.ENUM_VALUE_2)
    assert_equal(enums2.uint16b3, Enums::EnumUInt16.ENUM_VALUE_3)
    assert_equal(enums2.uint16b4, Enums::EnumUInt16.ENUM_VALUE_4)
    assert_equal(enums2.uint16b5, enums1.uint16b3)

    assert_equal(enums2.int32b0, Enums::EnumInt32.ENUM_VALUE_0)
    assert_equal(enums2.int32b1, Enums::EnumInt32.ENUM_VALUE_1)
    assert_equal(enums2.int32b2, Enums::EnumInt32.ENUM_VALUE_2)
    assert_equal(enums2.int32b3, Enums::EnumInt32.ENUM_VALUE_3)
    assert_equal(enums2.int32b4, Enums::EnumInt32.ENUM_VALUE_4)
    assert_equal(enums2.int32b5, enums1.int32b3)

    assert_equal(enums2.uint32b0, Enums::EnumUInt32.ENUM_VALUE_0)
    assert_equal(enums2.uint32b1, Enums::EnumUInt32.ENUM_VALUE_1)
    assert_equal(enums2.uint32b2, Enums::EnumUInt32.ENUM_VALUE_2)
    assert_equal(enums2.uint32b3, Enums::EnumUInt32.ENUM_VALUE_3)
    assert_equal(enums2.uint32b4, Enums::EnumUInt32.ENUM_VALUE_4)
    assert_equal(enums2.uint32b5, enums1.uint32b3)

    assert_equal(enums2.int64b0, Enums::EnumInt64.ENUM_VALUE_0)
    assert_equal(enums2.int64b1, Enums::EnumInt64.ENUM_VALUE_1)
    assert_equal(enums2.int64b2, Enums::EnumInt64.ENUM_VALUE_2)
    assert_equal(enums2.int64b3, Enums::EnumInt64.ENUM_VALUE_3)
    assert_equal(enums2.int64b4, Enums::EnumInt64.ENUM_VALUE_4)
    assert_equal(enums2.int64b5, enums1.int64b3)

    assert_equal(enums2.uint64b0, Enums::EnumUInt64.ENUM_VALUE_0)
    assert_equal(enums2.uint64b1, Enums::EnumUInt64.ENUM_VALUE_1)
    assert_equal(enums2.uint64b2, Enums::EnumUInt64.ENUM_VALUE_2)
    assert_equal(enums2.uint64b3, Enums::EnumUInt64.ENUM_VALUE_3)
    assert_equal(enums2.uint64b4, Enums::EnumUInt64.ENUM_VALUE_4)
    assert_equal(enums2.uint64b5, enums1.uint64b3)
  end
end
