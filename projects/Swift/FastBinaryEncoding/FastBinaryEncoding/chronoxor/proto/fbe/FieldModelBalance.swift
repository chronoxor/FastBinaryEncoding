//
//  FieldModelBalance.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelBalance: FieldModel {
    var _buffer: Buffer
    var _offset: Int
    
    let currency: FieldModelString
    let amount: FieldModelDouble
    
    let fbeSize: Int = 4
    
    // Field body size
    let fbeBody: Int
    
    static let fbeTypeConst: Int = 2
    
    required init() {
        _buffer = Buffer()
        _offset = 0
        
        currency = FieldModelString(buffer: _buffer, offset: 4 + 4)
        amount = FieldModelDouble(buffer: _buffer, offset: currency.fbeOffset + currency.fbeSize)
        
        fbeBody = 4 + 4 + currency.fbeSize + amount.fbeSize
    }
    
    required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
        
        currency = FieldModelString(buffer: buffer, offset: 4 + 4)
        amount = FieldModelDouble(buffer: buffer, offset: currency.fbeOffset + currency.fbeSize)
        
        fbeBody = 4 + 4 + currency.fbeSize + amount.fbeSize
    }
    
    var fbeExtra: Int {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4) > _buffer.size) {
            return 0
        }
        
        _buffer.shift(offset: fbeStructOffset)
        
        let fbeResult = (fbeBody
            + currency.fbeExtra
            + amount.fbeExtra
        )
        
        _buffer.unshift(offset: fbeStructOffset)
        
        return fbeResult
    }
    
    var fbeType: Int = fbeTypeConst

    // Check if the struct value is valid
    func verify(fbeVerifyType: Bool = true) -> Bool {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return true
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size) {
            return false
        }
        
        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        if (fbeStructSize < (4 + 4)) {
            return false
        }
        
        let fbeStructType = Int(readUInt32(offset: fbeStructOffset + 4))
        if (fbeVerifyType && (fbeStructType != fbeType))  {
            return false
        }
        
        _buffer.shift(offset: fbeStructOffset)
        let fbeResult = verifyFields(fbeStructSize: fbeStructSize)
        _buffer.unshift(offset: fbeStructOffset)
        return fbeResult
    }
    
    func verifyFields(fbeStructSize: Int) -> Bool {
        var fbeCurrentSize = 4 + 4

        if ((fbeCurrentSize + currency.fbeSize) > fbeStructSize) {
            return true
        }
        if (!currency.verify()){
            return false
        }
        fbeCurrentSize += currency.fbeSize
        
        if ((fbeCurrentSize + amount.fbeSize) > fbeStructSize) {
            return true
        }
        if (!amount.verify()){
            return false
        }
        fbeCurrentSize += amount.fbeSize
        
        return true
    }
    
    // Get the struct value (begin phase)
    func getBegin() -> Int {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        assert((fbeStructOffset > 0) && ((_buffer.offset + fbeStructOffset + 4 + 4) <= _buffer.size), "Model is broken!")
        if ((fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size)) {
            return 0
        }
        
        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        assert(fbeStructSize >= (4 + 4), "Model is broken!")
        if (fbeStructSize < (4 + 4)) {
            return 0
        }
        
        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }
    
    // Get the struct value (end phase)
    func getEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }

    // Get the struct value
    func get(fbeValue: Balance = Balance()) -> Balance {
        let fbeBegin = getBegin()
        if (fbeBegin == 0) {
            return fbeValue
        }
        
        let fbeStructSize = Int(readUInt32(offset: 0))
        getFields(fbeValue: fbeValue, fbeStructSize: fbeStructSize)
        getEnd(fbeBegin: fbeBegin)
        return fbeValue
    }
    
    func getFields(fbeValue: Balance, fbeStructSize: Int) {
        var fbeCurrentSize = 4 + 4
        
        if ((fbeCurrentSize + currency.fbeSize) <= fbeStructSize) {
            fbeValue.currency = currency.get()
        } else {
            fbeValue.currency = ""
        }
        
        fbeCurrentSize += currency.fbeSize
        
        if ((fbeCurrentSize + amount.fbeSize) <= fbeStructSize) {
            fbeValue.amount = amount.get(defaults: 0.0)
        } else {
            fbeValue.amount = 0.0
        }
        
        fbeCurrentSize += amount.fbeSize
    }
    
    func setBegin() throws -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")

        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let fbeStructSize = fbeBody
        let fbeStructOffset = try _buffer.allocate(size: fbeStructSize) - _buffer.offset
        assert(((fbeStructOffset > 0) && ((_buffer.offset + fbeStructOffset + fbeStructSize) <= _buffer.size)), "Model is broken!")
        if ((fbeStructOffset <= 0) || ((_buffer.offset + fbeStructOffset + fbeStructSize) > _buffer.size)) {
            return 0
        }
        
        write(offset: fbeOffset, value: UInt32(fbeStructOffset))
        write(offset: fbeStructOffset, value: UInt32(fbeStructSize))
        write(offset: fbeStructOffset + 4, value: UInt32(fbeType))
        
        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }
    
    // Set the struct value (end phase)
    func setEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }
    
    // Set the struct value
    func set(fbeValue: Balance) throws {
        let fbeBegin = try setBegin()
        if (fbeBegin == 0) {
            return
        }
        
        try setFields(fbeValue: fbeValue)
        setEnd(fbeBegin: fbeBegin)
    }
    
    func setFields(fbeValue: Balance) throws {
        try currency.set(value: fbeValue.currency)
        amount.set(value: fbeValue.amount)
    }
}
