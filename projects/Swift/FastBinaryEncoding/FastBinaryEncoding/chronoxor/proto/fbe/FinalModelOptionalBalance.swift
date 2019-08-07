//
//  FinalModelOptionalBalance.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/7/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelOptionalBalance: FinalModel {

    var _buffer: Buffer
    var _offset: Int

    // Field body size
    let fbeBody: Int

    // Base field model value
    let value: FinalModelBalance
    
    required init() {
        let buffer = Buffer()
        let offset = 0

        _buffer = buffer
        _offset = offset

        value = FinalModelBalance(buffer: buffer, offset: offset)
    }

    required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset

        value = FinalModelBalance(buffer: buffer, offset: offset)
    }
    
    func fbeAllocationSize(optional: Balance?) -> Int {
        return 1 + (optional != nil ? value.fbeAllocationSize(fbeValue: optional!) : 0)
    }


    func hasValue() -> Bool {
        if _buffer.offset + fbeOffset + 1 > _buffer.size {
            return false
        }

        let fbeHasValue = Int32(readInt8(offset: fbeOffset))
        return fbeHasValue != 0
    }

    func verify() -> Int {
        if _buffer.offset + fbeOffset + 1 > _buffer.size {
            return Int.max
        }

        let fbeHasValue = Int(readInt8(offset: fbeOffset))
        if fbeHasValue == 0 {
            return Int.max
        }

        _buffer.shift(offset: fbeOffset)
        let fbeResult = value.verify()
        _buffer.unshift(offset: fbeOffset)
        return fbeResult
    }

    func get(size: inout Size) -> Balance? {
        assert(_buffer.offset + fbeOffset + 1 <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + 1 > _buffer.size {
            size.value = 0
            return nil
        }

        if !hasValue() {
            size.value = 1
            return nil
        }
        
        _buffer.shift(offset: fbeOffset + 1)
        let optional = value.get(fbeSize: &size)
        _buffer.unshift(offset: fbeOffset + 1)
        size.value += 1
        return optional
    }
  
    // Set the optional value
    func set(optional: Balance?) throws -> Int {
       assert(_buffer.offset + fbeOffset + 1 <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + 1 > _buffer.size {
            return 0
        }

        let fbeHasValue = optional != nil ? 1 : 0
        write(offset: fbeOffset, value: Int8(fbeHasValue))
        if fbeHasValue == 0 {
            return 1
        }

        _buffer.shift(offset: fbeOffset + 1)
        let size = value.set(fbeValue: optional!)
        _buffer.unshift(offset: fbeOffset + 1)
        return 1 + size
    }
}
