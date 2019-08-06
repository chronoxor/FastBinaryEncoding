//
//  SenderEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/6/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

extension EnumsNamespace {
    class Sender: SenderProtocol {

        
        var logging: Bool = false
        var final: Bool = false
        
        var buffer: Buffer = Buffer()
        
        var enumsModel: EnumsModel
        
        init() {
            enumsModel = EnumsModel(buffer: buffer)
            
            build(with: false)
        }
        
        init(buffer: Buffer) {
            enumsModel = EnumsModel(buffer: buffer)

            build(with: buffer, final: false)
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
        
        func onSend(buffer: Data, offset: Int, size: Int) throws -> Int { throw NSError() }
    }
}
