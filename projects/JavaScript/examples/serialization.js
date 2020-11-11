/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const fbe = require('../proto/fbe')
const proto = require('../proto/proto')

// Create a new account with some orders
let account = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
account.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
account.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
account.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

// Serialize the account to the FBE stream
let writer = new proto.AccountModel(new fbe.WriteBuffer())
writer.serialize(account)
console.assert(writer.verify())

// Show the serialized FBE size
console.log(`FBE size: ${writer.buffer.size}`)

// Deserialize the account from the FBE stream
let reader = new proto.AccountModel(new fbe.ReadBuffer())
reader.attachBuffer(writer.buffer)
console.assert(reader.verify())
reader.deserialize(account)

// Show account content
console.log()
console.log(account)
