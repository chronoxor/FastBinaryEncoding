//
//  Sender.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Sender: SenderProtocol {
    
    var buffer: Buffer = Buffer()
    var logging: Bool = false
    var final: Bool = false
    
    private var balanceModel: BalanceModel
    
    init() {
        balanceModel = BalanceModel(buffer: buffer)
        self.build(with: false)
    }
    
    init(buffer: Buffer) {
        balanceModel = BalanceModel(buffer: buffer)

        self.build(with: buffer, final: false)
    }
    
    func send(obj: Any) throws -> Int {
        switch obj {
        case is Balance:
            return try send(value: obj as! Balance)
        default:
            return 0
        }
    }
    
    func send(value: Balance) throws -> Int {
        // Serialize the value into the FBE stream
        let serialized = try balanceModel.serialize(value: value)
        assert(serialized > 0, "com.chronoxor.proto.Balance serialization failed!")
        assert(balanceModel.verify(), "com.chronoxor.proto.Balance validation failed!")
        
        // Log the value
        if (logging) {
//            val message = value.toString()
//            onSendLog(message)
        }
        
        // Send the serialized value
        return try sendSerialized(serialized: serialized)
    }
    
    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
        throw NSError()
    }
}
