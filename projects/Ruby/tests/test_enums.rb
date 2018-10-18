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

=begin
  def test_serialization_json_enums
    enums1 = Enums::Enums.new

    # Serialize enums to the JSON string
    json = enums1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize enums from the JSON string
    enums2 = Enums::Enums::from_json(json)

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
=end
end
