/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const int64 = require('../proto/int64')

test('Basic tests', function (t) {
  let value1 = new int64.Int64(0xFFFFFFFF, 0x7FFFFFFF)
  t.equal(value1.toNumber(), 9223372036854775807)
  t.equal(value1.toString(), '9223372036854775807')
  let value2 = int64.Int64.fromValue(value1)
  t.equal(value2.toNumber(), 9223372036854775807)
  t.equal(value2.toString(), '9223372036854775807')
  t.end()
})

test('isInt64()/isUInt64()', function (t) {
  let value1 = new int64.Int64(0xFFFFFFFF, 0x7FFFFFFF)
  t.equal(int64.Int64.isInt64(value1), true)
  let value2 = { __isInt64__: true }
  t.equal(int64.Int64.isInt64(value2), true)
  let value3 = new int64.UInt64(0xFFFFFFFF, 0xFFFFFFFF)
  t.equal(int64.UInt64.isUInt64(value3), true)
  let value4 = { __isUInt64__: true }
  t.equal(int64.UInt64.isUInt64(value4), true)
  t.end()
})

test('toString()', function (t) {
  let value = int64.UInt64.fromBits(0xFFFFFFFF, 0xFFFFFFFF)
  t.strictEquals(value.toString(16), 'ffffffffffffffff')
  t.strictEquals(value.toString(10), '18446744073709551615')
  t.strictEquals(value.toString(8), '1777777777777777777777')
  t.strictEquals(int64.Int64.fromString('zzzzzz', 36).toString(36), 'zzzzzz')
  t.strictEquals(int64.Int64.fromString('-zzzzzz', 36).toString(36), '-zzzzzz')
  t.end()
})

test('toBytes()', function (t) {
  let value = int64.Int64.fromBits(0x01234567, 0x12345678)
  t.deepEquals(value.toBytesBE(), [
    0x12, 0x34, 0x56, 0x78,
    0x01, 0x23, 0x45, 0x67
  ])
  t.deepEquals(value.toBytesLE(), [
    0x67, 0x45, 0x23, 0x01,
    0x78, 0x56, 0x34, 0x12
  ])
  t.end()
})

test('fromBytes()', function (t) {
  let value1 = int64.Int64.fromBits(0x01234567, 0x12345678)
  let value2 = int64.UInt64.fromBits(0x01234567, 0x12345678)
  t.deepEquals(int64.Int64.fromBytes(value1.toBytes()), value1)
  t.deepEquals(int64.Int64.fromBytes([0x67, 0x45, 0x23, 0x01, 0x78, 0x56, 0x34, 0x12], true), value1)
  t.deepEquals(int64.Int64.fromBytes([0x12, 0x34, 0x56, 0x78, 0x01, 0x23, 0x45, 0x67], false), value1)
  t.deepEquals(int64.Int64.fromBytes([0x67, 0x45, 0x23, 0x01, 0x78, 0x56, 0x34, 0x12], true), value1)
  t.deepEquals(int64.UInt64.fromBytes([0x67, 0x45, 0x23, 0x01, 0x78, 0x56, 0x34, 0x12], true), value2)
  t.end()
})

test('MIN/MAX', function (t) {
  t.strictEquals(int64.Int64.MIN.toString(), '-9223372036854775808')
  t.strictEquals(int64.Int64.MAX.toString(), '9223372036854775807')
  t.strictEquals(int64.UInt64.MIN.toString(), '0')
  t.strictEquals(int64.UInt64.MAX.toString(), '18446744073709551615')
  t.end()
})

test('Unsigned construct negative', function (t) {
  let value = int64.UInt64.fromInt32(-1)
  t.strictEquals(value.low, -1)
  t.strictEquals(value.high, -1)
  t.strictEquals(value.toNumber(), 18446744073709551615)
  t.strictEquals(value.toString(), '18446744073709551615')
  t.end()
})

test('Unsigned construct low & high', function (t) {
  let value = new int64.UInt64(0xFFFFFFFF, 0xFFFFFFFF)
  t.strictEquals(value.low, -1)
  t.strictEquals(value.high, -1)
  t.strictEquals(value.toNumber(), 18446744073709551615)
  t.strictEquals(value.toString(), '18446744073709551615')
  t.end()
})

test('Unsigned construct number', function (t) {
  let value = int64.UInt64.fromNumber(0xFFFFFFFFFFFFFFFF)
  t.strictEquals(value.low, -1)
  t.strictEquals(value.high, -1)
  t.strictEquals(value.toNumber(), 18446744073709551615)
  t.strictEquals(value.toString(), '18446744073709551615')
  t.end()
})

test('Unsigned to signed unsigned', function (t) {
  let value = int64.Int64.fromNumber(-1)
  t.strictEquals(value.toNumber(), -1)
  value = value.toUnsigned()
  t.strictEquals(value.toNumber(), 0xFFFFFFFFFFFFFFFF)
  t.strictEquals(value.toString(16), 'ffffffffffffffff')
  value = value.toSigned()
  t.strictEquals(value.toNumber(), -1)
  t.end()
})

test('Unsigned MAX sub MAX signed', function (t) {
  let value = int64.UInt64.MAX.sub(int64.Int64.MAX).sub(1)
  t.strictEquals(value.toNumber(), int64.Int64.MAX.toNumber())
  t.strictEquals(value.toString(), int64.Int64.MAX.toString())
  t.end()
})

test('Unsigned MAX sub MAX', function (t) {
  let value = int64.UInt64.MAX.sub(int64.UInt64.MAX)
  t.strictEquals(value.low, 0)
  t.strictEquals(value.high, 0)
  t.strictEquals(value.toNumber(), 0)
  t.strictEquals(value.toString(), '0')
  t.end()
})

test('Unsigned Zero sub signed', function (t) {
  let value = int64.UInt64.fromInt32(0).add(int64.Int64.fromInt32(-1))
  t.strictEquals(value.low, -1)
  t.strictEquals(value.high, -1)
  t.strictEquals(value.toNumber(), 18446744073709551615)
  t.strictEquals(value.toString(), '18446744073709551615')
  t.end()
})

test('Unsigned MAX div MAX signed', function (t) {
  let value = int64.UInt64.MAX.div(int64.Int64.MAX)
  t.strictEquals(value.toNumber(), 2)
  t.strictEquals(value.toString(), '2')
  t.end()
})

test('Unsigned MAX div MAX unsigned', function (t) {
  let value = int64.UInt64.MAX
  t.strictEquals(value.div(value).toString(), '1')
  t.end()
})

test('Unsigned div negative signed', function (t) {
  let a = int64.UInt64.MAX
  let b = int64.Int64.fromInt32(-2)
  t.strictEquals(b.toUnsigned().toString(), int64.UInt64.MAX.sub(1).toString())
  let value = a.div(b)
  t.strictEquals(value.toString(), '1')
  t.end()
})

test('Unsigned MIN signed div One', function (t) {
  let value = int64.Int64.MIN.div(1)
  t.strictEquals(value.toString(), int64.Int64.MIN.toString())
  t.end()
})

test('Unsigned msb unsigned', function (t) {
  let value = int64.UInt64.fromInt32(1).shl(63)
  t.strictEquals(value.ne(int64.Int64.MIN), true)
  t.strictEquals(value.toString(), '9223372036854775808')
  t.strictEquals(int64.UInt64.fromString('9223372036854775808').toString(), '9223372036854775808')
  t.end()
})

test('Unsigned div', function (t) {
  let a = new int64.UInt64(0, 8)
  let b = int64.UInt64.fromNumber(2656901066)
  let x = a.div(b)
  t.strictEquals(x.toString(), '12')
  t.end()
})
