//
//  FieldModelFloat.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelFloat: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: Float = 0.0) -> Float {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readFloat(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Float) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
