/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const proto = require('../proto/proto')

// Create a new account with some orders
let account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

// Serialize the account to the JSON string
let json = JSON.stringify(account)

// Show the serialized JSON and its size
console.log(`JSON: ${json}`)
console.log(`JSON size: ${json.length}`)

// Deserialize the account from the JSON string
account = proto.Account.fromJSON(json)

// Show account content
console.log()
console.log(account)
