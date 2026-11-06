//
//  SendReceive.swift
//

import XCTest
import ChronoxorFbe
import ChronoxorProto

fileprivate class MySender: ChronoxorProto.Sender, ChronoxorFbe.SenderListener {
    var logging: Bool = true

    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
        // Send nothing...
        return 0
    }

    func onSendLog(message: String) {
        print("onSend: " + message)
    }
}

fileprivate class MyReceiver: ChronoxorProto.Receiver, ChronoxorProto.ReceiverListener {
    var logging: Bool = true

    func onReceiveLog(message: String) {
        print("onReceive: " + message)
    }
}

class ExampleSendReceive: XCTestCase {
    func testSendReceive() {
        let sender = MySender()

        // Create and send a new order
        let order = Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0)
        _ = try? sender.send(value: OrderMessage(body: order))

        // Create and send a new balance wallet
        let balance = Balance(currency: "USD", amount: 1000.0)
        _ = try? sender.send(value: BalanceMessage(body: balance))

        // Create and send a new account with some orders
        var account = Account(id: 1, name: "Test", state: State.good, wallet: Balance(currency: "USD", amount: 1000.0), asset: Balance(currency: "EUR", amount: 100.0), orders: [])
        account.orders.append(Order(id: 1, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        account.orders.append(Order(id: 2, symbol: "EURUSD", side: OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        account.orders.append(Order(id: 3, symbol: "EURUSD", side: OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))
        _ = try? sender.send(value: AccountMessage(body: account))

        let receiver = MyReceiver()

        // Receive data from the sender
        try? receiver.receive(buffer: sender.buffer)
    }
}
