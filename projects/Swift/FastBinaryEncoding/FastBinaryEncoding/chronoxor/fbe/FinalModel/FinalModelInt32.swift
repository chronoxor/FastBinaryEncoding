//
//  FinalModelDouble.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelInt32: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    func fbeAllocationSize(value: Int32) -> Int {
        return fbeSize
    }
    
    // Field size
    let fbeSize: Int = 4
    
    // Check if the value is valid
    func verify() -> Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: Size) -> Int32 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        size.value = fbeSize
        return readInt32(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Int32) -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        write(offset: fbeOffset, value: value)
        return fbeSize
    }
}
