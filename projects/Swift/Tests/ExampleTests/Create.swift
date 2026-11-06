//
//  Create.swift
//  

import XCTest
@testable import ChronoxorProto

class ExampleCreate: XCTestCase {
    func testCreate() {
        // Create a new account using FBE model
        let account = AccountModel()
        let modelBegin = try! account.createBegin()
        var accountBegin = try! account.model.setBegin()
        try! account.model.id.set(value: 1)
        try! account.model.name.set(value: "Test")
        try! account.model.state.set(value: State.good)
        var walletBegin = try! account.model.wallet.setBegin()
        try! account.model.wallet.currency.set(value: "USD")
        try! account.model.wallet.amount.set(value: 1000.0)
        account.model.wallet.setEnd(fbeBegin: walletBegin)
        account.model.setEnd(fbeBegin: accountBegin)
        _ = account.createEnd(fbeBegin: modelBegin)
        assert(account.verify())

        // Show the serialized FBE size
        print("FBE size: \(account.buffer.size)")

        // Access the account using the FBE model
        let access = AccountModel()
        access.attach(buffer: account.buffer)
        assert(access.verify())

        let id: Int32
        let name: String
        let state: State
        let walletCurrency: String
        let walletAmount: Double

        accountBegin = access.model.getBegin()
        id = access.model.id.get()
        name = access.model.name.get()
        state = access.model.state.get()
        walletBegin = access.model.wallet.getBegin()
        walletCurrency = access.model.wallet.currency.get()
        walletAmount = access.model.wallet.amount.get()
        access.model.wallet.getEnd(fbeBegin: walletBegin)
        access.model.getEnd(fbeBegin: accountBegin)

        // Show account content
        print("account.id = \(id)")
        print("account.name = \(name)")
        print("account.state = \(state)")
        print("account.wallet.currency = \(walletCurrency)")
        print("account.wallet.amount = \(walletAmount)")
    }
}
