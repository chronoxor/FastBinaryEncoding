//
//  SerializationFinal.swift
//

import XCTest
import ChronoxorProto

class ExampleSerializationFinal: XCTestCase {
    func testSerializationFinal() {
        // Create a new account with some orders
        var account = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        // Serialize the account to the FBE stream
        let writer = AccountFinalModel()
        _ = try! writer.serialize(value: account)
        assert(writer.verify())

        // Show the serialized FBE size
        print("FBE size: \(writer.buffer.size)")

        // Deserialize the account from the FBE stream
        let reader = AccountFinalModel()
        reader.attach(buffer: writer.buffer)
        assert(reader.verify())
        _ = reader.deserialize(value: &account)

        // Show account content
        print("")
        print(account.description)
    }
}
