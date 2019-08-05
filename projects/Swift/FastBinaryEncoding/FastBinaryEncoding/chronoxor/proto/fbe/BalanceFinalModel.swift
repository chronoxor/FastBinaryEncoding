//
//  BalanceFinalModel.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class BalanceFinalModel: Model {
    
    let _model: FinalModelBalance
    
    static let fbeTypeConst: Int = FinalModelBalance.fbeTypeConst
    
    //    init() {
    //        model = FieldModelBalance(buffer: buffer, offset: 4)
    //
    //        super.init(buffer: buffer)
    //    }
    
    override init(buffer: Buffer) {
        _model = FinalModelBalance(buffer: buffer, offset: 8)
        
        super.init(buffer: buffer)
    }
    
    var fbeType: Int = fbeTypeConst
    
    func verify() -> Bool {
        if ((buffer.offset + _model.fbeOffset) > buffer.size) {
            return false
        }
        
        let fbeStructSize = Int(readUInt32(offset: _model.fbeOffset - 8))
        let fbeStructType = Int(readUInt32(offset: _model.fbeOffset - 4))
        if ((fbeStructSize <= 0) || (fbeStructType != fbeType)) {
            return false
        }
        
        return ((8 + _model.verify()) == fbeStructSize)
    }
    
    // Serialize the struct value
    func serialize(value: Balance) throws -> Int {
        let fbeInitialSize = buffer.size
        
        let fbeStructType = fbeType
        var fbeStructSize = 8 + _model.fbeAllocationSize(fbeValue: value)
        let fbeStructOffset = try buffer.allocate(size: fbeStructSize) - buffer.offset
        assert(buffer.offset + fbeStructOffset + fbeStructSize <= buffer.size, "Model is broken!")
        if ((buffer.offset + fbeStructOffset + fbeStructSize) > buffer.size) {
            return 0
        }
        
        fbeStructSize = 8 + _model.set(fbeValue: value)
        try buffer.resize(size: fbeInitialSize + fbeStructSize)
        
        write(offset: _model.fbeOffset - 8, value: UInt32(fbeStructSize))
        write(offset: _model.fbeOffset - 4, value: UInt32(fbeStructType))
        
        return fbeStructSize
    }
    
    // Deserialize the struct value
    func deserialize() -> Balance {
        var value = Balance()
        _ = deserialize(value: &value)
        return value
    }
    
    func deserialize(value: inout Balance) -> Int {
        var valueRef = value
        
        assert(buffer.offset + _model.fbeOffset <= buffer.size, "Model is broken!")
        if ((buffer.offset + _model.fbeOffset) > buffer.size) {
            return 0
        }
        
        let fbeStructSize = Int32(readUInt32(offset: _model.fbeOffset - 8))
        let fbeStructType = Int32(readUInt32(offset: _model.fbeOffset - 4))
        assert((fbeStructSize > 0) && (fbeStructType == fbeType), "Model is broken!")
        if (fbeStructSize <= 0) || (fbeStructType != fbeType) {
            return 8
        }
        
        var fbeSize = Size()
        valueRef = _model.get(fbeSize: &fbeSize, fbeValue: valueRef)
        return 8 + fbeSize.value
    }
    
    // Move to the next struct value
    func next(prev: Int) {
        _model.fbeShift(size: prev)
    }
}
