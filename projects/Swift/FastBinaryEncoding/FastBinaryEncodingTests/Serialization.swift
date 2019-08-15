
//  Serialization.swift
//  FastBinaryEncodingTests
//
//  Created by Andrew Zbranevich on 8/8/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import FastBinaryEncoding
import proto
import test

class Serialization: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSerializationDomain() {
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
    
    func testSerializationStructSimple() {
        // Create a new struct
        let struct1 = StructSimple()

        // Serialize the struct to the FBE stream
        let writer = StructSimpleModel()
         //XCTAssertEqual(writer.model.fbeType, 110)
         XCTAssertEqual(writer.model.fbeOffset, 4)
        let serialized = try! writer.serialize(value: struct1)
         XCTAssertEqual(serialized, writer.buffer.size)
         XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)
         XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
         XCTAssertEqual(writer.buffer.size, 392)

        // Deserialize the struct from the FBE stream
        var struct2 = StructSimple()
        let reader = StructSimpleModel()
         //XCTAssertEqual(reader.model.fbeType, 110)
         XCTAssertEqual(reader.model.fbeOffset, 4)
        reader.attach(buffer: writer.buffer)
         XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &struct2)
         XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)
         XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)

         XCTAssertEqual(struct2.f1, false)
         XCTAssertEqual(struct2.f2, true)
         XCTAssertEqual(struct2.f3, 0)
         XCTAssertEqual(struct2.f4, 0xFF)
         XCTAssertEqual(struct2.f5, "0")
         XCTAssertEqual(struct2.f6, "!")
         XCTAssertEqual(struct2.f7, "0")
         XCTAssertEqual(struct2.f8, Character(UnicodeScalar(0x0444)!))
         XCTAssertEqual(struct2.f9, 0)
         XCTAssertEqual(struct2.f10, 127)
         XCTAssertEqual(struct2.f11, 0)
         XCTAssertEqual(struct2.f12, 0xFF)
         XCTAssertEqual(struct2.f13, 0)
         XCTAssertEqual(struct2.f14, 32767)
         XCTAssertEqual(struct2.f15, 0)
         XCTAssertEqual(struct2.f16, 0xFFFF)
         XCTAssertEqual(struct2.f17, 0)
         XCTAssertEqual(struct2.f18, 2147483647)
         XCTAssertEqual(struct2.f19, 0)
         XCTAssertEqual(struct2.f20, 0xFFFFFFFF)
         XCTAssertEqual(struct2.f21, 0)
         XCTAssertEqual(struct2.f22, 9223372036854775807)
         XCTAssertEqual(struct2.f23, 0)
         XCTAssertEqual(struct2.f24, 0xFFFFFFFFFFFFFFFF)
         XCTAssertEqual(struct2.f25, 0.0)
         XCTAssertTrue(abs(struct2.f26 - 123.456) < 0.0001)
         XCTAssertEqual(struct2.f27, 0.0)
         XCTAssertTrue(abs(struct2.f28 - -123.567e+123) < 1e+123)
         XCTAssertEqual(struct2.f29, Decimal.zero)
         XCTAssertEqual(struct2.f30, Decimal(123456.123456))
         XCTAssertEqual(struct2.f31, "")
         XCTAssertEqual(struct2.f32, "Initial string!")
         XCTAssertTrue(struct2.f33 == 0)
         XCTAssertTrue(struct2.f34 == 0)
         XCTAssertTrue(struct2.f35 > 0)// GregorianCalendar(2018, 1, 1).toInstant().epochSecond)
         XCTAssertTrue(struct2.f36 == UUID(uuidString: "00000000-0000-0000-0000-000000000000"))
         XCTAssertTrue(struct2.f37 != UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000"))
         XCTAssertTrue(struct2.f38 == UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000"))

         XCTAssertEqual(struct2.f1, struct1.f1)
         XCTAssertEqual(struct2.f2, struct1.f2)
         XCTAssertEqual(struct2.f3, struct1.f3)
         XCTAssertEqual(struct2.f4, struct1.f4)
         XCTAssertEqual(struct2.f5, struct1.f5)
         XCTAssertEqual(struct2.f6, struct1.f6)
         XCTAssertEqual(struct2.f7, struct1.f7)
         XCTAssertEqual(struct2.f8, struct1.f8)
         XCTAssertEqual(struct2.f9, struct1.f9)
         XCTAssertEqual(struct2.f10, struct1.f10)
         XCTAssertEqual(struct2.f11, struct1.f11)
         XCTAssertEqual(struct2.f12, struct1.f12)
         XCTAssertEqual(struct2.f13, struct1.f13)
         XCTAssertEqual(struct2.f14, struct1.f14)
         XCTAssertEqual(struct2.f15, struct1.f15)
         XCTAssertEqual(struct2.f16, struct1.f16)
         XCTAssertEqual(struct2.f17, struct1.f17)
         XCTAssertEqual(struct2.f18, struct1.f18)
         XCTAssertEqual(struct2.f19, struct1.f19)
         XCTAssertEqual(struct2.f20, struct1.f20)
         XCTAssertEqual(struct2.f21, struct1.f21)
         XCTAssertEqual(struct2.f22, struct1.f22)
         XCTAssertEqual(struct2.f23, struct1.f23)
         XCTAssertEqual(struct2.f24, struct1.f24)
         XCTAssertEqual(struct2.f25, struct1.f25)
         XCTAssertEqual(struct2.f26, struct1.f26)
         XCTAssertEqual(struct2.f27, struct1.f27)
         XCTAssertEqual(struct2.f28, struct1.f28)
         XCTAssertEqual(struct2.f29, struct1.f29)
         XCTAssertEqual(struct2.f30, struct1.f30)
         XCTAssertEqual(struct2.f31, struct1.f31)
         XCTAssertEqual(struct2.f32, struct1.f32)
         XCTAssertEqual(struct2.f33, struct1.f33)
         XCTAssertEqual(struct2.f34, struct1.f34)
         XCTAssertEqual(struct2.f35, struct1.f35)
         XCTAssertEqual(struct2.f36, struct1.f36)
         XCTAssertEqual(struct2.f37, struct1.f37)
         XCTAssertEqual(struct2.f38, struct1.f38)
         XCTAssertEqual(struct2.f39, struct1.f39)
         XCTAssertEqual(struct2.f40, struct1.f40)
    }
    

    func testFinalSerializationDomain()
      {
          // Create a new account with some orders
          let account1 = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account1.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account1.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account1.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

          // Serialize the account to the FBE stream
        let writer = AccountFinalModel()
        let serialized = try! writer.serialize(value: account1)
          XCTAssertEqual(serialized, writer.buffer.size)
          XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)

          // Check the serialized FBE size
          XCTAssertEqual(writer.buffer.size, 152)

          // Deserialize the account from the FBE stream
        var account2 = Account()
        let reader = AccountFinalModel()
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


    func testSerializationJsonDomain() {
        // Define a source JSON string
        var json = "{\"id\":1,\"name\":\"Test\",\"state\":6,\"wallet\":{\"currency\":\"USD\",\"amount\":1000.0},\"asset\":{\"currency\":\"EUR\",\"amount\":100.0},\"orders\":[{\"id\":1,\"symbol\":\"EURUSD\",\"side\":0,\"type\":0,\"price\":1.23456,\"volume\":1000.0},{\"id\":2,\"symbol\":\"EURUSD\",\"side\":1,\"type\":1,\"price\":1.0,\"volume\":100.0},{\"id\":3,\"symbol\":\"EURUSD\",\"side\":0,\"type\":2,\"price\":1.5,\"volume\":10.0}]}"

        // Create a new account from the source JSON string
        let account1 = Account.fromJson(json)

        // Serialize the account to the JSON string
        json = try! account1.toJson()

        // Check the serialized JSON size
        XCTAssertTrue(!json.isEmpty)

        // Deserialize the account from the JSON string
        let account2 = Account.fromJson(json)

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
