//
//  TestCreate.swift
//

import XCTest
@testable import ChronoxorProto

class TestCreate: XCTestCase {
    func testCreateAndAccess() {
        do {
            // Create a new account using FBE model into the FBE stream
            let writer = AccountModel()
            XCTAssertEqual(writer.model.fbeOffset, 4)
            let modelBegin = try writer.createBegin()
            var accountBegin = try writer.model.setBegin()
            try! writer.model.id.set(value: 1)
            try writer.model.name.set(value: "Test")
            try! writer.model.state.set(value: State.good)
            var walletBegin = try writer.model.wallet.setBegin()
            try writer.model.wallet.currency.set(value: "USD")
            try! writer.model.wallet.amount.set(value: 1000.0)
            writer.model.wallet.setEnd(fbeBegin: walletBegin)
            var assetBegin = try writer.model.asset.setBegin(hasValue: true)
            var assetWalletBegin = try writer.model.asset.value.setBegin()
            try writer.model.asset.value.currency.set(value: "EUR")
            try! writer.model.asset.value.amount.set(value: 100.0)
            writer.model.asset.setEnd(fbeBegin: assetBegin)
            writer.model.asset.value.setEnd(fbeBegin: assetWalletBegin)
            let order = try writer.model.orders.resize(size: 3)
            var orderBegin = try order.setBegin()
            try! order.id.set(value: 1)
            try order.symbol.set(value: "EURUSD")
            try order.side.set(value: OrderSide.buy)
            try order.type.set(value: OrderType.market)
            try! order.price.set(value: 1.23456)
            try! order.volume.set(value: 1000.0)
            order.setEnd(fbeBegin: orderBegin)
            order.fbeShift(size: order.fbeSize)
            orderBegin = try order.setBegin()
            try! order.id.set(value: 2)
            try order.symbol.set(value: "EURUSD")
            try order.side.set(value: OrderSide.sell)
            try order.type.set(value: OrderType.limit)
            try! order.price.set(value: 1.0)
            try! order.volume.set(value: 100.0)
            order.setEnd(fbeBegin: orderBegin)
            order.fbeShift(size: order.fbeSize)
            orderBegin = try order.setBegin()
            try! order.id.set(value: 3)
            try order.symbol.set(value: "EURUSD")
            try order.side.set(value: OrderSide.buy)
            try order.type.set(value: OrderType.stop)
            try! order.price.set(value: 1.5)
            try! order.volume.set(value: 10.0)
            order.setEnd(fbeBegin: orderBegin)
            order.fbeShift(size: order.fbeSize)
            writer.model.setEnd(fbeBegin: accountBegin)
            let serialized = writer.createEnd(fbeBegin: modelBegin)
            XCTAssertEqual(serialized, writer.buffer.size)
            XCTAssertTrue(writer.verify())
            writer.next(prev: serialized)
            XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

            // Check the serialized FBE size
            XCTAssertEqual(writer.buffer.size, 252)

            // Access the account model in the FBE stream
            let reader = AccountModel()
            XCTAssertEqual(reader.model.fbeOffset, 4)
            reader.attach(buffer: writer.buffer)
            XCTAssertTrue(reader.verify())

            let id: Int32
            let name: String
            let state: State
            let walletCurrency: String
            let walletAmount: Double
            let assetWalletCurrency: String
            let assetWalletAmount: Double

            accountBegin = reader.model.getBegin()
            id = reader.model.id.get()
            XCTAssertEqual(id, 1)
            name = reader.model.name.get()
            XCTAssertEqual(name, "Test")
            state = reader.model.state.get()
            XCTAssertTrue(state.hasFlags(flags: State.good))

            walletBegin = reader.model.wallet.getBegin()
            walletCurrency = reader.model.wallet.currency.get()
            XCTAssertEqual(walletCurrency, "USD")
            walletAmount = reader.model.wallet.amount.get()
            XCTAssertEqual(walletAmount, 1000.0)
            reader.model.wallet.getEnd(fbeBegin: walletBegin)

            XCTAssertTrue(reader.model.asset.hasValue())
            assetBegin = reader.model.asset.getBegin()
            assetWalletBegin = reader.model.asset.value.getBegin()
            assetWalletCurrency = reader.model.asset.value.currency.get()
            XCTAssertEqual(assetWalletCurrency, "EUR")
            assetWalletAmount = reader.model.asset.value.amount.get()
            XCTAssertEqual(assetWalletAmount, 100.0)
            reader.model.asset.value.getEnd(fbeBegin: assetWalletBegin)
            reader.model.asset.getEnd(fbeBegin: assetBegin)

            XCTAssertEqual(reader.model.orders.size, 3)

            var orderId: Int32
            var orderSymbol: String
            var orderSide: OrderSide
            var orderType: OrderType
            var orderPrice: Double
            var orderVolume: Double

            let o1 = reader.model.orders.getItem(index: 0)
            orderBegin = o1.getBegin()
            orderId = o1.id.get()
            XCTAssertEqual(orderId, 1)
            orderSymbol = o1.symbol.get()
            XCTAssertEqual(orderSymbol, "EURUSD")
            orderSide = o1.side.get()
            XCTAssertEqual(orderSide, OrderSide.buy)
            orderType = o1.type.get()
            XCTAssertEqual(orderType, OrderType.market)
            orderPrice = o1.price.get()
            XCTAssertEqual(orderPrice, 1.23456)
            orderVolume = o1.volume.get()
            XCTAssertEqual(orderVolume, 1000.0)
            o1.getEnd(fbeBegin: orderBegin)

            let o2 = reader.model.orders.getItem(index: 1)
            orderBegin = o2.getBegin()
            orderId = o2.id.get()
            XCTAssertEqual(orderId, 2)
            orderSymbol = o2.symbol.get()
            XCTAssertEqual(orderSymbol, "EURUSD")
            orderSide = o2.side.get()
            XCTAssertEqual(orderSide, OrderSide.sell)
            orderType = o2.type.get()
            XCTAssertEqual(orderType, OrderType.limit)
            orderPrice = o2.price.get()
            XCTAssertEqual(orderPrice, 1.0)
            orderVolume = o2.volume.get()
            XCTAssertEqual(orderVolume, 100.0)
            o1.getEnd(fbeBegin: orderBegin)

            let o3 = reader.model.orders.getItem(index: 2)
            orderBegin = o3.getBegin()
            orderId = o3.id.get()
            XCTAssertEqual(orderId, 3)
            orderSymbol = o3.symbol.get()
            XCTAssertEqual(orderSymbol, "EURUSD")
            orderSide = o3.side.get()
            XCTAssertEqual(orderSide, OrderSide.buy)
            orderType = o3.type.get()
            XCTAssertEqual(orderType, OrderType.stop)
            orderPrice = o3.price.get()
            XCTAssertEqual(orderPrice, 1.5)
            orderVolume = o3.volume.get()
            XCTAssertEqual(orderVolume, 10.0)
            o1.getEnd(fbeBegin: orderBegin)

            reader.model.getEnd(fbeBegin: accountBegin)
        } catch {
            XCTFail("catch error")
        }
    }
}
