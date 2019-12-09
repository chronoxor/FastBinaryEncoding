//
//  BenchmarkSerialization.swift
//

import XCTest
import ChronoxorProto

class BenchmarkSerialization: XCTestCase {
    private static var _account: Account!
    private static var _writer: AccountModel!
    private static var _reader: AccountModel!

    override class func setUp() {
        super.setUp()

        _account = ChronoxorProto.Account(id: 1, name: "Test", state: .bad, wallet: ChronoxorProto.Balance(currency: "USD", amount: 1000.0), asset: ChronoxorProto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(ChronoxorProto.Order(id: 1, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(ChronoxorProto.Order(id: 2, symbol: "EURUSD", side: ChronoxorProto.OrderSide.sell, type: OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(ChronoxorProto.Order(id: 3, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: OrderType.stop, price: 1.5, volume: 10.0))

        _writer = ChronoxorProto.AccountModel()
        _reader = ChronoxorProto.AccountModel()

        // Serialize the account to the FBE stream
        _ = try! _writer.serialize(value: _account)
        assert(_writer.verify())

        // Deserialize the account from the FBE stream
        _reader.attach(buffer: _writer.buffer)
        assert(_reader.verify())
        _ = _reader.deserialize(value: &_account)
    }

    func testPerformanceVerify() {
        self.measure {
            for _ in 0...1000 {
                // Verify the account
                _ = BenchmarkSerialization._writer.verify()
            }
        }
    }

    func testPerformanceSerialize() {
        self.measure {
            for _ in 0...1000 {
                // Reset FBE stream
                BenchmarkSerialization._writer.reset()
                // Serialize the account to the FBE stream
                _ = try! BenchmarkSerialization._writer.serialize(value: BenchmarkSerialization._account)
            }
        }
    }

    func testPerformanceDeserialize() {
        self.measure() {
            // Deserialize the account from the FBE stream
            for _ in 0...1000 {
                _ = BenchmarkSerialization._reader.deserialize(value: &BenchmarkSerialization._account)
            }
        }
    }
}
