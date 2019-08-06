//
//  FinalSender.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalSender: Sender {
    
    private var balanceModel: BalanceFinalModel
    
    override init() {
        balanceModel = BalanceFinalModel(buffer: Buffer())

        super.init()
    
        self.build(with: true)
        
        self.balanceModel = BalanceFinalModel(buffer: self.buffer)
    }
    
    override init(buffer: Buffer) {
        balanceModel = BalanceFinalModel(buffer: buffer)

        super.init(buffer: buffer)
        
        self.build(with: buffer, final: true)
    }
    
    override func send(obj: Any) throws -> Int {
        switch obj {
        case is Balance:
            return try send(value: obj as! Balance)
        default:
            return 0
        }
    }
    
    override func send(value: Balance) throws -> Int {
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
    
    override func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
        throw NSError()
    }
}
