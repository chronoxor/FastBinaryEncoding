//
//  FinalReceiverEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/6/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

protocol FinalReceiverListener {
    func onReceive(value: Enums)
}

extension FinalReceiverListener {
    func onReceive(value: Enums) { }
}

extension EnumsNamespace {
    class FinalReceiver: ReceiverProtocol, FinalReceiverListener {
        var buffer: Buffer = Buffer()
        
        var logging: Bool = true
        var final: Bool = true
        
        // Receiver values accessors
        private var enumsValue: Enums = Enums()
        
        // Receiver models accessors
        private let enumsModel: EnumsFinalModel = EnumsFinalModel()
        
        init() {
            build(final: true)
        }
        
        init(buffer: Buffer) {
            build(with: buffer, final: true)
        }
        
        func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
            return onReceiveListener(listener: self, type: type, buffer: buffer, offset: offset, size: size)
        }
        
        func onReceiveListener(listener: FinalReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
            switch type {
            case EnumsFinalModel.fbeTypeConst:
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

