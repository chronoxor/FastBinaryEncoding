//
//  FieldModelUInt64.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelUInt64: FieldModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Field size
    let fbeSize: Int = 8
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: UInt64 = 0) -> UInt64 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readUInt64(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: UInt64) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
