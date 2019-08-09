
//  Serialization.swift
//  FastBinaryEncodingTests
//
//  Created by Andrew Zbranevich on 8/8/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import FastBinaryEncoding

class Serialization: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Create a new account with some orders
        let account1 = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account1.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account1.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account1.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        // Serialize the account to the FBE stream
        let writer = AccountModel()
        XCTAssertEqual(writer.model.fbeOffset, 4)
        let serialized = try! writer.serialize(value: account1)
        XCTAssertEqual(serialized, writer.buffer.size)
        XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)
        XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        XCTAssertEqual(writer.buffer.size, 252)

        // Deserialize the account from the FBE stream
        var account2 = Account()
        let reader = AccountModel()
        XCTAssertEqual(reader.model.fbeOffset, 4)
        reader.attach(buffer: writer.buffer)
        XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &account2)
        XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)
        XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)

        XCTAssertEqual(account2.id, 1)
        XCTAssertEqual(account2.name, "Test")
        XCTAssertTrue(account2.state.hasFlags(flags: State.good))
        XCTAssertEqual(account2.wallet.currency, "USD")
        XCTAssertEqual(account2.wallet.amount, 1000.0)
        XCTAssertFalse((account2.asset == nil))
        XCTAssertEqual(account2.asset!.currency, "EUR")
        XCTAssertEqual(account2.asset!.amount, 100.0)
        XCTAssertEqual(account2.orders.count, 3)
        XCTAssertEqual(account2.orders[0].id, 1)
        XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[0].side, OrderSide.buy)
        XCTAssertEqual(account2.orders[0].type, OrderType.market)
        XCTAssertEqual(account2.orders[0].price, 1.23456)
        XCTAssertEqual(account2.orders[0].volume, 1000.0)
        XCTAssertEqual(account2.orders[1].id, 2)
        XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[1].side, OrderSide.sell)
        XCTAssertEqual(account2.orders[1].type, OrderType.limit)
        XCTAssertEqual(account2.orders[1].price, 1.0)
        XCTAssertEqual(account2.orders[1].volume, 100.0)
        XCTAssertEqual(account2.orders[2].id, 3)
        XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[2].side, OrderSide.buy)
        XCTAssertEqual(account2.orders[2].type, OrderType.stop)
        XCTAssertEqual(account2.orders[2].price, 1.5)
        XCTAssertEqual(account2.orders[2].volume, 10.0)
    }
    
    func testSerializationDomain()
      {
          // Create a new account with some orders
          let account1 = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account1.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account1.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account1.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

          // Serialize the account to the FBE stream
        let writer = AccountFinalModel(buffer: Buffer())
        let serialized = try! writer.serialize(value: account1)
          XCTAssertEqual(serialized, writer.buffer.size)
          XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)

          // Check the serialized FBE size
          XCTAssertEqual(writer.buffer.size, 152)

          // Deserialize the account from the FBE stream
        var account2 = Account()
        let reader = AccountFinalModel(buffer: Buffer())
        reader.attach(buffer: writer.buffer)
          XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &account2)
          XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)

          XCTAssertEqual(account2.id, 1)
          XCTAssertEqual(account2.name, "Test")
        XCTAssertTrue(account2.state.hasFlags(flags: State.good))
          XCTAssertEqual(account2.wallet.currency, "USD")
          XCTAssertEqual(account2.wallet.amount, 1000.0)
          XCTAssertNotEqual(account2.asset, nil)
          XCTAssertEqual(account2.asset!.currency, "EUR")
          XCTAssertEqual(account2.asset!.amount, 100.0)
          XCTAssertEqual(account2.orders.count, 3)
          XCTAssertEqual(account2.orders[0].id, 1)
          XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
          XCTAssertEqual(account2.orders[0].side, OrderSide.buy)
          XCTAssertEqual(account2.orders[0].type, OrderType.market)
          XCTAssertEqual(account2.orders[0].price, 1.23456)
          XCTAssertEqual(account2.orders[0].volume, 1000.0)
          XCTAssertEqual(account2.orders[1].id, 2)
          XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
          XCTAssertEqual(account2.orders[1].side, OrderSide.sell)
          XCTAssertEqual(account2.orders[1].type, OrderType.limit)
          XCTAssertEqual(account2.orders[1].price, 1.0)
          XCTAssertEqual(account2.orders[1].volume, 100.0)
          XCTAssertEqual(account2.orders[2].id, 3)
          XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
          XCTAssertEqual(account2.orders[2].side, OrderSide.buy)
          XCTAssertEqual(account2.orders[2].type, OrderType.stop)
          XCTAssertEqual(account2.orders[2].price, 1.5)
          XCTAssertEqual(account2.orders[2].volume, 10.0)
      }

}
