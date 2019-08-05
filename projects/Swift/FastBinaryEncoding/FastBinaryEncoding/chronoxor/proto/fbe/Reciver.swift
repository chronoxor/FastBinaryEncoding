//
//  Reciver.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Reciver: ReceiverProtocol, ReceiverListener {
    
    var buffer: Buffer = Buffer()
    var logging: Bool = false
    var final: Bool = false
    
    private var balanceValue: Balance
    private let balanceModel: BalanceModel
    
    init() {
        balanceValue = Balance()
        balanceModel = BalanceModel(buffer: buffer)
        
        self.build(final: false)
    }
    
    init(buffer: Buffer) {
        balanceValue = Balance()
        balanceModel = BalanceModel(buffer: buffer)
        
        build(with: buffer, final: false)
    }
    
    func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        return onReceiveListener(listener: self, type: type, buffer: buffer, offset: offset, size: size)
    }
    
    func onReceiveListener(listener: ReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        switch type {
        case BalanceModel.fbeTypeConst:
            balanceModel.attach(buffer: buffer, offset: offset)
            assert(balanceModel.verify(), "com.chronoxor.proto.Balance validation failed!")
            let deserialized = balanceModel.deserialize(value: &balanceValue)
            assert(deserialized > 0, "com.chronoxor.proto.Balance deserialization failed!")
            
            // Log the value
            if (logging) {
//                let message = balanceModel.to
//                onReceiveLog(message)
            }
            
            // Call receive handler with deserialized value
            listener.onReceive(value: balanceValue)
            return true
        default:
            return false
        }
    }
    
    func onReceive(value: Balance) {
        assert(false, "")
    }
}
