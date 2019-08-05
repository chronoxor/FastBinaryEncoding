//
//  SenderProtocol.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

protocol SenderProtocol: class {
    
    // Get the bytes buffer
    var buffer: Buffer { get set }
    
    // Enable/Disable logging
    var logging: Bool { get set }
    
    // Get the final protocol flag
    var final: Bool { get set }
    
    
    // Send message handler
    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int

    // Send log message handler
    func onSendLog(message: String)
}

extension SenderProtocol {
    
    func build(with final: Bool) {
        self.final = final
    }
    
    func build(with buffer: Buffer, final: Bool) {
        self.buffer = buffer
        self.final = final
    }
    
    // Reset the sender buffer
    func reset() { buffer.reset() }

    // Send serialized buffer.
    // Direct call of the method requires knowledge about internals of FBE models serialization.
    // Use it with care!
    func sendSerialized(serialized: Int) throws -> Int {
        assert(serialized > 0, "Invalid size of the serialized buffer!")
        if (serialized <= 0) {
            return 0
        }
        
        // Shift the send buffer
        buffer.shift(offset: serialized)
        
        // Send the value
        let sent = try onSend(buffer: buffer.data, offset: 0, size: buffer.size)
        try _ = buffer.remove(offset: 0, size: sent)
        return sent
    }
    
    func onSendLog(message: String) {
        
    }
}
