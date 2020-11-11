/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const proto = require('../proto/proto')

class MySender extends proto.Sender {
  // noinspection JSUnusedLocalSymbols
  onSend (buffer, offset, size) {
    // Send nothing...
    return 0
  }

  onSendLog (message) {
    console.log(`onSend: ${message}`)
  }
}

class MyReceiver extends proto.Receiver {
  onReceive_OrderMessage (value) {} // eslint-disable-line
  onReceive_BalanceMessage (value) {} // eslint-disable-line
  onReceive_AccountMessage (value) {} // eslint-disable-line

  onReceiveLog (message) {
    console.log(`onReceive: ${message}`)
  }
}

let sender = new MySender()

// Enable logging
sender.logging = true

// Create and send a new order
let order = new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0)
sender.send(new proto.OrderMessage(order))

// Create and send a new balance wallet
let balance = new proto.Balance('USD', 1000.0)
sender.send(new proto.BalanceMessage(balance))

// Create and send a new account with some orders
let account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))
sender.send(new proto.AccountMessage(account))

let receiver = new MyReceiver()

// Enable logging
receiver.logging = true

// Receive all data from the sender
receiver.receive(sender.buffer)
