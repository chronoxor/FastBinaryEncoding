//
//  FinalModelBytes.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelBytes: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    func fbeAllocationSize(value: Data) -> Int {
        return 4 + value.count
    }
    
    func verify() -> Int {
        if (_buffer.offset + fbeOffset) + 4 > _buffer.size {
            return Int.max
        }
        
        let fbeBytesSize = Int(readUInt32(offset: fbeOffset))
        if (_buffer.offset + fbeOffset + 4 + fbeBytesSize) > _buffer.size {
            return Int.max
        }
        
        return 4 + fbeBytesSize
    }
    
    // Get the value
    func get(size: Size) -> Data {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            size.value = 0
            return Data()
        }
        
        let fbeBytesSize = Int(readUInt32(offset: fbeOffset))
        assert((_buffer.offset + fbeOffset + 4 + fbeBytesSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + 4 + fbeBytesSize) > _buffer.size)
        {
            size.value = 4
            return Data()
        }
        
        size.value = 4 + fbeBytesSize
        return readBytes(offset: fbeOffset + 4, size: fbeBytesSize)
    }
    
    // Set the value
    func set(value: Data) throws -> Int {
        assert((_buffer.offset + fbeOffset + 4) <= _buffer.size, "Model is broken!")
        if (_buffer.offset + fbeOffset + 4) > _buffer.size {
            return 0
        }
        
        let fbeBytesSize = value.count
        assert(_buffer.offset + fbeOffset + 4 + fbeBytesSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + 4 + fbeBytesSize > _buffer.size {
            return 4
        }
        
        write(offset: fbeOffset, value: UInt32(fbeBytesSize))
        write(offset: fbeOffset + 4, value: value)
        return 4 + fbeBytesSize
    }
}
