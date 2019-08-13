//
//  ExTest.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/12/19.
//  Copyright © 2019 Andrey. All rights reserved.
//
//
//import XCTest
//@testable import FastBinaryEncoding
//import protoex
//import proto
//
//class ExTest: XCTestCase {
//
//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExtendingOldNew() {
//       // Create a new account with some orders
//        let account1 = proto.Account(id: 1, name: "Test", state: proto.State.good, wallet: proto.Balance(currency: "USD", amount: 1000.0), asset: proto.Balance(currency: "EUR", amount: 100.0), orders: [])
//         account1.orders.append(proto.Order(id: 1, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.market, price: 1.23456, volume: 1000.0))
//         account1.orders.append(proto.Order(id: 2, symbol: "EURUSD", side: proto.OrderSide.sell, type: proto.OrderType.limit, price: 1.0, volume: 100.0))
//         account1.orders.append(proto.Order(id: 3, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.stop, price: 1.5, volume: 10.0))
//
//         // Serialize the account to the FBE stream
//         let writer = proto.AccountModel()
//         //XCTAssertEqual(writer.model.fbeOffset, 4)
//        let serialized = try! writer.serialize(value: account1)
//         XCTAssertEqual(serialized, writer.buffer.size)
//         XCTAssertTrue(writer.verify())
//         writer.next(prev: serialized)
//        // XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)
//
//         // Check the serialized FBE size
//         XCTAssertEqual(writer.buffer.size, 252)
//
//         // Deserialize the account from the FBE stream
//         var account2 = protoex.Account()
//         let reader = protoex.AccountModel()
//         //XCTAssertEqual(reader.model.fbeOffset, 4)
//         reader.attach(buffer: writer.buffer)
//         XCTAssertTrue(reader.verify())
//        let deserialized = reader.deserialize(value: &account2)
//         XCTAssertEqual(deserialized, reader.buffer.size)
//         reader.next(prev: deserialized)
//         //XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)
//
//         XCTAssertEqual(account2.id, 1)
//         XCTAssertEqual(account2.name, "Test")
//         XCTAssertEqual(account2.state, protoex.StateEx.good)
//         XCTAssertEqual(account2.wallet.currency, "USD")
//         XCTAssertEqual(account2.wallet.amount, 1000.0)
//         XCTAssertEqual(account2.wallet.locked, 0.0)
//         XCTAssertNotEqual(account2.asset, nil)
//         XCTAssertEqual(account2.asset!.currency, "EUR")
//         XCTAssertEqual(account2.asset!.amount, 100.0)
//         XCTAssertEqual(account2.asset!.locked, 0.0)
//         XCTAssertEqual(account2.orders.count, 3)
//         XCTAssertEqual(account2.orders[0].id, 1)
//         XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
//         XCTAssertEqual(account2.orders[0].side, protoex.OrderSide.buy)
//         XCTAssertEqual(account2.orders[0].type, protoex.OrderType.market)
//         XCTAssertEqual(account2.orders[0].price, 1.23456)
//         XCTAssertEqual(account2.orders[0].volume, 1000.0)
//         XCTAssertEqual(account2.orders[0].tp, 10.0)
//         XCTAssertEqual(account2.orders[0].sl, -10.0)
//         XCTAssertEqual(account2.orders[1].id, 2)
//         XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
//         XCTAssertEqual(account2.orders[1].side, protoex.OrderSide.sell)
//         XCTAssertEqual(account2.orders[1].type, protoex.OrderType.limit)
//         XCTAssertEqual(account2.orders[1].price, 1.0)
//         XCTAssertEqual(account2.orders[1].volume, 100.0)
//         XCTAssertEqual(account2.orders[1].tp, 10.0)
//         XCTAssertEqual(account2.orders[1].sl, -10.0)
//         XCTAssertEqual(account2.orders[2].id, 3)
//         XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
//         XCTAssertEqual(account2.orders[2].side, protoex.OrderSide.buy)
//         XCTAssertEqual(account2.orders[2].type, protoex.OrderType.stop)
//         XCTAssertEqual(account2.orders[2].price, 1.5)
//         XCTAssertEqual(account2.orders[2].volume, 10.0)
//         XCTAssertEqual(account2.orders[2].tp, 10.0)
//         XCTAssertEqual(account2.orders[2].sl, -10.0)
//    }
//    
//    func testExtendingNewOld() {
//        // Create a new account with some orders
//        let account1 = protoex.Account()
//        account1.id = 1
//        account1.name = "Test"
//        account1.state = protoex.StateEx.fromSet(set: [protoex.StateEx.good.value!, protoex.StateEx.happy.value!])
//        account1.wallet.currency = "USD"
//        account1.wallet.amount = 1000.0
//        account1.wallet.locked = 123.456
//        account1.asset = protoex.Balance()
//        account1.asset!.currency = "EUR"
//        account1.asset!.amount = 100.0
//        account1.asset!.locked = 12.34
//        account1.orders.append(protoex.Order(id: 1, symbol: "EURUSD", side: protoex.OrderSide.buy, type: protoex.OrderType.market, price: 1.23456, volume: 1000.0, tp: 0.0, sl: 0.0))
//        account1.orders.append(protoex.Order(id: 2, symbol: "EURUSD", side: protoex.OrderSide.sell, type: protoex.OrderType.limit, price: 1.0, volume: 100.0, tp: 0.1, sl: -0.1))
//        account1.orders.append(protoex.Order(id: 3, symbol: "EURUSD", side: protoex.OrderSide.tell, type: protoex.OrderType.stoplimit, price: 1.5, volume: 10.0, tp: 1.1, sl: -1.1))
//
//        // Serialize the account to the FBE stream
//        let writer = protoex.AccountModel()
//        //XCTAssertEqual(writer.model.fbeOffset, 4)
//        let serialized = try! writer.serialize(value: account1)
//        XCTAssertEqual(serialized, writer.buffer.size)
//        XCTAssertTrue(writer.verify())
//        writer.next(prev: serialized)
//        //XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)
//
//        // Check the serialized FBE size
//        XCTAssertEqual(writer.buffer.size, 316)
//
//        // Deserialize the account from the FBE stream
//        var account2 = proto.Account()
//        let reader = proto.AccountModel()
//        //XCTAssertEqual(reader.model.fbeOffset, 4)
//        reader.attach(buffer: writer.buffer)
//        XCTAssertTrue(reader.verify())
//        let deserialized = reader.deserialize(value: &account2)
//        XCTAssertEqual(deserialized, reader.buffer.size)
//        reader.next(prev: deserialized)
//        //XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)
//
//        XCTAssertEqual(account2.id, 1)
//        XCTAssertEqual(account2.name, "Test")
//        XCTAssertTrue(account2.state.hasFlags(flags: proto.State.good))
//        XCTAssertEqual(account2.wallet.currency, "USD")
//        XCTAssertEqual(account2.wallet.amount, 1000.0)
//        XCTAssertNotEqual(account2.asset, nil)
//        XCTAssertEqual(account2.asset!.currency, "EUR")
//        XCTAssertEqual(account2.asset!.amount, 100.0)
//        XCTAssertEqual(account2.orders.count, 3)
//        XCTAssertEqual(account2.orders[0].id, 1)
//        XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
//        XCTAssertEqual(account2.orders[0].side, proto.OrderSide.buy)
//        XCTAssertEqual(account2.orders[0].type, proto.OrderType.market)
//        XCTAssertEqual(account2.orders[0].price, 1.23456)
//        XCTAssertEqual(account2.orders[0].volume, 1000.0)
//        XCTAssertEqual(account2.orders[1].id, 2)
//        XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
//        XCTAssertEqual(account2.orders[1].side, proto.OrderSide.sell)
//        XCTAssertEqual(account2.orders[1].type, proto.OrderType.limit)
//        XCTAssertEqual(account2.orders[1].price, 1.0)
//        XCTAssertEqual(account2.orders[1].volume, 100.0)
//        XCTAssertEqual(account2.orders[2].id, 3)
//        XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
//        XCTAssertNotEqual(account2.orders[2].side, proto.OrderSide.buy)
//        XCTAssertNotEqual(account2.orders[2].type, proto.OrderType.market)
//        XCTAssertEqual(account2.orders[2].price, 1.5)
//        XCTAssertEqual(account2.orders[2].volume, 10.0)
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
