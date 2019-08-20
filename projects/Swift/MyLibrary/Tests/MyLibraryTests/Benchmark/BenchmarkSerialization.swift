//
//  BenchmarkSerialization.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/12/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
import proto
@testable import MyLibrary

final class BenchmarkSerialization: XCTestCase {
    
    private static var _account: proto.Account!
    private static var _writer: proto.AccountModel!
    private static var _reader: proto.AccountModel!
    
//    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
//        return [.wallClockTime,
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TemporaryHeapAllocationsKilobytes"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TotalHeapAllocationsKilobytes"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_PersistentHeapAllocations"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TransientHeapAllocationsKilobytes"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_PersistentHeapAllocationsNodes"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_HighWaterMarkForHeapAllocations"),
////                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TransientHeapAllocationsNodes"),
//        ]
//    }
    
    override class func setUp() {
        super.setUp()
        
        _account = proto.Account(id: 1, name: "Test", state: .bad, wallet: proto.Balance(currency: "USD", amount: 1000.0), asset: proto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(proto.Order(id: 1, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(proto.Order(id: 2, symbol: "EURUSD", side: proto.OrderSide.sell, type: proto.OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(proto.Order(id: 3, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.stop, price: 1.5, volume: 10.0))
        
        _writer = proto.AccountModel()
        _reader = proto.AccountModel()

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
        
       // if #available(iOS 13.0, *) {
            //let opy = XCTMeasureOptions()
           // opy.iterationCount = 100
            self.measure {
                for _ in 0...1000 {
                    // Reset FBE stream
                    BenchmarkSerialization._writer.reset()
                    // Serialize the account to the FBE stream
                    _ = try! BenchmarkSerialization._writer.serialize(value: BenchmarkSerialization._account)
                }
            }
       // } else {
            // Fallback on earlier versions
       // }
    }
    
    func testPerformanceDeserialize() {
        self.measure {
            // Deserialize the account from the FBE stream
            for _ in 0...1000 {
                _ = BenchmarkSerialization._reader.deserialize(value: &BenchmarkSerialization._account)
            }
        }
    }
}
