//
//  TestExtending.swift
//

import XCTest
import ChronoxorProto
import ChronoxorProtoex

class TestExtending: XCTestCase {
    func testExtendingOldNew() {
        // Create a new account with some orders
        var account1 = ChronoxorProto.Account(id: 1, name: "Test", state: ChronoxorProto.State.good, wallet: ChronoxorProto.Balance(currency: "USD", amount: 1000.0), asset: ChronoxorProto.Balance(currency: "EUR", amount: 100.0), orders: [])
        account1.orders.append(ChronoxorProto.Order(id: 1, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.market, price: 1.23456, volume: 1000.0))
        account1.orders.append(ChronoxorProto.Order(id: 2, symbol: "EURUSD", side: ChronoxorProto.OrderSide.sell, type: ChronoxorProto.OrderType.limit, price: 1.0, volume: 100.0))
        account1.orders.append(ChronoxorProto.Order(id: 3, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.stop, price: 1.5, volume: 10.0))

        // Serialize the account to the FBE stream
        let writer = ChronoxorProto.AccountModel()
        XCTAssertEqual(writer.model.fbeOffset, 4)
        let serialized = try! writer.serialize(value: account1)
        XCTAssertEqual(serialized, writer.buffer.size)
        XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)
        XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        XCTAssertEqual(writer.buffer.size, 252)

        // Deserialize the account from the FBE stream
        var account2 = ChronoxorProtoex.Account()
        let reader = ChronoxorProtoex.AccountModel()
        XCTAssertEqual(reader.model.fbeOffset, 4)
        reader.attach(buffer: writer.buffer)
        XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &account2)
        XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)
        XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)

        XCTAssertEqual(account2.id, 1)
        XCTAssertEqual(account2.name, "Test")
        XCTAssertEqual(account2.state, ChronoxorProtoex.StateEx.good)
        XCTAssertEqual(account2.wallet.currency, "USD")
        XCTAssertEqual(account2.wallet.amount, 1000.0)
        XCTAssertEqual(account2.wallet.locked, 0.0)
        XCTAssertNotEqual(account2.asset, nil)
        XCTAssertEqual(account2.asset!.currency, "EUR")
        XCTAssertEqual(account2.asset!.amount, 100.0)
        XCTAssertEqual(account2.asset!.locked, 0.0)
        XCTAssertEqual(account2.orders.count, 3)
        XCTAssertEqual(account2.orders[0].id, 1)
        XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[0].side, ChronoxorProtoex.OrderSide.buy)
        XCTAssertEqual(account2.orders[0].type, ChronoxorProtoex.OrderType.market)
        XCTAssertEqual(account2.orders[0].price, 1.23456)
        XCTAssertEqual(account2.orders[0].volume, 1000.0)
        XCTAssertEqual(account2.orders[0].tp, 10.0)
        XCTAssertEqual(account2.orders[0].sl, -10.0)
        XCTAssertEqual(account2.orders[1].id, 2)
        XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[1].side, ChronoxorProtoex.OrderSide.sell)
        XCTAssertEqual(account2.orders[1].type, ChronoxorProtoex.OrderType.limit)
        XCTAssertEqual(account2.orders[1].price, 1.0)
        XCTAssertEqual(account2.orders[1].volume, 100.0)
        XCTAssertEqual(account2.orders[1].tp, 10.0)
        XCTAssertEqual(account2.orders[1].sl, -10.0)
        XCTAssertEqual(account2.orders[2].id, 3)
        XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[2].side, ChronoxorProtoex.OrderSide.buy)
        XCTAssertEqual(account2.orders[2].type, ChronoxorProtoex.OrderType.stop)
        XCTAssertEqual(account2.orders[2].price, 1.5)
        XCTAssertEqual(account2.orders[2].volume, 10.0)
        XCTAssertEqual(account2.orders[2].tp, 10.0)
        XCTAssertEqual(account2.orders[2].sl, -10.0)
    }

    func testExtendingNewOld() {
        // Create a new account with some orders
        var account1 = ChronoxorProtoex.Account()
        account1.id = 1
        account1.name = "Test"
        account1.state = ChronoxorProtoex.StateEx.fromSet(set: [ChronoxorProtoex.StateEx.good.value!, ChronoxorProtoex.StateEx.happy.value!])
        account1.wallet.currency = "USD"
        account1.wallet.amount = 1000.0
        account1.wallet.locked = 123.456
        account1.asset = ChronoxorProtoex.Balance()
        account1.asset!.currency = "EUR"
        account1.asset!.amount = 100.0
        account1.asset!.locked = 12.34
        account1.orders.append(ChronoxorProtoex.Order(id: 1, symbol: "EURUSD", side: ChronoxorProtoex.OrderSide.buy, type: ChronoxorProtoex.OrderType.market, price: 1.23456, volume: 1000.0, tp: 0.0, sl: 0.0))
        account1.orders.append(ChronoxorProtoex.Order(id: 2, symbol: "EURUSD", side: ChronoxorProtoex.OrderSide.sell, type: ChronoxorProtoex.OrderType.limit, price: 1.0, volume: 100.0, tp: 0.1, sl: -0.1))
        account1.orders.append(ChronoxorProtoex.Order(id: 3, symbol: "EURUSD", side: ChronoxorProtoex.OrderSide.tell, type: ChronoxorProtoex.OrderType.stoplimit, price: 1.5, volume: 10.0, tp: 1.1, sl: -1.1))

        // Serialize the account to the FBE stream
        let writer = ChronoxorProtoex.AccountModel()
        XCTAssertEqual(writer.model.fbeOffset, 4)
        let serialized = try! writer.serialize(value: account1)
        XCTAssertEqual(serialized, writer.buffer.size)
        XCTAssertTrue(writer.verify())
        writer.next(prev: serialized)
        XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        XCTAssertEqual(writer.buffer.size, 316)

        // Deserialize the account from the FBE stream
        var account2 = ChronoxorProto.Account()
        let reader = ChronoxorProto.AccountModel()
        XCTAssertEqual(reader.model.fbeOffset, 4)
        reader.attach(buffer: writer.buffer)
        XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &account2)
        XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)
        XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)

        XCTAssertEqual(account2.id, 1)
        XCTAssertEqual(account2.name, "Test")
        XCTAssertTrue(account2.state.hasFlags(flags: ChronoxorProto.State.good))
        XCTAssertEqual(account2.wallet.currency, "USD")
        XCTAssertEqual(account2.wallet.amount, 1000.0)
        XCTAssertNotEqual(account2.asset, nil)
        XCTAssertEqual(account2.asset!.currency, "EUR")
        XCTAssertEqual(account2.asset!.amount, 100.0)
        XCTAssertEqual(account2.orders.count, 3)
        XCTAssertEqual(account2.orders[0].id, 1)
        XCTAssertEqual(account2.orders[0].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[0].side, ChronoxorProto.OrderSide.buy)
        XCTAssertEqual(account2.orders[0].type, ChronoxorProto.OrderType.market)
        XCTAssertEqual(account2.orders[0].price, 1.23456)
        XCTAssertEqual(account2.orders[0].volume, 1000.0)
        XCTAssertEqual(account2.orders[1].id, 2)
        XCTAssertEqual(account2.orders[1].symbol, "EURUSD")
        XCTAssertEqual(account2.orders[1].side, ChronoxorProto.OrderSide.sell)
        XCTAssertEqual(account2.orders[1].type, ChronoxorProto.OrderType.limit)
        XCTAssertEqual(account2.orders[1].price, 1.0)
        XCTAssertEqual(account2.orders[1].volume, 100.0)
        XCTAssertEqual(account2.orders[2].id, 3)
        XCTAssertEqual(account2.orders[2].symbol, "EURUSD")
        XCTAssertNotEqual(account2.orders[2].side, ChronoxorProto.OrderSide.buy)
        XCTAssertNotEqual(account2.orders[2].type, ChronoxorProto.OrderType.market)
        XCTAssertEqual(account2.orders[2].price, 1.5)
        XCTAssertEqual(account2.orders[2].volume, 10.0)
    }
}
