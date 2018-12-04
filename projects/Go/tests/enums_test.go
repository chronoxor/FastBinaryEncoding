package tests

import "testing"
import "github.com/stretchr/testify/assert"
import "../proto/fbe"
import "../proto/enums"

func TestSerializationEnums(t *testing.T) {
	enums1 := enums.NewEnums()

	// Serialize enums to the FBE stream
	writer := enums.NewEnumsModel(fbe.NewEmptyBuffer())
	assert.EqualValues(t, writer.Model().FBEOffset(), 4)
	serialized, err := writer.Serialize(enums1)
	assert.Nil(t, err)
	assert.EqualValues(t, serialized, writer.Buffer().Size())
	assert.True(t, writer.Verify())
	writer.Next(serialized)
	assert.EqualValues(t, writer.Model().FBEOffset(), 4+writer.Buffer().Size())

	// Check the serialized FBE size
	assert.EqualValues(t, writer.Buffer().Size(), 232)

	// Deserialize enums from the FBE stream
	reader := enums.NewEnumsModel(writer.Buffer())
	assert.EqualValues(t, reader.Model().FBEOffset(), 4)
	assert.True(t, reader.Verify())
	enums2, deserialized, err := reader.Deserialize()
	assert.Nil(t, err)
	assert.EqualValues(t, deserialized, reader.Buffer().Size())
	reader.Next(deserialized)
	assert.EqualValues(t, reader.Model().FBEOffset(), 4+reader.Buffer().Size())

	assert.EqualValues(t, enums2.Byte0, enums.EnumByte_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Byte1, enums.EnumByte_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Byte2, enums.EnumByte_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Byte3, enums.EnumByte_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Byte4, enums.EnumByte_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Byte5, enums1.Byte3)

	assert.EqualValues(t, enums2.Char0, enums.EnumChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Char1, enums.EnumChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Char2, enums.EnumChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Char3, enums.EnumChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Char4, enums.EnumChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Char5, enums1.Char3)

	assert.EqualValues(t, enums2.Wchar0, enums.EnumWChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Wchar1, enums.EnumWChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Wchar2, enums.EnumWChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Wchar3, enums.EnumWChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Wchar4, enums.EnumWChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Wchar5, enums1.Wchar3)

	assert.EqualValues(t, enums2.Int8b0, enums.EnumInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int8b1, enums.EnumInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int8b2, enums.EnumInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int8b3, enums.EnumInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int8b4, enums.EnumInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int8b5, enums1.Int8b3)

	assert.EqualValues(t, enums2.Uint8b0, enums.EnumUInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint8b1, enums.EnumUInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint8b2, enums.EnumUInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint8b3, enums.EnumUInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint8b4, enums.EnumUInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint8b5, enums1.Uint8b3)

	assert.EqualValues(t, enums2.Int16b0, enums.EnumInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int16b1, enums.EnumInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int16b2, enums.EnumInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int16b3, enums.EnumInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int16b4, enums.EnumInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int16b5, enums1.Int16b3)

	assert.EqualValues(t, enums2.Uint16b0, enums.EnumUInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint16b1, enums.EnumUInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint16b2, enums.EnumUInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint16b3, enums.EnumUInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint16b4, enums.EnumUInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint16b5, enums1.Uint16b3)

	assert.EqualValues(t, enums2.Int32b0, enums.EnumInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int32b1, enums.EnumInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int32b2, enums.EnumInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int32b3, enums.EnumInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int32b4, enums.EnumInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int32b5, enums1.Int32b3)

	assert.EqualValues(t, enums2.Uint32b0, enums.EnumUInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint32b1, enums.EnumUInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint32b2, enums.EnumUInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint32b3, enums.EnumUInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint32b4, enums.EnumUInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint32b5, enums1.Uint32b3)

	assert.EqualValues(t, enums2.Int64b0, enums.EnumInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int64b1, enums.EnumInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int64b2, enums.EnumInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int64b3, enums.EnumInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int64b4, enums.EnumInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int64b5, enums1.Int64b3)

	assert.EqualValues(t, enums2.Uint64b0, enums.EnumUInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint64b1, enums.EnumUInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint64b2, enums.EnumUInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint64b3, enums.EnumUInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint64b4, enums.EnumUInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint64b5, enums1.Uint64b3)
}

func TestSerializationFinalEnums(t *testing.T) {
	enums1 := enums.NewEnums()

	// Serialize enums to the FBE stream
	writer := enums.NewEnumsFinalModel(fbe.NewEmptyBuffer())
	serialized, err := writer.Serialize(enums1)
	assert.Nil(t, err)
	assert.EqualValues(t, serialized, writer.Buffer().Size())
	assert.True(t, writer.Verify())
	writer.Next(serialized)

	// Check the serialized FBE size
	assert.EqualValues(t, writer.Buffer().Size(), 224)

	// Deserialize enums from the FBE stream
	reader := enums.NewEnumsFinalModel(writer.Buffer())
	assert.True(t, reader.Verify())
	enums2, deserialized, err := reader.Deserialize()
	assert.Nil(t, err)
	assert.EqualValues(t, deserialized, reader.Buffer().Size())
	reader.Next(deserialized)

	assert.EqualValues(t, enums2.Byte0, enums.EnumByte_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Byte1, enums.EnumByte_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Byte2, enums.EnumByte_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Byte3, enums.EnumByte_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Byte4, enums.EnumByte_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Byte5, enums1.Byte3)

	assert.EqualValues(t, enums2.Char0, enums.EnumChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Char1, enums.EnumChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Char2, enums.EnumChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Char3, enums.EnumChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Char4, enums.EnumChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Char5, enums1.Char3)

	assert.EqualValues(t, enums2.Wchar0, enums.EnumWChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Wchar1, enums.EnumWChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Wchar2, enums.EnumWChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Wchar3, enums.EnumWChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Wchar4, enums.EnumWChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Wchar5, enums1.Wchar3)

	assert.EqualValues(t, enums2.Int8b0, enums.EnumInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int8b1, enums.EnumInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int8b2, enums.EnumInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int8b3, enums.EnumInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int8b4, enums.EnumInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int8b5, enums1.Int8b3)

	assert.EqualValues(t, enums2.Uint8b0, enums.EnumUInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint8b1, enums.EnumUInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint8b2, enums.EnumUInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint8b3, enums.EnumUInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint8b4, enums.EnumUInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint8b5, enums1.Uint8b3)

	assert.EqualValues(t, enums2.Int16b0, enums.EnumInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int16b1, enums.EnumInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int16b2, enums.EnumInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int16b3, enums.EnumInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int16b4, enums.EnumInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int16b5, enums1.Int16b3)

	assert.EqualValues(t, enums2.Uint16b0, enums.EnumUInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint16b1, enums.EnumUInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint16b2, enums.EnumUInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint16b3, enums.EnumUInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint16b4, enums.EnumUInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint16b5, enums1.Uint16b3)

	assert.EqualValues(t, enums2.Int32b0, enums.EnumInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int32b1, enums.EnumInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int32b2, enums.EnumInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int32b3, enums.EnumInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int32b4, enums.EnumInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int32b5, enums1.Int32b3)

	assert.EqualValues(t, enums2.Uint32b0, enums.EnumUInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint32b1, enums.EnumUInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint32b2, enums.EnumUInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint32b3, enums.EnumUInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint32b4, enums.EnumUInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint32b5, enums1.Uint32b3)

	assert.EqualValues(t, enums2.Int64b0, enums.EnumInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int64b1, enums.EnumInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int64b2, enums.EnumInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int64b3, enums.EnumInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int64b4, enums.EnumInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int64b5, enums1.Int64b3)

	assert.EqualValues(t, enums2.Uint64b0, enums.EnumUInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint64b1, enums.EnumUInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint64b2, enums.EnumUInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint64b3, enums.EnumUInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint64b4, enums.EnumUInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint64b5, enums1.Uint64b3)
}

func TestSerializationJsonEnums(t *testing.T) {
	// Define a source JSON string
	json := []byte(`{"byte0":0,"byte1":0,"byte2":1,"byte3":254,"byte4":255,"byte5":254,"char0":0,"char1":49,"char2":50,"char3":51,"char4":52,"char5":51,"wchar0":0,"wchar1":1092,"wchar2":1093,"wchar3":1365,"wchar4":1366,"wchar5":1365,"int8b0":0,"int8b1":-128,"int8b2":-127,"int8b3":126,"int8b4":127,"int8b5":126,"uint8b0":0,"uint8b1":0,"uint8b2":1,"uint8b3":254,"uint8b4":255,"uint8b5":254,"int16b0":0,"int16b1":-32768,"int16b2":-32767,"int16b3":32766,"int16b4":32767,"int16b5":32766,"uint16b0":0,"uint16b1":0,"uint16b2":1,"uint16b3":65534,"uint16b4":65535,"uint16b5":65534,"int32b0":0,"int32b1":-2147483648,"int32b2":-2147483647,"int32b3":2147483646,"int32b4":2147483647,"int32b5":2147483646,"uint32b0":0,"uint32b1":0,"uint32b2":1,"uint32b3":4294967294,"uint32b4":4294967295,"uint32b5":4294967294,"int64b0":0,"int64b1":-9223372036854775807,"int64b2":-9223372036854775806,"int64b3":9223372036854775806,"int64b4":9223372036854775807,"int64b5":9223372036854775806,"uint64b0":0,"uint64b1":0,"uint64b2":1,"uint64b3":18446744073709551614,"uint64b4":18446744073709551615,"uint64b5":18446744073709551614}`)

	// Create enums from the source JSON string
	enums1, _ := enums.NewEnumsFromJSON(json)

	// Serialize enums to the JSON string
	json, _ = enums1.JSON()

	// Check the serialized JSON size
	assert.NotEmpty(t, json)

	// Deserialize enums from the JSON string
	enums2, _ := enums.NewEnumsFromJSON(json)

	assert.EqualValues(t, enums2.Byte0, enums.EnumByte_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Byte1, enums.EnumByte_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Byte2, enums.EnumByte_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Byte3, enums.EnumByte_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Byte4, enums.EnumByte_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Byte5, enums1.Byte3)

	assert.EqualValues(t, enums2.Char0, enums.EnumChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Char1, enums.EnumChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Char2, enums.EnumChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Char3, enums.EnumChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Char4, enums.EnumChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Char5, enums1.Char3)

	assert.EqualValues(t, enums2.Wchar0, enums.EnumWChar_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Wchar1, enums.EnumWChar_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Wchar2, enums.EnumWChar_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Wchar3, enums.EnumWChar_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Wchar4, enums.EnumWChar_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Wchar5, enums1.Wchar3)

	assert.EqualValues(t, enums2.Int8b0, enums.EnumInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int8b1, enums.EnumInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int8b2, enums.EnumInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int8b3, enums.EnumInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int8b4, enums.EnumInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int8b5, enums1.Int8b3)

	assert.EqualValues(t, enums2.Uint8b0, enums.EnumUInt8_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint8b1, enums.EnumUInt8_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint8b2, enums.EnumUInt8_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint8b3, enums.EnumUInt8_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint8b4, enums.EnumUInt8_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint8b5, enums1.Uint8b3)

	assert.EqualValues(t, enums2.Int16b0, enums.EnumInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int16b1, enums.EnumInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int16b2, enums.EnumInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int16b3, enums.EnumInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int16b4, enums.EnumInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int16b5, enums1.Int16b3)

	assert.EqualValues(t, enums2.Uint16b0, enums.EnumUInt16_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint16b1, enums.EnumUInt16_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint16b2, enums.EnumUInt16_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint16b3, enums.EnumUInt16_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint16b4, enums.EnumUInt16_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint16b5, enums1.Uint16b3)

	assert.EqualValues(t, enums2.Int32b0, enums.EnumInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int32b1, enums.EnumInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int32b2, enums.EnumInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int32b3, enums.EnumInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int32b4, enums.EnumInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int32b5, enums1.Int32b3)

	assert.EqualValues(t, enums2.Uint32b0, enums.EnumUInt32_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint32b1, enums.EnumUInt32_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint32b2, enums.EnumUInt32_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint32b3, enums.EnumUInt32_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint32b4, enums.EnumUInt32_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint32b5, enums1.Uint32b3)

	assert.EqualValues(t, enums2.Int64b0, enums.EnumInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Int64b1, enums.EnumInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Int64b2, enums.EnumInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Int64b3, enums.EnumInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Int64b4, enums.EnumInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Int64b5, enums1.Int64b3)

	assert.EqualValues(t, enums2.Uint64b0, enums.EnumUInt64_ENUM_VALUE_0)
	assert.EqualValues(t, enums2.Uint64b1, enums.EnumUInt64_ENUM_VALUE_1)
	assert.EqualValues(t, enums2.Uint64b2, enums.EnumUInt64_ENUM_VALUE_2)
	assert.EqualValues(t, enums2.Uint64b3, enums.EnumUInt64_ENUM_VALUE_3)
	assert.EqualValues(t, enums2.Uint64b4, enums.EnumUInt64_ENUM_VALUE_4)
	assert.EqualValues(t, enums2.Uint64b5, enums1.Uint64b3)
}
