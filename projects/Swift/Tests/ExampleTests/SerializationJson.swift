//
//  SerializationJson.swift
//

import XCTest
import ChronoxorProto

class ExampleSerializationJson: XCTestCase {
    func testSerializationJson() {
        // Create a new account with some orders
        var account = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        // Serialize the account to the JSON string
        let json = try! account.toJson()

        // Show the serialized JSON and its size
        print("JSON: \(json)")
        print("JSON size: \(json.count)")

        // Deserialize the account from the JSON string
        account = try! Account.fromJson(json)

        // Show account content
        print("")
        print(account.description)
    }
}
