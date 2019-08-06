//
//  EnumsModel.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class EnumsModel: Model {
    var model: FieldModelEnums
    
    init() {
        let buffer = Buffer()
        model = FieldModelEnums(buffer: buffer, offset: 4)

        super.init(buffer: buffer)
    }
    
    override init(buffer: Buffer) {
        model = FieldModelEnums(buffer: buffer, offset: 4)

        super.init(buffer: buffer)
    }
    
    func fbeSize() -> Int {
        return model.fbeSize + model.fbeExtra
    }
    
    var fbeType: Int = fbeTypeConst
    
    static let fbeTypeConst: Int = FieldModelEnums.fbeTypeConst
    
    func verify() -> Bool {
        if buffer.offset + model.fbeOffset - 4 > buffer.size {
            return false
        }
        
        let fbeFullSize = Int(readUInt32(offset: model.fbeOffset - 4))
        if fbeFullSize < model.fbeSize {
            return false
        }
        
        return model.verify()
    }
    
    func createBegin() throws -> Int {
        return try buffer.allocate(size: 4 + model.fbeSize)
    }
    
    func createEnd(fbeBegin: Int) -> Int {
        let fbeEnd = buffer.size
        let fbeFullSize = fbeEnd - fbeBegin
        write(offset: model.fbeOffset - 4, value: UInt32(fbeFullSize))
        return fbeFullSize
    }
    
    // Serialize the struct value
    func serialize(value: Enums) throws -> Int {
        let fbeBegin = try createBegin()
        try model.set(fbeValue: value)
        return createEnd(fbeBegin: fbeBegin)
    }
    
    func deserialize() -> Enums {
        var value = Enums()
        _ = deserialize(value: &value)
        return value
    }
    
    func deserialize(value: inout Enums) -> Int {
        var valueRef = value
        
        if buffer.offset + model.fbeOffset - 4 > buffer.size {
            valueRef = Enums()
            return 0
        }
        
        let fbeFullSize = Int(readUInt32(offset: model.fbeOffset - 4))
        assert(fbeFullSize >= model.fbeSize,"Model is broken!")
        if (fbeFullSize < model.fbeSize) {
            valueRef = Enums()
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
