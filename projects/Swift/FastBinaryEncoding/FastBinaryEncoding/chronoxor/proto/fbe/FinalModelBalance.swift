//
//  FinalModelBalance.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelBalance: FinalModel {
    
    var _buffer: Buffer
    var _offset: Int
    
    var currency: FinalModelString
    var amount: FinalModelDouble
    
    var fbeType: Int = fbeTypeConst

    static let fbeTypeConst: Int = 2
    
    required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
        
        currency = FinalModelString(buffer: buffer, offset: 0)
        amount = FinalModelDouble(buffer: buffer, offset: 0)
    }
    
    func fbeAllocationSize(fbeValue: Balance) -> Int {
        return 0 + currency.fbeAllocationSize(value: fbeValue.currency) + amount.fbeAllocationSize(value: fbeValue.amount)
    }
    
    func verify() -> Int {
        _buffer.shift(offset: fbeOffset)
        let fbeResult = verifyFields()
        _buffer.unshift(offset: fbeOffset)
        return fbeResult
    }
    
    func verifyFields() -> Int {
        var fbeCurrentOffset = 0
        var fbeFieldSize = 0

        currency.fbeOffset = fbeCurrentOffset
        fbeFieldSize = currency.verify()

        if fbeFieldSize == Int.max {
            return Int.max
        }
        
        fbeCurrentOffset += fbeFieldSize
        
        amount.fbeOffset = fbeCurrentOffset
        fbeFieldSize = amount.verify()
        if fbeFieldSize == Int.max {
            return Int.max
        }

        fbeCurrentOffset += fbeFieldSize

        return fbeCurrentOffset
    }
    
    // Get the struct value
    func get(fbeSize: inout Size, fbeValue: Balance) -> Balance {
        _buffer.shift(offset: fbeOffset)
        fbeSize.value = getFields(fbeValue: fbeValue)
        _buffer.unshift(offset: fbeOffset)
        return fbeValue
    }
    
    func getFields(fbeValue: Balance) -> Int {
        var fbeCurrentOffset = 0
        var fbeCurrentSize = 0
        var fbeFieldSize = Size()
        
        currency.fbeOffset = fbeCurrentOffset
        fbeValue.currency = currency.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value
        
        amount.fbeOffset = fbeCurrentOffset
        fbeValue.amount = amount.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value
        
        return fbeCurrentSize
    }
    
    // Set the struct value
    func set(fbeValue: Balance) -> Int {
        _buffer.shift(offset: fbeOffset)
        let fbeSize = setFields(fbeValue: fbeValue)
        _buffer.unshift(offset: fbeOffset)
        return fbeSize
    }
    
    func setFields(fbeValue: Balance) -> Int {
        var fbeCurrentOffset = 0
        var fbeCurrentSize = 0
        let fbeFieldSize = Size()
        
        currency.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = currency.set(value: fbeValue.currency)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value
        
        amount.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = amount.set(value: fbeValue.amount)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value
        
        return fbeCurrentSize
    }
}
