//
//  FieldModelChar.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelChar: FieldModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Field size
    let fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: CChar = 0) -> CChar {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readChar(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: CChar) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
