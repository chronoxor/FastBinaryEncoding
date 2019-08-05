//
//  FieldModelDouble.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelDouble: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 8
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the value
    func get(defaults: Double = 0.0) -> Double {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return readDouble(offset: fbeOffset)
    }
    
    // Set the value
    func set(value: Double) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value)
    }
}
