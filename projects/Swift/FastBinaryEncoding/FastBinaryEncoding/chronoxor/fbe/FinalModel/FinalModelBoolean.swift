//
//  FinalModelBoolean.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelBoolean: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Get the allocation size
    func fbeAllocationSize(value: Bool) -> Int {
        return fbeSize
    }
    
    func verify() -> Int {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return Int.max
        }

        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> Bool {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return false
        }
        
        size.value = fbeSize
        return readBoolean(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Bool) -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        write(offset: fbeOffset, value: value)
        return fbeSize
    }
}
