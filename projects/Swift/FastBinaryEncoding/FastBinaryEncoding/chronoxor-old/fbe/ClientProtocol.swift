//
//  Client.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

protocol ClientProtocol: class {
    
    // Get the send bytes buffer
    var sendBuffer: Buffer { get set }
    
    // Get the receive bytes buffer
    var receiveBuffer: Buffer { get set }
    
    // Enable/Disable logging
    var logging: Bool { get set }
    
    // Get the final protocol flag
    var final: Bool { get set }
    
    // Send message handler
    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int
    // Send log message handler
    func onSendLog(message: String)
    
    // Receive message handler
    func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool
    
    // Receive log message handler
    func onReceiveLog(message: String)

}

extension ClientProtocol {
    
     func build(with final: Bool) {
        self.final = final
    }
    
    func build(with sendBuffer: Buffer, receiveBuffer: Buffer, final: Bool) {
        self.sendBuffer = sendBuffer
        self.receiveBuffer = receiveBuffer
        self.final = final
    }
    
    func reset() {
        sendBuffer.reset()
        receiveBuffer.reset()
    }
    
    // Send serialized buffer.
    // Direct call of the method requires knowledge about internals of FBE models serialization.
    // Use it with care!
    func sendSerialized(serialized: Int) throws -> Int {
        assert(serialized > 0, "Invalid size of the serialized buffer!")
        
        if serialized <= 0 {
            return 0
        }
        
        // Shift the send buffer
        sendBuffer.shift(offset: serialized)
        
        // Send the value
        let sent = try onSend(buffer: sendBuffer.data, offset: 0, size: sendBuffer.size)
        try sendBuffer.remove(offset: 0, size: sent)
        return sent
    }
    
    func onSendLog(message: String) { }
    
    // Receive data
    func receive(buffer: inout Data ) throws {
        try receive(buffer: &buffer, offset: 0, size: buffer.count)
    }
    
    func receive(buffer: inout Data , offset: Int, size: Int) throws {
        assert((offset + size) <= buffer.count, "Invalid offset & size!")
        
        if (offset + size) > buffer.count {
            throw NSException(name: .invalidArgumentException, reason: "Invalid allocation size!") as! Error
        }
        
        if (size == 0) {
            return
        }
        
        // Storage buffer
        var offset0 = self.receiveBuffer.offset
        var offset1 = self.receiveBuffer.size
        var size1 = self.receiveBuffer.size

        // Receive buffer
        var offset2: Int = 0
        
        // While receive buffer is available to handle...
        while (offset2 < size)
        {
            var messageBuffer: Data?
            var messageOffset: Int = 0
            var messageSize: Int = 0
            
            // Try to receive message size
            var messageSizeCopied = false
            var messageSizeFound = false
            while (!messageSizeFound)
            {
                // Look into the storage buffer
                if (offset0 < size1)
                {
                    var count = min(size1 - offset0, 4)
                    if count == 4
                    {
                        messageSizeCopied = true
                        messageSizeFound = true
                        messageSize = Int(Buffer.readUInt32(buffer: self.receiveBuffer.data, offset: offset0))
                        offset0 += 4
                        break
                    }
                    else
                    {
                        // Fill remaining data from the receive buffer
                        if (offset2 < size)
                        {
                            count = min(size - offset2, 4 - count)
                            
                            // Allocate and refresh the storage buffer
                            try _ = self.receiveBuffer.allocate(size: count)
                            size1 += count
                            
                            self.receiveBuffer.data[offset1...] = buffer[(offset + offset2)...(offset + offset2) + count]
                            //System.arraycopy(buffer, (offset + offset2).toInt(), this.receiveBuffer.data, offset1.toInt(), count.toInt())
                            offset1 += count
                            offset2 += count
                            continue
                        }
                        else {
                            break
                        }
                    }
                }
                
                // Look into the receive buffer
                if (offset2 < size)
                {
                    let count = min(size - offset2, 4)
                    if (count == 4)
                    {
                        messageSizeFound = true
                        messageSize = Int(Buffer.readUInt32(buffer: buffer, offset: offset + offset2))
                        offset2 += 4
                        break
                    }
                    else
                    {
                        // Allocate and refresh the storage buffer
                        try _ = self.receiveBuffer.allocate(size: count)
                        size1 += count
                        
                        self.receiveBuffer.data[offset1...] = buffer[(offset + offset2)...(offset + offset2) + count]
                        //System.arraycopy(buffer, (offset + offset2).toInt(), self.receiveBuffer.data, offset1.toInt(), count.toInt())
                        offset1 += count
                        offset2 += count
                        continue
                    }
                } else {
                    break
                }
                
            }
            
            if (!messageSizeFound) {
                return
            }
            
            // Check the message full size
            let minSize: Int = {
                if (final) { return 4 + 4 } else { return 4 + 4 + 4 + 4 }
            }()
            
            assert(messageSize >= minSize, "Invalid receive data!")
            if (messageSize < minSize) {
                return
            }
            
            // Try to receive message body
            var messageFound = false
            while (!messageFound)
            {
                // Look into the storage buffer
                if (offset0 < size1)
                {
                    var count = min(size1 - offset0, messageSize - 4)
                    if (count == (messageSize - 4))
                    {
                        messageFound = true
                        messageBuffer = self.receiveBuffer.data
                        messageOffset = offset0 - 4
                        offset0 += messageSize - 4
                        break
                    }
                    else
                    {
                        // Fill remaining data from the receive buffer
                        if (offset2 < size)
                        {
                            // Copy message size into the storage buffer
                            if (!messageSizeCopied)
                            {
                                // Allocate and refresh the storage buffer
                                try _ = self.receiveBuffer.allocate(size: 4)
                                size1 += 4
                                Buffer.write(buffer: &self.receiveBuffer.data, offset: offset0, value: UInt32(messageSize))
                                offset0 += 4
                                offset1 += 4
                                
                                messageSizeCopied = true
                            }
                            
                            count = min(size - offset2, messageSize - 4 - count)
                            
                            // Allocate and refresh the storage buffer
                            try _ = self.receiveBuffer.allocate(size: count)
                            size1 += count
                            
                            self.receiveBuffer.data[offset1...] = buffer[(offset + offset2)...(offset + offset2) + count]
                            // System.arraycopy(buffer, (offset + offset2).toInt(), this.receiveBuffer.data, offset1.toInt(), count.toInt())
                            offset1 += count
                            offset2 += count
                            continue
                        } else {
                            break
                        }
                    }
                }
                
                // Look into the receive buffer
                if (offset2 < size)
                {
                    let count = min(size - offset2, messageSize - 4)
                    if (!messageSizeCopied && (count == (messageSize - 4)))
                    {
                        messageFound = true
                        messageBuffer = buffer
                        messageOffset = offset + offset2 - 4
                        offset2 += messageSize - 4
                        break
                    }
                    else
                    {
                        // Copy message size into the storage buffer
                        if (!messageSizeCopied)
                        {
                            // Allocate and refresh the storage buffer
                            try _ = self.receiveBuffer.allocate(size: 4)
                            size1 += 4
                            
                            Buffer.write(buffer: &self.receiveBuffer.data, offset: offset0, value: UInt32(messageSize))
                            offset0 += 4
                            offset1 += 4
                            
                            messageSizeCopied = true
                        }
                        
                        // Allocate and refresh the storage buffer
                        try _ = self.receiveBuffer.allocate(size: count)
                        size1 += count
                        
                        self.receiveBuffer.data[offset1...] = buffer[(offset + offset2)...(offset + offset2) + count]
                        //System.arraycopy(buffer, (offset + offset2).toInt(), this.receiveBuffer.data, offset1.toInt(), count.toInt())
                        offset1 += count
                        offset2 += count
                        continue
                    }
                }
                else {
                    break
                }
            }
            
            if (!messageFound)
            {
                // Copy message size into the storage buffer
                if (!messageSizeCopied)
                {
                    // Allocate and refresh the storage buffer
                    try _ = self.receiveBuffer.allocate(size: 4)
                    size1 += 4
                    
                    Buffer.write(buffer: &self.receiveBuffer.data, offset: offset0, value: UInt32(messageSize))
                    offset0 += 4
                    offset1 += 4
                    
                    messageSizeCopied = true
                }
                return
            }
            
            if let messageBuffer = messageBuffer
            {
                //@Suppress("ASSIGNED_BUT_NEVER_ACCESSED_VARIABLE")
                let fbeStructSize: Int
                let fbeStructType: Int
                
                // Read the message parameters
                if (final)
                {
                    //@Suppress("UNUSED_VALUE")
                    fbeStructSize = Int(Buffer.readUInt32(buffer: messageBuffer, offset: messageOffset))
                    fbeStructType = Int(Buffer.readUInt32(buffer: messageBuffer, offset: messageOffset + 4))
                }
                else
                {
                    let fbeStructOffset = Int(Buffer.readUInt32(buffer: messageBuffer, offset: messageOffset + 4))
                    //@Suppress("UNUSED_VALUE")
                    fbeStructSize = Int(Buffer.readUInt32(buffer: messageBuffer, offset: messageOffset + fbeStructOffset))
                    fbeStructType = Int(Buffer.readUInt32(buffer: messageBuffer, offset: messageOffset + fbeStructOffset + 4))
                }
                
                // Handle the message
                _ = onReceive(type: fbeStructType, buffer: messageBuffer, offset: messageOffset, size: messageSize)
            }
            
            // Reset the storage buffer
            self.receiveBuffer.reset()
            
            // Refresh the storage buffer
            offset0 = self.receiveBuffer.offset
            offset1 = self.receiveBuffer.size
            size1 = self.receiveBuffer.size
        }
    }
    
    func onReceiveLog(message: String) { }
}
