//
//  FieldModelBytes.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelBytes: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Field extra size
    var fbeExtra: Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return 0
        }
        
        let fbeBytesOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeBytesOffset == 0) || ((_buffer.offset + fbeBytesOffset + 4) > _buffer.size) {
            return 0
        }
        
        let fbeBytesSize = Int(readUInt32(offset: fbeBytesOffset))
        return 4 + fbeBytesSize
    }
    
    func verify() -> Bool {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return true
        }
        
        let fbeBytesOffset = Int(readUInt32(offset: fbeOffset))
        if fbeBytesOffset == 0 {
            return true
        }
        
        if (_buffer.offset + fbeBytesOffset + 4) > _buffer.size {
            return false
        }
        
        let fbeBytesSize = Int(readUInt32(offset: fbeBytesOffset))
        if (_buffer.offset + fbeBytesOffset + 4 + fbeBytesSize) > _buffer.size {
            return false
        }
        
        return true
    }
    
    // Get the value
    func get(defaults: Data = Data(count: 0)) -> Data {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return defaults
        }
        
        let fbeBytesOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeBytesOffset == 0) {
            return defaults
        }
        
        assert((_buffer.offset + fbeBytesOffset + 4) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeBytesOffset + 4) > _buffer.size {
            return defaults
        }
        
        let fbeBytesSize = Int(readUInt32(offset: fbeBytesOffset))
        assert((_buffer.offset + fbeBytesOffset + 4 + fbeBytesSize) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeBytesOffset + 4 + fbeBytesSize) > _buffer.size {
            return defaults
        }
        
        return readBytes(offset: fbeBytesOffset + 4, size: fbeBytesSize)
    }
    
    // Set the value
    func set(value: Data) throws {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return
        }
        
        let fbeBytesSize = value.count
        let fbeBytesOffset = try _buffer.allocate(size: 4 + fbeBytesSize) - _buffer.offset
        assert((fbeBytesOffset > 0) && ((_buffer.offset + fbeBytesOffset + 4 + fbeBytesSize) <= _buffer.size), "Model is broken!")
        if (fbeBytesOffset <= 0) || ((_buffer.offset + fbeBytesOffset + 4 + fbeBytesSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: UInt32(fbeBytesOffset))
        write(offset: fbeBytesOffset, value: UInt32(fbeBytesSize))
        write(offset: fbeBytesOffset + 4, value: value)
    }
}
