//
//  BenchmarkSerializationFinal.swift
//

import XCTest
import proto

class BenchmarkSerializationFinal: XCTestCase {
    
    private static var _account: proto.Account!
    private static var _writer: proto.AccountFinalModel!
    private static var _reader: proto.AccountFinalModel!
    
    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
        return [.wallClockTime,
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TotalHeapAllocationsKilobytes"),
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_PersistentVMAllocations"),
        ]
    }
    
    override class func setUp() {
        super.setUp()
        
        _account = proto.Account(id: 1, name: "Test", state: proto.State.good, wallet: proto.Balance(currency: "USD", amount: 1000.0), asset: proto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(proto.Order(id: 1, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(proto.Order(id: 2, symbol: "EURUSD", side: proto.OrderSide.sell, type: proto.OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(proto.Order(id: 3, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.stop, price: 1.5, volume: 10.0))
        
        _writer = proto.AccountFinalModel()
        _reader = proto.AccountFinalModel()
        
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
            _ = BenchmarkSerializationFinal._writer.verify()
        }
    }
    
    func testPerformanceSerialize() {
        self.measure {
            // Reset FBE stream
            for _ in 0...999 {
                BenchmarkSerializationFinal._writer.reset()
                // Serialize the account to the FBE stream
                _ = try! BenchmarkSerializationFinal._writer.serialize(value: BenchmarkSerializationFinal._account)
            }
        }
    }
    
    func testPerformanceDeserialize() {
        self.measure {
            // Deserialize the account from the FBE stream
            for _ in 0...999 {
                _ = BenchmarkSerializationFinal._reader.deserialize(value: &BenchmarkSerializationFinal._account)
            }
        }
    }
}
