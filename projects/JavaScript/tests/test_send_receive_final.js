/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const proto = require('../proto/proto')
const protoex = require('../proto/protoex')

class MyFinalSender extends protoex.FinalSender {
  // noinspection JSUnusedLocalSymbols
  onSend (buffer, offset, size) {
    //  Send nothing...
    return 0
  }
}

class MyFinalReceiver extends protoex.FinalReceiver {
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
  onReceive_OrderMessage (value) { this._order = true } // eslint-disable-line
  // noinspection JSUnusedLocalSymbols
  onReceive_BalanceMessage (value) { this._balance = true } // eslint-disable-line
  // noinspection JSUnusedLocalSymbols
  onReceive_AccountMessage (value) { this._account = true } // eslint-disable-line
}

function sendAndReceiveFinal (index1, index2) {
  let sender = new MyFinalSender()

  // Create and send a new order
  let order = new protoex.Order(1, 'EURUSD', protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 100.0)
  sender.send(new protoex.OrderMessage(order))

  // Create and send a new balance wallet
  let balance = new protoex.Balance(new proto.Balance('USD', 1000.0), 100.0)
  sender.send(new protoex.BalanceMessage(balance))

  // Create and send a new account with some orders
  let account = new protoex.Account(1, 'Test', protoex.StateEx.good, new protoex.Balance(new proto.Balance('USD', 1000.0), 100.0), new protoex.Balance(new proto.Balance('EUR', 100.0), 10.0))
  account.orders.push(new protoex.Order(1, 'EURUSD', protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
  account.orders.push(new protoex.Order(2, 'EURUSD', protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.0, 0.0))
  account.orders.push(new protoex.Order(3, 'EURUSD', protoex.OrderSide.buy, protoex.OrderType.stop, 1.5, 10.0, 0.0, 0.0))
  sender.send(new protoex.AccountMessage(account))

  let receiver = new MyFinalReceiver()

  // Receive data from the sender
  index1 %= sender.buffer.size
  index2 %= sender.buffer.size
  index2 = Math.max(index1, index2)
  receiver.receive(sender.buffer, 0, index1)
  receiver.receive(sender.buffer, index1, index2 - index1)
  receiver.receive(sender.buffer, index2, sender.buffer.size - index2)
  return receiver.check()
}

test('Send & Receive (Final)', function (t) {
  for (let i = 0; i < 100; i++) {
    for (let j = 0; j < 100; j++) {
      t.true(sendAndReceiveFinal(i, j))
    }
  }
  t.end()
})
