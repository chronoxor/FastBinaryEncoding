//
//  SendReceiveTest.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
@testable import FastBinaryEncoding

class MyFinalSender: FinalSender {
    override func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
        // Send nothing...
        return 0
    }
}

class MyFinalReceiver: FinalReceiver {
    private var _balance: Bool = false
    
    var check: Bool {
        return _balance
    }
    
    override func onReceive(value: Balance) {
        _balance = true
    }
}

class SendReceiveFinalTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        for i in 0...99 {
            for j in 0...99 {
                XCTAssertTrue(sendAndReceive(i: i, j: j))
            }
        }
    }
    
    func sendAndReceive(i: Int, j: Int) -> Bool {
        let sender = MyFinalSender()
        
        // Create and send a new balance wallet
        let balance = Balance(currency: "USD", amount: 1000.0)
        try? sender.send(value: balance)
        
        let receiver = MyFinalReceiver()
        // Receive data from the sender
        let index1 = i % sender.buffer.size
        var index2 = j % sender.buffer.size
        index2 = max(index1, index2)
        try? receiver.receive(buffer: sender.buffer.data, offset: 0, size: sender.buffer.size)
        return receiver.check
    }
}
