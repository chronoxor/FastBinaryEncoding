/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const test = require('tape')

const proto = require('../proto/proto')

test('Copy structs', function (t) {
  // Create a new account with some orders
  let account1 = new proto.Account(1, 'Test', proto.State.good, new proto.Balance('USD', 1000.0), new proto.Balance('EUR', 100.0))
  account1.orders.push(new proto.Order(1, 'EURUSD', proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
  account1.orders.push(new proto.Order(2, 'EURUSD', proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
  account1.orders.push(new proto.Order(3, 'EURUSD', proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

  // Clone the account
  let account2 = account1.clone()

  // Clear the source account
  // noinspection JSUnusedAssignment
  account1 = new proto.Account()

  t.equal(account2.id, 1)
  t.equal(account2.name, 'Test')
  t.true(account2.state.hasFlags(proto.State.good))
  t.equal(account2.wallet.currency, 'USD')
  t.equal(account2.wallet.amount, 1000.0)
  t.notEqual(account2.asset, undefined)
  t.equal(account2.asset.currency, 'EUR')
  t.equal(account2.asset.amount, 100.0)
  t.equal(account2.orders.length, 3)
  t.equal(account2.orders[0].id, 1)
  t.equal(account2.orders[0].symbol, 'EURUSD')
  t.true(account2.orders[0].side.eq(proto.OrderSide.buy))
  t.true(account2.orders[0].type.eq(proto.OrderType.market))
  t.equal(account2.orders[0].price, 1.23456)
  t.equal(account2.orders[0].volume, 1000.0)
  t.equal(account2.orders[1].id, 2)
  t.equal(account2.orders[1].symbol, 'EURUSD')
  t.true(account2.orders[1].side.eq(proto.OrderSide.sell))
  t.true(account2.orders[1].type.eq(proto.OrderType.limit))
  t.equal(account2.orders[1].price, 1.0)
  t.equal(account2.orders[1].volume, 100.0)
  t.equal(account2.orders[2].id, 3)
  t.equal(account2.orders[2].symbol, 'EURUSD')
  t.true(account2.orders[2].side.eq(proto.OrderSide.buy))
  t.true(account2.orders[2].type.eq(proto.OrderType.stop))
  t.equal(account2.orders[2].price, 1.5)
  t.equal(account2.orders[2].volume, 10.0)
  t.end()
})
