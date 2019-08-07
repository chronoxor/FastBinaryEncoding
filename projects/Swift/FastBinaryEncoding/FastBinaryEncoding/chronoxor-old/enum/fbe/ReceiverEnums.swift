//
//  ReceiverEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/6/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

struct EnumsNamespace {
    
}

extension EnumsNamespace {
    class Receiver: ReceiverProtocol, ReceiverListener {
        var buffer: Buffer = Buffer()
        
        var logging: Bool = false
        var final: Bool = false
        
        // Receiver values accessors
        private var enumsValue: Enums = Enums()
        // Receiver models accessors
        private let enumsModel: EnumsModel = EnumsModel()
        
        init() {
            build(final: false)
        }
        
        init(buffer: Buffer) {
            build(with: buffer, final: false)
        }
        
        func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
            return onReceiveListener(listener: self, type: type, buffer: buffer, offset: offset, size: size)
        }
        
        func onReceiveListener(listener: ReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
            switch type {
                case EnumsModel.fbeTypeConst:
                    // Deserialize the value from the FBE stream
                    enumsModel.attach(buffer: buffer, offset: offset)
                    assert(enumsModel.verify(), "com.chronoxor.enums.Enums validation failed!")
                    let deserialized = enumsModel.deserialize(value: &enumsValue)
                    assert(deserialized > 0, "com.chronoxor.enums.Enums deserialization failed!")
                
                    // Log the value
                    if logging {
                        let message = enumsValue.toString()
                        onReceiveLog(message: message)
                    }
                
                    // Call receive handler with deserialized value
                    listener.onReceive(value: enumsValue)
                    return true
                default:
                    return false
            }
        }
    }
}
