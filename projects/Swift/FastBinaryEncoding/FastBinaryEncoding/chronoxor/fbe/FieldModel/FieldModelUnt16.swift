//
//  FieldModelUInt16.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelUInt16: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: UInt16 = 0) -> UInt16 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readUInt16(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: UInt16) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
