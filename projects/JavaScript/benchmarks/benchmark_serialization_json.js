'use strict'

const benchmark = require('benchmark')

const proto = require('../proto/proto')

const suite = new benchmark.Suite('Serialization (JSON)')

suite.on('start', function () {
  // Create a new account with some orders
  this.account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
  this.account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
  this.account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
  this.account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

  // Serialize the account to the JSON string
  this.json = JSON.stringify(this.account)

  // Deserialize the account from the JSON string
  this.account = proto.Account.fromJSON(this.json)
})

suite.on('cycle', function (event) {
  console.log(String(event.target))
})

suite.add('Serialize (JSON)', function () {
  // Serialize the account to the JSON string
  suite.json = JSON.stringify(suite.account)
})

suite.add('Deserialize (JSON)', function () {
  // Deserialize the account from the JSON string
  suite.account = proto.Account.fromJSON(suite.json)
})

suite.run({ async: true })
