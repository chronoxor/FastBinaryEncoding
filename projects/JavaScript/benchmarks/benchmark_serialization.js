'use strict'

const benchmark = require('benchmark')

const fbe = require('../proto/fbe')
const proto = require('../proto/proto')

const suite = new benchmark.Suite('Serialization')

suite.on('start', function () {
  // Create a new account with some orders
  this.account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
  this.account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
  this.account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
  this.account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

  // Serialize the account to the FBE stream
  this.writer = new proto.AccountModel(new fbe.WriteBuffer())
  this.writer.serialize(this.account)
  console.assert(this.writer.verify())

  // Deserialize the account from the FBE stream
  this.reader = new proto.AccountModel(new fbe.ReadBuffer())
  this.reader.attachBuffer(this.writer.buffer)
  console.assert(this.reader.verify())
  this.reader.deserialize(this.account)
})

suite.on('cycle', function (event) {
  console.log(String(event.target))
})

suite.add('Serialize', function () {
  // Reset FBE stream
  suite.writer.reset()

  // Serialize the account to the FBE stream
  suite.writer.serialize(suite.account)
})

suite.add('Deserialize', function () {
  // Deserialize the account from the FBE stream
  suite.reader.deserialize(suite.account)
})

suite.add('Verify', function () {
  // Verify the account
  suite.writer.verify()
})

suite.run({ async: true })
