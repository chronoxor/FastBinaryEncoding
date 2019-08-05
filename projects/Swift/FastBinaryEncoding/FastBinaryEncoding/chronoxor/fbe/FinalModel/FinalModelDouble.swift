//
//  FinalModelDouble.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelDouble: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    func fbeAllocationSize(value: Double) -> Int {
        return fbeSize
    }
    
    // Field size
    let fbeSize: Int = 8
    
    // Check if the value is valid
    func verify() -> Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> Double {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        size.value = fbeSize
        return readDouble(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Double) -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        write(offset: fbeOffset, value: value)
        return fbeSize
    }
}
