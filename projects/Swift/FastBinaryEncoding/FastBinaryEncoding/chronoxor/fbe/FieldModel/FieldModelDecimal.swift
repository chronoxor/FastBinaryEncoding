//
//  FieldModelDecimal.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelDecimal: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 16
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: Decimal = Decimal.zero) -> Decimal {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        var magnitude = readBytes(offset: fbeOffset, size: 12)
        let scale = Int(readByte(offset: fbeOffset + 14))
        let signum: FloatingPointSign = (readInt8(offset: fbeOffset + 15) < 0) ? .minus : .plus
        
        // Reverse magnitude
        for i in 0...(magnitude.count / 2) {
            let temp = magnitude[i]
            magnitude[i] = magnitude[magnitude.count - i - 1]
            magnitude[magnitude.count - i - 1] = temp
        }
        
        
    
        let significand: UInt64 = UInt64(bigEndian: magnitude.withUnsafeBytes { $0.load(as: UInt64.self) } )
        return Decimal(sign: signum, exponent: scale, significand: Decimal(significand))
    }
    
    // Set the value
    func set(value: Decimal) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        // Get unscaled absolute value
        let unscaled = abs(value).significand
        let bitLength = unscaled._length
        if ((bitLength < 0) || (bitLength > 96))
        {
            // Value too big for .NET Decimal (bit length is limited to [0, 96])
            write(offset: fbeOffset, value: UInt8.zero, valueCount: fbeSize)
            return
        }
        
        // Get byte array
        let unscaledBytes = withUnsafeBytes(of: value.magnitude) {
            Array($0)
        }
        
        // Get scale
        let scale = abs(value.exponent)
        if ((scale < 0) || (scale > 28))
        {
            // Value scale exceeds .NET Decimal limit of [0, 28]
            write(offset: fbeOffset, value: UInt8.zero, valueCount: fbeSize)
            return
        }
        
        // Write unscaled value to bytes 0-11
        var index = 0
        var i = min(unscaledBytes.count, 14) - 1
        while ((i >= 0) && (index < 12))
        {
            write(offset: fbeOffset + index, value: unscaledBytes[i])
            i -= 1
            index += 1
            
            print(_buffer.data.debugDescription)
        }
        
        // Fill remaining bytes with zeros
        while (index < 14)
        {
            write(offset: fbeOffset + index, value: Int8.zero)
            index += 1
        }
        
        // Write scale at byte 14
        write(offset: fbeOffset + 14, value: Int8(scale))
        
        // Write signum at byte 15
        write(offset: fbeOffset + 15, value: Int8(value.isSignMinus ? -128 : 0))
    }
}
