/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const big = require('../proto/big')
const fbe = require('../proto/fbe')

const Big = big.Big

let writeUInt32 = function (buffer, offset, value) {
  value = +value
  offset = offset >>> 0
  buffer[offset + 0] = (value & 0xFF)
  buffer[offset + 1] = (value >>> 8)
  buffer[offset + 2] = (value >>> 16)
  buffer[offset + 3] = (value >>> 24)
}

let verifyDecimal = function (low, mid, high, negative, scale) {
  let flags = negative ? ((scale << 16) | 0x80000000) : (scale << 16)

  let buffer = new Uint8Array(16)
  writeUInt32(buffer, 0, low)
  writeUInt32(buffer, 4, mid)
  writeUInt32(buffer, 8, high)
  writeUInt32(buffer, 12, flags)

  let readBuffer = new fbe.ReadBuffer()
  readBuffer.attachBuffer(buffer)

  let model = new fbe.FieldModelDecimal(readBuffer, 0)
  let value1 = model.get()
  model.set(value1)
  let value2 = model.get()

  if (!value1.eq(value2)) {
    throw new Error('Invalid decimal serialization!')
  }

  let finalModel = new fbe.FinalModelDecimal(readBuffer, 0)
  let value3 = finalModel.get()
  model.set(value3.value)
  let value4 = finalModel.get()

  if ((!value1.eq(value3.value)) || (!value2.eq(value4.value)) || (value3.size !== 16) || (value4.size !== 16)) {
    throw new Error('Invalid decimal final serialization!')
  }

  return value1
}

test('Decimal tests', function (t) {
  // FBE decimal exponent ranging from 0 to 28
  Big.DP = 29
  t.true(verifyDecimal(0x00000000, 0x00000000, 0x00000000, false, 0x00000000).eq(new Big('0')))
  t.true(verifyDecimal(0x00000001, 0x00000000, 0x00000000, false, 0x00000000).eq(new Big('1')))
  t.true(verifyDecimal(0x107A4000, 0x00005AF3, 0x00000000, false, 0x00000000).eq(new Big('100000000000000')))
  t.true(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x000E0000 >> 16).eq(new Big('100000000000000.00000000000000')))
  t.true(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x00000000).eq(new Big('10000000000000000000000000000')))
  t.true(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x001C0000 >> 16).eq(new Big('1.0000000000000000000000000000')))
  t.true(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00000000).eq(new Big('123456789')))
  t.true(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00090000 >> 16).eq(new Big('0.123456789')))
  t.true(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00120000 >> 16).eq(new Big('0.000000000123456789')))
  t.true(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x001B0000 >> 16).eq(new Big('0.000000000000000000123456789')))
  t.true(verifyDecimal(0xFFFFFFFF, 0x00000000, 0x00000000, false, 0x00000000).eq(new Big('4294967295')))
  t.true(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, false, 0x00000000).eq(new Big('18446744073709551615')))
  t.true(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, false, 0x00000000).eq(new Big('79228162514264337593543950335')))
  t.true(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x00000000).eq(new Big('-79228162514264337593543950335')))
  t.true(verifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x001C0000 >> 16).eq(new Big('-7.9228162514264337593543950335')))
  t.end()
})
