//
//  BenchmarkSerializationJson.swift
//

import XCTest
import ChronoxorProto

class BenchmarkSerializationJson: XCTestCase {
    private static var _account: ChronoxorProto.Account!
    private static var _json: String!

    override class func setUp() {
        super.setUp()

        _account = ChronoxorProto.Account(id: 1, name: "Test", state: ChronoxorProto.State.good, wallet: ChronoxorProto.Balance(currency: "USD", amount: 1000.0), asset: ChronoxorProto.Balance(currency: "EUR", amount: 100.0), orders: [])
        _account.orders.append(ChronoxorProto.Order(id: 1, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.market, price: 1.23456, volume: 1000.0))
        _account.orders.append(ChronoxorProto.Order(id: 2, symbol: "EURUSD", side: ChronoxorProto.OrderSide.sell, type: ChronoxorProto.OrderType.limit, price: 1.0, volume: 100.0))
        _account.orders.append(ChronoxorProto.Order(id: 3, symbol: "EURUSD", side: ChronoxorProto.OrderSide.buy, type: ChronoxorProto.OrderType.stop, price: 1.5, volume: 10.0))

        // Serialize the account to the JSON string
        _json = try! BenchmarkSerializationJson._account.toJson()

        // Deserialize the account from the JSON string
        BenchmarkSerializationJson._account = try! Account.fromJson(BenchmarkSerializationJson._json)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceSerializeJSONEncoder() {
        self.measure {
            for _ in 0...999 {
                // Serialize the account to the JSON string
                _ = try! BenchmarkSerializationJson._account.toJson()
            }
        }
    }

    func testPerformanceDeserializeJSONDecoder() {
        self.measure {
            for _ in 0...999 {
                // Deserialize the account from the JSON string
                _ = try! Account.fromJson(BenchmarkSerializationJson._json)
            }
        }
    }
}
