/* eslint-disable prefer-const,no-loss-of-precision */
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
  // Define a source JSON string
  let json = String.raw`{"byte0":0,"byte1":0,"byte2":1,"byte3":254,"byte4":255,"byte5":254,"char0":0,"char1":49,"char2":50,"char3":51,"char4":52,"char5":51,"wchar0":0,"wchar1":1092,"wchar2":1093,"wchar3":1365,"wchar4":1366,"wchar5":1365,"int8b0":0,"int8b1":-128,"int8b2":-127,"int8b3":126,"int8b4":127,"int8b5":126,"uint8b0":0,"uint8b1":0,"uint8b2":1,"uint8b3":254,"uint8b4":255,"uint8b5":254,"int16b0":0,"int16b1":-32768,"int16b2":-32767,"int16b3":32766,"int16b4":32767,"int16b5":32766,"uint16b0":0,"uint16b1":0,"uint16b2":1,"uint16b3":65534,"uint16b4":65535,"uint16b5":65534,"int32b0":0,"int32b1":-2147483648,"int32b2":-2147483647,"int32b3":2147483646,"int32b4":2147483647,"int32b5":2147483646,"uint32b0":0,"uint32b1":0,"uint32b2":1,"uint32b3":4294967294,"uint32b4":4294967295,"uint32b5":4294967294,"int64b0":0,"int64b1":-9223372036854775807,"int64b2":-9223372036854775806,"int64b3":9223372036854775806,"int64b4":9223372036854775807,"int64b5":9223372036854775806,"uint64b0":0,"uint64b1":0,"uint64b2":1,"uint64b3":18446744073709551614,"uint64b4":18446744073709551615,"uint64b5":18446744073709551614}`

  // Create enums from the source JSON string
  let enums1 = enums.Enums.fromJSON(json)

  // Serialize enums to the JSON stream
  json = JSON.stringify(enums1)

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
