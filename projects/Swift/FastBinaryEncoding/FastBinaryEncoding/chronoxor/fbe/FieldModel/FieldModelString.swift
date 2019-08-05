//
//  FieldModelString.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelString: FieldModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Field size
    let fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    var fbeExtra: Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return 0
        }
        
        let fbeStringOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStringOffset == 0) || ((_buffer.offset + fbeStringOffset + 4) > _buffer.size) {
            return 0
        }
        
        let fbeStringSize = Int(readUInt32(offset: fbeStringOffset))
        return 4 + fbeStringSize
    }
    
    // Check if the string value is valid
    func verify() -> Bool {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return true
        }
        
        let fbeStringOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStringOffset == 0) {
            return true
        }
        
        if (_buffer.offset + fbeStringOffset + 4) > _buffer.size {
            return false
        }
        
        let fbeStringSize = Int(readUInt32(offset: fbeStringOffset))
        if ((_buffer.offset + fbeStringOffset + 4 + fbeStringSize) > _buffer.size) {
            return false
        }
        
        return true
    }
    
    // Get the value
    func get(defaults: String = "") -> String {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        let fbeStringOffset = Int(readUInt32(offset: fbeOffset))
        if fbeStringOffset == 0 {
            return defaults
        }
        
        assert((_buffer.offset + fbeStringOffset + 4) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeStringOffset + 4) > _buffer.size {
            return defaults
        }
        
        let fbeStringSize = Int(readUInt32(offset: fbeStringOffset))
        assert((_buffer.offset + fbeStringOffset + 4 + fbeStringSize) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeStringOffset + 4 + fbeStringSize) > _buffer.size {
            return defaults
        }
        
        return readString(offset: fbeStringOffset + 4, size: fbeStringSize)
    }
    
    // Set the value
    func set(value: String) throws {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        let bytes = value.data(using: .utf8)!
        
        let fbeStringSize = bytes.count
        let fbeStringOffset = try _buffer.allocate(size: 4 + fbeStringSize) - _buffer.offset
        assert(((fbeStringOffset > 0) && ((_buffer.offset + fbeStringOffset + 4 + fbeStringSize) <= _buffer.size)), "Model is broken!")
        if ((fbeStringOffset <= 0) || ((_buffer.offset + fbeStringOffset + 4 + fbeStringSize) > _buffer.size)) {
            return
        }
            
        write(offset: fbeOffset, value: UInt32(fbeStringOffset))
        write(offset: fbeStringOffset, value: UInt32(fbeStringSize))
        write(offset: fbeStringOffset + 4, value: bytes)
    }
}
