//
//  BenchmarkSerialization.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/12/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
import proto

class BenchmarkSerialization: XCTestCase {
    
    private var _account: proto.Account!
    private var _writer: proto.AccountModel!
    private var _reader: proto.AccountModel!
    
    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
        return [.wallClockTime,
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TotalHeapAllocationsKilobytes"),
                XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_PersistentVMAllocations"),
        ]
    }
    
    override func setUp() {
        _account = proto.Account(id: 1, name: "Test", state: proto.State.good, wallet: proto.Balance(currency: "USD", amount: 1000.0), asset: proto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(proto.Order(id: 1, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(proto.Order(id: 2, symbol: "EURUSD", side: proto.OrderSide.sell, type: proto.OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(proto.Order(id: 3, symbol: "EURUSD", side: proto.OrderSide.buy, type: proto.OrderType.stop, price: 1.5, volume: 10.0))
        
        _writer = proto.AccountModel()
        _reader = proto.AccountModel()
        
        print(try? _account.toJson())
        
        // Serialize the account to the FBE stream
        try! _writer.serialize(value: _account)
        assert(_writer.verify())
        
        // Deserialize the account from the FBE stream
        _reader.attach(buffer: _writer.buffer)
        assert(_reader.verify())
        _reader.deserialize(value: &_account)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceVerify() {
        self.measure {
            // Verify the account
            _writer.verify()
        }
    }

    func testPerformanceSerialize() {
        self.measure {
            // Reset FBE stream
            _writer.reset()
            let a = "t"
            print(a)
            // Serialize the account to the FBE stream
            try! _writer.serialize(value: _account)
        }
    }
    
    func testPerformanceDeserialize() {
        self.measure {
            // Deserialize the account from the FBE stream
            //for _ in 0...100 {
                _reader.deserialize(value: &_account)
            //}
        }
    }
}
