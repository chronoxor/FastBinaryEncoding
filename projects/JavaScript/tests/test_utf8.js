/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const utf8 = require('../proto/utf8')

test('UTF-8 encode', function (t) {
  let utf8str = '¡hέlló wôrld!'
  let count = utf8.utf8count(utf8str)
  let buffer = new Uint8Array(count)
  utf8.utf8encode(buffer, 0, utf8str)
  let str = utf8.utf8decode(buffer, 0, buffer.length)
  t.equal(str, utf8str)
  t.end()
})

test('UTF-8 decode', function (t) {
  let utf8str = 'ö日本語'
  let utf8buf = new Uint8Array([0xC3, 0xB6, 0xE6, 0x97, 0xA5, 0xE6, 0x9C, 0xAC, 0xE8, 0xAA, 0x9E])
  let str = utf8.utf8decode(utf8buf, 0, utf8buf.length)
  let count = utf8.utf8count(str)
  let buffer = new Uint8Array(count)
  utf8.utf8encode(buffer, 0, str)
  t.equal(str, utf8str)
  t.true(buffer.every((v, i) => v === utf8buf[i]))
  t.end()
})
