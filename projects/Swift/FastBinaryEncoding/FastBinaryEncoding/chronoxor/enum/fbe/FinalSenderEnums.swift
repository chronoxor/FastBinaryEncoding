//
//  FinalSenderEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/6/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

extension EnumsNamespace {
    class FinalSender: SenderProtocol {
        
        var buffer: Buffer = Buffer()
        
        var logging: Bool = true
        var final: Bool = true
        
        // Sender models accessors
        let enumsModel: EnumsFinalModel
        
        init() {
            enumsModel = EnumsFinalModel(buffer: buffer)
            
            build(with: true)
        }
        
        init(buffer: Buffer) {
            enumsModel = EnumsFinalModel(buffer: buffer)
            
            build(with: buffer, final: true)
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
            let serialized = try enumsModel.serialize(value: value)
            assert(serialized > 0, "com.chronoxor.enums.Enums serialization failed!")
            assert(enumsModel.verify(), "com.chronoxor.enums.Enums validation failed!")

            // Log the value
            if logging {
                let message = value.toString()
                onSendLog(message: message)
            }

            // Send the serialized value
            return try sendSerialized(serialized: serialized)
        }
        
        func onSend(buffer: Data, offset: Int, size: Int) throws -> Int {
            throw NSError()
        }
        
    }
}
