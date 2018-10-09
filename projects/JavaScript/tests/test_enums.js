'use strict'

const test = require('tape')

const fbe = require('../proto/fbe')
const enums = require('../proto/enums')

test('Serialization: enums', function (t) {
  let enums1 = new enums.Enums()

  // Serialize enums to the FBE stream
  let writer = new enums.EnumsModel(new fbe.WriteBuffer())
  t.equal(writer.model.fbeOffset, 4)
  let serialized = writer.serialize(enums1)
  t.equal(serialized, writer.buffer.size)
  t.true(writer.verify())
  writer.next(serialized)
  t.equal(writer.model.fbeOffset, (4 + writer.buffer.size))

  // Check the serialized FBE size
  t.equal(writer.buffer.size, 232)

  // Deserialize enums from the FBE stream
  let enums2 = new enums.Enums()
  let reader = new enums.EnumsModel(new fbe.ReadBuffer())
  t.equal(reader.model.fbeOffset, 4)
  reader.attachBuffer(writer.buffer)
  t.true(reader.verify())
  let deserialized = reader.deserialize(enums2)
  t.true(deserialized.size, reader.buffer.size)
  reader.next(deserialized.size)
  t.true(reader.model.fbeOffset, (4 + reader.buffer.size))

  t.true(enums2.byte0.eq(enums.EnumByte.ENUM_VALUE_0))
  t.true(enums2.byte1.eq(enums.EnumByte.ENUM_VALUE_1))
  t.true(enums2.byte2.eq(enums.EnumByte.ENUM_VALUE_2))
  t.true(enums2.byte3.eq(enums.EnumByte.ENUM_VALUE_3))
  t.true(enums2.byte4.eq(enums.EnumByte.ENUM_VALUE_4))
  t.true(enums2.byte5.eq(enums1.byte3))

  t.true(enums2.char0.eq(enums.EnumChar.ENUM_VALUE_0))
  t.true(enums2.char1.eq(enums.EnumChar.ENUM_VALUE_1))
  t.true(enums2.char2.eq(enums.EnumChar.ENUM_VALUE_2))
  t.true(enums2.char3.eq(enums.EnumChar.ENUM_VALUE_3))
  t.true(enums2.char4.eq(enums.EnumChar.ENUM_VALUE_4))
  t.true(enums2.char5.eq(enums1.char3))

  t.true(enums2.wchar0.eq(enums.EnumWChar.ENUM_VALUE_0))
  t.true(enums2.wchar1.eq(enums.EnumWChar.ENUM_VALUE_1))
  t.true(enums2.wchar2.eq(enums.EnumWChar.ENUM_VALUE_2))
  t.true(enums2.wchar3.eq(enums.EnumWChar.ENUM_VALUE_3))
  t.true(enums2.wchar4.eq(enums.EnumWChar.ENUM_VALUE_4))
  t.true(enums2.wchar5.eq(enums1.wchar3))

  t.true(enums2.int8b0.eq(enums.EnumInt8.ENUM_VALUE_0))
  t.true(enums2.int8b1.eq(enums.EnumInt8.ENUM_VALUE_1))
  t.true(enums2.int8b2.eq(enums.EnumInt8.ENUM_VALUE_2))
  t.true(enums2.int8b3.eq(enums.EnumInt8.ENUM_VALUE_3))
  t.true(enums2.int8b4.eq(enums.EnumInt8.ENUM_VALUE_4))
  t.true(enums2.int8b5.eq(enums1.int8b3))

  t.true(enums2.uint8b0.eq(enums.EnumUInt8.ENUM_VALUE_0))
  t.true(enums2.uint8b1.eq(enums.EnumUInt8.ENUM_VALUE_1))
  t.true(enums2.uint8b2.eq(enums.EnumUInt8.ENUM_VALUE_2))
  t.true(enums2.uint8b3.eq(enums.EnumUInt8.ENUM_VALUE_3))
  t.true(enums2.uint8b4.eq(enums.EnumUInt8.ENUM_VALUE_4))
  t.true(enums2.uint8b5.eq(enums1.uint8b3))

  t.true(enums2.int16b0.eq(enums.EnumInt16.ENUM_VALUE_0))
  t.true(enums2.int16b1.eq(enums.EnumInt16.ENUM_VALUE_1))
  t.true(enums2.int16b2.eq(enums.EnumInt16.ENUM_VALUE_2))
  t.true(enums2.int16b3.eq(enums.EnumInt16.ENUM_VALUE_3))
  t.true(enums2.int16b4.eq(enums.EnumInt16.ENUM_VALUE_4))
  t.true(enums2.int16b5.eq(enums1.int16b3))

  t.true(enums2.uint16b0.eq(enums.EnumUInt16.ENUM_VALUE_0))
  t.true(enums2.uint16b1.eq(enums.EnumUInt16.ENUM_VALUE_1))
  t.true(enums2.uint16b2.eq(enums.EnumUInt16.ENUM_VALUE_2))
  t.true(enums2.uint16b3.eq(enums.EnumUInt16.ENUM_VALUE_3))
  t.true(enums2.uint16b4.eq(enums.EnumUInt16.ENUM_VALUE_4))
  t.true(enums2.uint16b5.eq(enums1.uint16b3))

  t.true(enums2.int32b0.eq(enums.EnumInt32.ENUM_VALUE_0))
  t.true(enums2.int32b1.eq(enums.EnumInt32.ENUM_VALUE_1))
  t.true(enums2.int32b2.eq(enums.EnumInt32.ENUM_VALUE_2))
  t.true(enums2.int32b3.eq(enums.EnumInt32.ENUM_VALUE_3))
  t.true(enums2.int32b4.eq(enums.EnumInt32.ENUM_VALUE_4))
  t.true(enums2.int32b5.eq(enums1.int32b3))

  t.true(enums2.uint32b0.eq(enums.EnumUInt32.ENUM_VALUE_0))
  t.true(enums2.uint32b1.eq(enums.EnumUInt32.ENUM_VALUE_1))
  t.true(enums2.uint32b2.eq(enums.EnumUInt32.ENUM_VALUE_2))
  t.true(enums2.uint32b3.eq(enums.EnumUInt32.ENUM_VALUE_3))
  t.true(enums2.uint32b4.eq(enums.EnumUInt32.ENUM_VALUE_4))
  t.true(enums2.uint32b5.eq(enums1.uint32b3))

  t.true(enums2.int64b0.eq(enums.EnumInt64.ENUM_VALUE_0))
  t.true(enums2.int64b1.eq(enums.EnumInt64.ENUM_VALUE_1))
  t.true(enums2.int64b2.eq(enums.EnumInt64.ENUM_VALUE_2))
  t.true(enums2.int64b3.eq(enums.EnumInt64.ENUM_VALUE_3))
  t.true(enums2.int64b4.eq(enums.EnumInt64.ENUM_VALUE_4))
  t.true(enums2.int64b5.eq(enums1.int64b3))

  t.true(enums2.uint64b0.eq(enums.EnumUInt64.ENUM_VALUE_0))
  t.true(enums2.uint64b1.eq(enums.EnumUInt64.ENUM_VALUE_1))
  t.true(enums2.uint64b2.eq(enums.EnumUInt64.ENUM_VALUE_2))
  t.true(enums2.uint64b3.eq(enums.EnumUInt64.ENUM_VALUE_3))
  t.true(enums2.uint64b4.eq(enums.EnumUInt64.ENUM_VALUE_4))
  t.true(enums2.uint64b5.eq(enums1.uint64b3))
  t.end()
})

test('Serialization (Final): enums', function (t) {
  let enums1 = new enums.Enums()

  // Serialize enums to the FBE stream
  let writer = new enums.EnumsFinalModel(new fbe.WriteBuffer())
  let serialized = writer.serialize(enums1)
  t.equal(serialized, writer.buffer.size)
  t.true(writer.verify())
  writer.next(serialized)

  // Check the serialized FBE size
  t.equal(writer.buffer.size, 224)

  // Deserialize enums from the FBE stream
  let enums2 = new enums.Enums()
  let reader = new enums.EnumsFinalModel(new fbe.ReadBuffer())
  reader.attachBuffer(writer.buffer)
  t.true(reader.verify())
  let deserialized = reader.deserialize(enums2)
  t.true(deserialized.size, reader.buffer.size)
  reader.next(deserialized.size)

  t.true(enums2.byte0.eq(enums.EnumByte.ENUM_VALUE_0))
  t.true(enums2.byte1.eq(enums.EnumByte.ENUM_VALUE_1))
  t.true(enums2.byte2.eq(enums.EnumByte.ENUM_VALUE_2))
  t.true(enums2.byte3.eq(enums.EnumByte.ENUM_VALUE_3))
  t.true(enums2.byte4.eq(enums.EnumByte.ENUM_VALUE_4))
  t.true(enums2.byte5.eq(enums1.byte3))

  t.true(enums2.char0.eq(enums.EnumChar.ENUM_VALUE_0))
  t.true(enums2.char1.eq(enums.EnumChar.ENUM_VALUE_1))
  t.true(enums2.char2.eq(enums.EnumChar.ENUM_VALUE_2))
  t.true(enums2.char3.eq(enums.EnumChar.ENUM_VALUE_3))
  t.true(enums2.char4.eq(enums.EnumChar.ENUM_VALUE_4))
  t.true(enums2.char5.eq(enums1.char3))

  t.true(enums2.wchar0.eq(enums.EnumWChar.ENUM_VALUE_0))
  t.true(enums2.wchar1.eq(enums.EnumWChar.ENUM_VALUE_1))
  t.true(enums2.wchar2.eq(enums.EnumWChar.ENUM_VALUE_2))
  t.true(enums2.wchar3.eq(enums.EnumWChar.ENUM_VALUE_3))
  t.true(enums2.wchar4.eq(enums.EnumWChar.ENUM_VALUE_4))
  t.true(enums2.wchar5.eq(enums1.wchar3))

  t.true(enums2.int8b0.eq(enums.EnumInt8.ENUM_VALUE_0))
  t.true(enums2.int8b1.eq(enums.EnumInt8.ENUM_VALUE_1))
  t.true(enums2.int8b2.eq(enums.EnumInt8.ENUM_VALUE_2))
  t.true(enums2.int8b3.eq(enums.EnumInt8.ENUM_VALUE_3))
  t.true(enums2.int8b4.eq(enums.EnumInt8.ENUM_VALUE_4))
  t.true(enums2.int8b5.eq(enums1.int8b3))

  t.true(enums2.uint8b0.eq(enums.EnumUInt8.ENUM_VALUE_0))
  t.true(enums2.uint8b1.eq(enums.EnumUInt8.ENUM_VALUE_1))
  t.true(enums2.uint8b2.eq(enums.EnumUInt8.ENUM_VALUE_2))
  t.true(enums2.uint8b3.eq(enums.EnumUInt8.ENUM_VALUE_3))
  t.true(enums2.uint8b4.eq(enums.EnumUInt8.ENUM_VALUE_4))
  t.true(enums2.uint8b5.eq(enums1.uint8b3))

  t.true(enums2.int16b0.eq(enums.EnumInt16.ENUM_VALUE_0))
  t.true(enums2.int16b1.eq(enums.EnumInt16.ENUM_VALUE_1))
  t.true(enums2.int16b2.eq(enums.EnumInt16.ENUM_VALUE_2))
  t.true(enums2.int16b3.eq(enums.EnumInt16.ENUM_VALUE_3))
  t.true(enums2.int16b4.eq(enums.EnumInt16.ENUM_VALUE_4))
  t.true(enums2.int16b5.eq(enums1.int16b3))

  t.true(enums2.uint16b0.eq(enums.EnumUInt16.ENUM_VALUE_0))
  t.true(enums2.uint16b1.eq(enums.EnumUInt16.ENUM_VALUE_1))
  t.true(enums2.uint16b2.eq(enums.EnumUInt16.ENUM_VALUE_2))
  t.true(enums2.uint16b3.eq(enums.EnumUInt16.ENUM_VALUE_3))
  t.true(enums2.uint16b4.eq(enums.EnumUInt16.ENUM_VALUE_4))
  t.true(enums2.uint16b5.eq(enums1.uint16b3))

  t.true(enums2.int32b0.eq(enums.EnumInt32.ENUM_VALUE_0))
  t.true(enums2.int32b1.eq(enums.EnumInt32.ENUM_VALUE_1))
  t.true(enums2.int32b2.eq(enums.EnumInt32.ENUM_VALUE_2))
  t.true(enums2.int32b3.eq(enums.EnumInt32.ENUM_VALUE_3))
  t.true(enums2.int32b4.eq(enums.EnumInt32.ENUM_VALUE_4))
  t.true(enums2.int32b5.eq(enums1.int32b3))

  t.true(enums2.uint32b0.eq(enums.EnumUInt32.ENUM_VALUE_0))
  t.true(enums2.uint32b1.eq(enums.EnumUInt32.ENUM_VALUE_1))
  t.true(enums2.uint32b2.eq(enums.EnumUInt32.ENUM_VALUE_2))
  t.true(enums2.uint32b3.eq(enums.EnumUInt32.ENUM_VALUE_3))
  t.true(enums2.uint32b4.eq(enums.EnumUInt32.ENUM_VALUE_4))
  t.true(enums2.uint32b5.eq(enums1.uint32b3))

  t.true(enums2.int64b0.eq(enums.EnumInt64.ENUM_VALUE_0))
  t.true(enums2.int64b1.eq(enums.EnumInt64.ENUM_VALUE_1))
  t.true(enums2.int64b2.eq(enums.EnumInt64.ENUM_VALUE_2))
  t.true(enums2.int64b3.eq(enums.EnumInt64.ENUM_VALUE_3))
  t.true(enums2.int64b4.eq(enums.EnumInt64.ENUM_VALUE_4))
  t.true(enums2.int64b5.eq(enums1.int64b3))

  t.true(enums2.uint64b0.eq(enums.EnumUInt64.ENUM_VALUE_0))
  t.true(enums2.uint64b1.eq(enums.EnumUInt64.ENUM_VALUE_1))
  t.true(enums2.uint64b2.eq(enums.EnumUInt64.ENUM_VALUE_2))
  t.true(enums2.uint64b3.eq(enums.EnumUInt64.ENUM_VALUE_3))
  t.true(enums2.uint64b4.eq(enums.EnumUInt64.ENUM_VALUE_4))
  t.true(enums2.uint64b5.eq(enums1.uint64b3))
  t.end()
})

test('Serialization (JSON): enums', function (t) {
  let enums1 = new enums.Enums()

  // Serialize enums to the JSON stream
  let json = JSON.stringify(enums1)

  // Check the serialized JSON size
  t.true(json.length > 0)

  // Deserialize enums from the JSON stream
  let enums2 = enums.Enums.fromJSON(json)

  t.true(enums2.byte0.eq(enums.EnumByte.ENUM_VALUE_0))
  t.true(enums2.byte1.eq(enums.EnumByte.ENUM_VALUE_1))
  t.true(enums2.byte2.eq(enums.EnumByte.ENUM_VALUE_2))
  t.true(enums2.byte3.eq(enums.EnumByte.ENUM_VALUE_3))
  t.true(enums2.byte4.eq(enums.EnumByte.ENUM_VALUE_4))
  t.true(enums2.byte5.eq(enums1.byte3))

  t.true(enums2.char0.eq(enums.EnumChar.ENUM_VALUE_0))
  t.true(enums2.char1.eq(enums.EnumChar.ENUM_VALUE_1))
  t.true(enums2.char2.eq(enums.EnumChar.ENUM_VALUE_2))
  t.true(enums2.char3.eq(enums.EnumChar.ENUM_VALUE_3))
  t.true(enums2.char4.eq(enums.EnumChar.ENUM_VALUE_4))
  t.true(enums2.char5.eq(enums1.char3))

  t.true(enums2.wchar0.eq(enums.EnumWChar.ENUM_VALUE_0))
  t.true(enums2.wchar1.eq(enums.EnumWChar.ENUM_VALUE_1))
  t.true(enums2.wchar2.eq(enums.EnumWChar.ENUM_VALUE_2))
  t.true(enums2.wchar3.eq(enums.EnumWChar.ENUM_VALUE_3))
  t.true(enums2.wchar4.eq(enums.EnumWChar.ENUM_VALUE_4))
  t.true(enums2.wchar5.eq(enums1.wchar3))

  t.true(enums2.int8b0.eq(enums.EnumInt8.ENUM_VALUE_0))
  t.true(enums2.int8b1.eq(enums.EnumInt8.ENUM_VALUE_1))
  t.true(enums2.int8b2.eq(enums.EnumInt8.ENUM_VALUE_2))
  t.true(enums2.int8b3.eq(enums.EnumInt8.ENUM_VALUE_3))
  t.true(enums2.int8b4.eq(enums.EnumInt8.ENUM_VALUE_4))
  t.true(enums2.int8b5.eq(enums1.int8b3))

  t.true(enums2.uint8b0.eq(enums.EnumUInt8.ENUM_VALUE_0))
  t.true(enums2.uint8b1.eq(enums.EnumUInt8.ENUM_VALUE_1))
  t.true(enums2.uint8b2.eq(enums.EnumUInt8.ENUM_VALUE_2))
  t.true(enums2.uint8b3.eq(enums.EnumUInt8.ENUM_VALUE_3))
  t.true(enums2.uint8b4.eq(enums.EnumUInt8.ENUM_VALUE_4))
  t.true(enums2.uint8b5.eq(enums1.uint8b3))

  t.true(enums2.int16b0.eq(enums.EnumInt16.ENUM_VALUE_0))
  t.true(enums2.int16b1.eq(enums.EnumInt16.ENUM_VALUE_1))
  t.true(enums2.int16b2.eq(enums.EnumInt16.ENUM_VALUE_2))
  t.true(enums2.int16b3.eq(enums.EnumInt16.ENUM_VALUE_3))
  t.true(enums2.int16b4.eq(enums.EnumInt16.ENUM_VALUE_4))
  t.true(enums2.int16b5.eq(enums1.int16b3))

  t.true(enums2.uint16b0.eq(enums.EnumUInt16.ENUM_VALUE_0))
  t.true(enums2.uint16b1.eq(enums.EnumUInt16.ENUM_VALUE_1))
  t.true(enums2.uint16b2.eq(enums.EnumUInt16.ENUM_VALUE_2))
  t.true(enums2.uint16b3.eq(enums.EnumUInt16.ENUM_VALUE_3))
  t.true(enums2.uint16b4.eq(enums.EnumUInt16.ENUM_VALUE_4))
  t.true(enums2.uint16b5.eq(enums1.uint16b3))

  t.true(enums2.int32b0.eq(enums.EnumInt32.ENUM_VALUE_0))
  t.true(enums2.int32b1.eq(enums.EnumInt32.ENUM_VALUE_1))
  t.true(enums2.int32b2.eq(enums.EnumInt32.ENUM_VALUE_2))
  t.true(enums2.int32b3.eq(enums.EnumInt32.ENUM_VALUE_3))
  t.true(enums2.int32b4.eq(enums.EnumInt32.ENUM_VALUE_4))
  t.true(enums2.int32b5.eq(enums1.int32b3))

  t.true(enums2.uint32b0.eq(enums.EnumUInt32.ENUM_VALUE_0))
  t.true(enums2.uint32b1.eq(enums.EnumUInt32.ENUM_VALUE_1))
  t.true(enums2.uint32b2.eq(enums.EnumUInt32.ENUM_VALUE_2))
  t.true(enums2.uint32b3.eq(enums.EnumUInt32.ENUM_VALUE_3))
  t.true(enums2.uint32b4.eq(enums.EnumUInt32.ENUM_VALUE_4))
  t.true(enums2.uint32b5.eq(enums1.uint32b3))

  t.true(enums2.int64b0.eq(enums.EnumInt64.ENUM_VALUE_0))
  t.true(enums2.int64b1.eq(enums.EnumInt64.ENUM_VALUE_1))
  t.true(enums2.int64b2.eq(enums.EnumInt64.ENUM_VALUE_2))
  t.true(enums2.int64b3.eq(enums.EnumInt64.ENUM_VALUE_3))
  t.true(enums2.int64b4.eq(enums.EnumInt64.ENUM_VALUE_4))
  t.true(enums2.int64b5.eq(enums1.int64b3))

  t.true(enums2.uint64b0.eq(enums.EnumUInt64.ENUM_VALUE_0))
  t.true(enums2.uint64b1.eq(enums.EnumUInt64.ENUM_VALUE_1))
  t.true(enums2.uint64b2.eq(enums.EnumUInt64.ENUM_VALUE_2))
  t.true(enums2.uint64b3.eq(enums.EnumUInt64.ENUM_VALUE_3))
  t.true(enums2.uint64b4.eq(enums.EnumUInt64.ENUM_VALUE_4))
  t.true(enums2.uint64b5.eq(enums1.uint64b3))
  t.end()
})
