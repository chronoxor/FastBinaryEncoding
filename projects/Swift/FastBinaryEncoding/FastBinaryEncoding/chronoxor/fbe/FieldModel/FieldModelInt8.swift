//
//  FieldModelInt8.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelInt8: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Field size
    let fbeSize: Int = 1
    
    // Get the value
    func get(defaults: Int8 = 0) -> Int8 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readInt8(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Int8) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
