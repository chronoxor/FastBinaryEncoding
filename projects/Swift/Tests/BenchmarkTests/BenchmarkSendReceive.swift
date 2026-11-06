//
//  BenchmarkSendReceive.swift
//

import XCTest
import ChronoxorProto
import ChronoxorFbe

fileprivate class MySender: ChronoxorProto.Sender, ChronoxorFbe.SenderListener {
    var size: Int = 0
    var logSize: Int = 0

    var logging: Bool = false

    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
        self.size += size
        return 0
    }

    func onSendLog(message: String) {
        logSize += message.count
    }
}

fileprivate class MyReceiver: ChronoxorProto.Receiver, ChronoxorProto.ReceiverListener {
    var logSize: Int = 0
    var logging: Bool = false

    func onSendLog(message: String) {
        logSize += message.count
    }
}

class BenchmarkSendReceive: XCTestCase {
    private static var _account: AccountMessage!
    private static var _sender1: MySender!
    private static var _sender2: MySender!
    private static var _receiver: MyReceiver!

    override class func setUp() {
        super.setUp()

        _account = AccountMessage(body: Account(id: 1, name: "Test", state: .bad, wallet: ChronoxorProto.Balance(currency: "USD", amount: 1000.0), asset: ChronoxorProto.Balance(currency: "EUR", amount: 100.0), orders: []))
        _account.body.orders.append(ChronoxorProto.Order(id: 1, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        _account.body.orders.append(ChronoxorProto.Order(id: 2, symbol: "EURUSD", side: ChronoxorProto.OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        _account.body.orders.append(ChronoxorProto.Order(id: 3, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        _sender1 = MySender()
        _ = try? _sender1.send(value: _account)

        _sender2 = MySender()
        _ = try? _sender2.send(value: _account)

        _receiver = MyReceiver()
        try? _receiver.receive(buffer: _sender2.buffer)
    }

    func testPerformanceSend() {
        self.measure {
            for _ in 0...999 {
                // Verify the account
                _ = try? BenchmarkSendReceive._sender1.send(value: BenchmarkSendReceive._account)
            }
        }
    }

    func testPerformanceSendWithLogs() {
        // Enable logging
        BenchmarkSendReceive._sender1.logging = true

        self.measure {
            // Serialize and send the account
            _ = try? BenchmarkSendReceive._sender1.send(value: BenchmarkSendReceive._account)
        }
    }

    func testPerformanceReceive() {
        try? BenchmarkSendReceive._receiver.receive(buffer: BenchmarkSendReceive._sender2.buffer)
    }

    func testPerformanceReceiveWithLogs() {
        // Enable logging
        BenchmarkSendReceive._receiver.logging = true

        self.measure {
            // Serialize and send the account
            try? BenchmarkSendReceive._receiver.receive(buffer: BenchmarkSendReceive._sender2.buffer)
        }
    }
}
