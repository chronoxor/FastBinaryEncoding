//
//  Client.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Client: ClientProtocol, ReceiverListener {
    
    // Get the send bytes buffer
    var sendBuffer: Buffer = Buffer()
    
    // Get the receive bytes buffer
    var receiveBuffer: Buffer = Buffer()
    
    // Client sender models accessors
    let enumsSenderModel: EnumsModel
    
    // Client receiver values accessors
    private var enumsReceiverValue: Enums
    
    // Client receiver models accessors
    private let enumsReceiverModel: EnumsModel
    
    var logging: Bool = false
    var final: Bool = false
    
    init() {
        enumsSenderModel = EnumsModel(buffer: sendBuffer)
        enumsReceiverValue = Enums()
        enumsReceiverModel = EnumsModel(buffer: sendBuffer)
        
        build(with: false)
    }

    init(sendBuffer: Buffer, receiveBuffer: Buffer) {
        enumsSenderModel = EnumsModel(buffer: sendBuffer)
        enumsReceiverValue = Enums()
        enumsReceiverModel = EnumsModel(buffer: sendBuffer)
        
        build(with: false)
    }
    
    func send(obj: Any) throws -> Int {
        switch obj {
        case is Enums:
            return try send(value: obj as! Enums)
        default:
            return 0
        }
    }
    
    func send(value: Enums) throws -> Int {
        // Serialize the value into the FBE stream
        let serialized = try enumsSenderModel.serialize(value: value)
        assert(serialized > 0, "com.chronoxor.enums.Enums serialization failed!")
        assert(enumsSenderModel.verify(), "com.chronoxor.enums.Enums validation failed!")
        
        // Log the value
        if logging {
            let message = value.toString()
            onSendLog(message: message)
        }
        
        // Send the serialized value
        return try sendSerialized(serialized: serialized)
    }
    
    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int { throw NSError() }
    func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        return onReceiveListener(listener: self, type: type, buffer: buffer, offset: offset, size: size)
    }
    
    func onReceiveListener(listener: ReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        switch type {
        case EnumsModel.fbeTypeConst:
            // Deserialize the value from the FBE stream
            enumsReceiverModel.attach(buffer: buffer, offset: offset)
            assert(enumsReceiverModel.verify(), "com.chronoxor.enums.Enums validation failed!")
            let deserialized = enumsReceiverModel.deserialize(value: &enumsReceiverValue)
            assert(deserialized > 0, "com.chronoxor.enums.Enums deserialization failed!")
            
            // Log the value
            if logging {
                let message = enumsReceiverValue.toString()
                onReceiveLog(message: message)
            }
            
            // Call receive handler with deserialized value
            listener.onReceive(value: enumsReceiverValue)
            return true
        default:
            return false
        }
    }
}
