//
//  FinalModelChar.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelChar: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    func fbeAllocationSize(value: CChar) -> Int {
        return fbeSize
    }
    
    // Field size
    let fbeSize: Int = 1
    
    func verify() -> Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: Size) -> CChar {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        size.value = fbeSize
        return readChar(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: CChar) -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        write(offset: fbeOffset, value: value)
        return fbeSize
    }
}
