'use strict'

const benchmark = require('benchmark')

const proto = require('../proto/proto')

class MySender1 extends proto.Sender {
  constructor () {
    super()
    this._size = 0
    this._log_size = 0
  }

  get size () {
    return this._size
  }

  get logSize () {
    return this._log_size
  }

  // noinspection JSUnusedLocalSymbols
  onSend (buffer, offset, size) {
    this._size += size
    return size
  }

  onSendLog (message) {
    this._log_size += message.length
  }
}

class MySender2 extends proto.Sender {
  constructor () {
    super()
    this._size = 0
    this._log_size = 0
  }

  get size () {
    return this._size
  }

  get logSize () {
    return this._log_size
  }

  // noinspection JSUnusedLocalSymbols
  onSend (buffer, offset, size) {
    this._size += size
    return 0
  }

  onSendLog (message) {
    this._log_size += message.length
  }
}

class MyReceiver extends proto.Receiver {
  constructor () {
    super()
    this._log_size = 0
  }

  get logSize () {
    return this._log_size
  }

  onReceive_OrderMessage (value) {} // eslint-disable-line
  onReceive_BalanceMessage (value) {} // eslint-disable-line
  onReceive_AccountMessage (value) {} // eslint-disable-line

  onReceiveLog (message) {
    this._log_size += message.length
  }
}

const suite = new benchmark.Suite('Send & Receive')

suite.on('start', function () {
  // Create a new account with some orders
  this.account = new proto.AccountMessage(new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0)))
  this.account.body.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
  this.account.body.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
  this.account.body.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

  this.sender1 = new MySender1()
  this.sender1.send(this.account)

  this.sender2 = new MySender2()
  this.sender2.send(this.account)

  this.receiver = new MyReceiver()
  this.receiver.receive(this.sender2.buffer)
})

suite.on('cycle', function (event) {
  console.log(String(event.target))
})

suite.add('Send', function () {
  // Serialize and send the account
  suite.sender1.send(suite.account)
})

suite.add('Send with logs', function () {
  // Enable logging
  suite.sender1.logging = true

  // Serialize and send the account
  suite.sender1.send(suite.account)
})

suite.add('Receive', function () {
  // Receive the account from the sender
  suite.receiver.receive(suite.sender2.buffer)
})

suite.add('Receive with logs', function () {
  // Enable logging
  suite.receiver.logging = true

  // Receive the account from the sender
  suite.receiver.receive(suite.sender2.buffer)
})

suite.run({ async: true })
