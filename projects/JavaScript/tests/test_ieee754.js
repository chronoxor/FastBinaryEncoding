/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const ieee754 = require('../proto/ieee754')

const EPSILON = 0.00001

test('Read float', function (t) {
  let val = 42.42
  let buf = Buffer.alloc(4)
  buf.writeFloatLE(val, 0)
  let num = ieee754.ieee754read(buf, 0, true, 23, 4)
  t.true(Math.abs(num - val) < EPSILON)
  t.end()
})

test('Write float', function (t) {
  let val = 42.42
  let buf = Buffer.alloc(4)
  ieee754.ieee754write(buf, 0, val, true, 23, 4)
  let num = buf.readFloatLE(0)
  t.true(Math.abs(num - val) < EPSILON)
  t.end()
})

test('Read double', function (t) {
  let value = 12345.123456789
  let buf = Buffer.alloc(8)
  buf.writeDoubleLE(value, 0)
  let num = ieee754.ieee754read(buf, 0, true, 52, 8)
  t.true(Math.abs(num - value) < EPSILON)
  t.end()
})

test('Write double', function (t) {
  let value = 12345.123456789
  let buf = Buffer.alloc(8)
  ieee754.ieee754write(buf, 0, value, true, 52, 8)
  let num = buf.readDoubleLE(0)
  t.true(Math.abs(num - value) < EPSILON)
  t.end()
})
