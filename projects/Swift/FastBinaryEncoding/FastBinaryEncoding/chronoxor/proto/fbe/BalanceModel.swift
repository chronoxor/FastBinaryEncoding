//
//  BalanceModel.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class BalanceModel: Model {
    
    let model: FieldModelBalance
    
    static let fbeTypeConst: Int = FieldModelBalance.fbeTypeConst
    
//    init() {
//        model = FieldModelBalance(buffer: buffer, offset: 4)
//        
//        super.init(buffer: buffer)
//    }
    
    override init(buffer: Buffer) {
        model = FieldModelBalance(buffer: buffer, offset: 4)

        super.init(buffer: buffer)
    }
    
    // Model size
    func fbeSize() -> Int {
        return model.fbeSize + model.fbeExtra
    }
    
    var fbeType: Int = fbeTypeConst

    func verify() -> Bool {
        if ((buffer.offset + model.fbeOffset - 4) > buffer.size) {
            return false
        }
        
        let fbeFullSize = Int(readUInt32(offset: model.fbeOffset - 4))
        if (fbeFullSize < model.fbeSize) {
            return false
        }
        
        return model.verify()
    }
    
    // Create a new model (begin phase)
    func createBegin() throws -> Int {
        return try buffer.allocate(size: 4 + model.fbeSize)
    }
    
    // Create a new model (end phase)
    func createEnd(fbeBegin: Int) -> Int {
        let fbeEnd = buffer.size
        let fbeFullSize = fbeEnd - fbeBegin
        write(offset: model.fbeOffset - 4, value: UInt32(fbeFullSize))
        return fbeFullSize
    }
    
    // Serialize the struct value
    func serialize(value: Balance) throws -> Int {
        let fbeBegin = try createBegin()
        try model.set(fbeValue: value)
        return createEnd(fbeBegin: fbeBegin)
    }
    
    // Deserialize the struct value
    func deserialize() -> Balance {
        var value = Balance()
        _ = deserialize(value: &value)
        return value
    }
    
    func deserialize(value: inout Balance) -> Int {
        var valueRef = value
        
        if ((buffer.offset + model.fbeOffset - 4) > buffer.size) {
            valueRef = Balance()
            return 0
        }
        
        let fbeFullSize = Int(readUInt32(offset: model.fbeOffset - 4))
        assert(fbeFullSize >= model.fbeSize, "Model is broken!")
        if (fbeFullSize < model.fbeSize)
        {
            valueRef = Balance()
            return 0
        }
        
        valueRef = model.get(fbeValue: valueRef)
        return fbeFullSize
    }
    
    // Move to the next struct value
    func next(prev: Int) {
        model.fbeShift(size: prev)
    }
}
