//
//  FinalReceiver.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalReceiver: Reciver {
    
    private var balanceValue: Balance
    private let balanceModel: BalanceFinalModel
    
    override init() {
        balanceValue = Balance()
        balanceModel = BalanceFinalModel(buffer: Buffer())
        
        super.init()

        self.build(final: true)
    }
    
    override init(buffer: Buffer) {
        balanceValue = Balance()
        balanceModel = BalanceFinalModel(buffer: buffer)
        
        super.init(buffer: buffer)

        build(with: buffer, final: true)
    }
    
    override func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        return onReceiveListener(listener: self, type: type, buffer: buffer, offset: offset, size: size)
    }
    
    override func onReceiveListener(listener: ReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        switch type {
        case BalanceFinalModel.fbeTypeConst:
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
}
