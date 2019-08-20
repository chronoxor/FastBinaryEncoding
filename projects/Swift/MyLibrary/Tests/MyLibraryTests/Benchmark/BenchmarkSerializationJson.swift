//
//  BenchmarkSerializationJson.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/16/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
import proto
import Marshal

class BenchmarkSerializationJson: XCTestCase {
    
    private static var _account: proto.Account!
    private static var _json: String!
    
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
        
        // Serialize the account to the JSON string
        _json = try! BenchmarkSerializationJson._account.toJson()

        // Deserialize the account from the JSON string
        BenchmarkSerializationJson._account = Account.fromJson(BenchmarkSerializationJson._json)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceSerializeJSONEncoder() {
        self.measure {
            for _ in 0...1000 {
                // Serialize the account to the JSON string
                _ = try! JSONEncoder().encode(BenchmarkSerializationJson._account)
                //BenchmarkSerializationJson._json = try! BenchmarkSerializationJson._account.toJson()
            }
        }
    }
    
    func testPerformanceSerializeMarshal() {
        self.measure {
            for _ in 0...1000 {
                // Serialize the account to the JSON string
                let dict = BenchmarkSerializationJson._account.marshaled()
                if let theJSONData = try?  JSONSerialization.data(
                    withJSONObject: dict,
                    options: .prettyPrinted
                    ),
                    let _ = String(data: theJSONData,
                                   encoding: String.Encoding.ascii) {
                }
                //BenchmarkSerializationJson._json = try! BenchmarkSerializationJson._account.toJson()
            }
        }
    }
    
    func testPerformanceDeserializeJSONDecoder() {
        let data = BenchmarkSerializationJson._json.data(using: .utf8)!
        self.measure {
            for _ in 0...1000 {
                // Deserialize the account from the JSON string
                let _ = try! JSONDecoder().decode(Account.self, from: data)
            }
        }
    }
    
    func testPerformanceDeserializeMarshal() {
        let data = BenchmarkSerializationJson._json.data(using: .utf8)!
        let json = (try! JSONSerialization.jsonObject(with: data, options: [])) as! Dictionary<String, Any>

        self.measure {
            for _ in 0...1000 {
                // Deserialize the account from the JSON string
                let tmp = try! Account(object: json)
                print(tmp)
                
                //BenchmarkSerializationJson._account = Account.fromJson(BenchmarkSerializationJson._json)
            }
        }
    }
}
