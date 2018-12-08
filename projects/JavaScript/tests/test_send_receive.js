'use strict'

const test = require('tape')

const proto = require('../proto/proto')

class MySender extends proto.Sender {
  // noinspection JSUnusedLocalSymbols
  onSend (buffer, offset, size) {
    //  Send nothing...
    return 0
  }
}

class MyReceiver extends proto.Receiver {
  constructor () {
    super()
    this._order = false
    this._balance = false
    this._account = false
  }

  check () {
    return (this._order && this._balance && this._account)
  }

  // noinspection JSUnusedLocalSymbols
  onReceive_order (value) { this._order = true } // eslint-disable-line
  // noinspection JSUnusedLocalSymbols
  onReceive_balance (value) { this._balance = true } // eslint-disable-line
  // noinspection JSUnusedLocalSymbols
  onReceive_account (value) { this._account = true } // eslint-disable-line
}

function sendAndReceive (index) {
  let sender = new MySender()

  // Create and send a new order
  let order = new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0)
  sender.send(order)

  // Create and send a new balance wallet
  let balance = new proto.Balance('USD', 1000.0)
  sender.send(balance)

  // Create and send a new account with some orders
  let account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
  account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
  account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
  account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))
  sender.send(account)

  let receiver = new MyReceiver()

  // Receive data from the sender
  index %= sender.buffer.size
  receiver.receive(sender.buffer, 0, index)
  receiver.receive(sender.buffer, index, sender.buffer.size - index)
  return receiver.check()
}

test('Send & Receive', function (t) {
  for (let i = 0; i < 1000; i++) {
    t.true(sendAndReceive(i))
  }
  t.end()
})
