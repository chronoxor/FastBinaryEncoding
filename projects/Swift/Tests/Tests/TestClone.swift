//
//  TestClone.swift
//

import XCTest
import ChronoxorProto

class TestClone: XCTestCase {
    func testCloneStructs() {
        // Create a new account with some orders
        var account1 = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account1.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account1.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account1.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        // Clone the account
        var account2: Account!
        do {
            account2 = try account1.clone()
        } catch {
            XCTFail()
        }

        // Clear the source account
        account1 = Account()

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
