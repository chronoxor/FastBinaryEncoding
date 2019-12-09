//
//  BenchmarkSerializationFinal.swift
//

import XCTest
import ChronoxorProto

class BenchmarkSerializationFinal: XCTestCase {
    private static var _account: ChronoxorProto.Account!
    private static var _writer: ChronoxorProto.AccountFinalModel!
    private static var _reader: ChronoxorProto.AccountFinalModel!

    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
        return [.wallClockTime,
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TotalHeapAllocationsKilobytes"),
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_PersistentVMAllocations"),
        ]
    }

    override class func setUp() {
        super.setUp()

        _account = ChronoxorProto.Account(id: 1, name: "Test", state: ChronoxorProto.State.good, wallet: ChronoxorProto.Balance(currency: "USD", amount: 1000.0), asset: ChronoxorProto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(ChronoxorProto.Order(id: 1, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(ChronoxorProto.Order(id: 2, symbol: "EURUSD", side: ChronoxorProto.OrderSide.sell, type: ChronoxorProto.OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(ChronoxorProto.Order(id: 3, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.stop, price: 1.5, volume: 10.0))

        _writer = ChronoxorProto.AccountFinalModel()
        _reader = ChronoxorProto.AccountFinalModel()

        // Serialize the account to the FBE stream
        _ = try! _writer.serialize(value: _account)
        assert(_writer.verify())

        // Deserialize the account from the FBE stream
        _reader.attach(buffer: _writer.buffer)
        assert(_reader.verify())
        _ = _reader.deserialize(value: &_account)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceVerify() {
        self.measure {
            // Verify the account
            for _ in 0...1000 {
                _ = BenchmarkSerializationFinal._writer.verify()
            }
        }
    }

    func testPerformanceSerialize() {
        self.measure {
            // Reset FBE stream
            for _ in 0...1000 {
                BenchmarkSerializationFinal._writer.reset()
                // Serialize the account to the FBE stream
                _ = try! BenchmarkSerializationFinal._writer.serialize(value: BenchmarkSerializationFinal._account)
            }
        }
    }

    func testPerformanceDeserialize() {
        self.measure {
            // Deserialize the account from the FBE stream
            for _ in 0...1000 {
                _ = BenchmarkSerializationFinal._reader.deserialize(value: &BenchmarkSerializationFinal._account)
            }
        }
    }
}
