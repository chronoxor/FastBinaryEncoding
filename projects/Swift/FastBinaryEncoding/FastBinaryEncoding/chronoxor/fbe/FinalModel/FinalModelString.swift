//
//  FinalModelString.swift
//  fbe-example
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelString: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    func fbeAllocationSize(value: String) -> Int {
        return 4 + 3 * (value.count + 1)
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + 4 > _buffer.size {
            return Int.max
        }
        
        let fbeStringSize = Int(readUInt32(offset: fbeOffset))
        if _buffer.offset + fbeOffset + 4 + fbeStringSize > _buffer.size {
            return Int.max
        }
        
        return 4 + fbeStringSize
    }
    
    // Get the value
    func get(size: inout Size) -> String {
        if ((_buffer.offset + fbeOffset + 4) > _buffer.size) {
            size.value = 0
            return ""
        }
        
        let fbeStringSize = Int(readUInt32(offset: fbeOffset))
        assert((_buffer.offset + fbeOffset + 4 + fbeStringSize) <= _buffer.size,"Model is broken!")
        if ((_buffer.offset + fbeOffset + 4 + fbeStringSize) > _buffer.size)
        {
            size.value = 4
            return ""
        }
        
        size.value = 4 + fbeStringSize
        return readString(offset: fbeOffset + 4, size: fbeStringSize)
    }
    
    // Set the value
    func set(value: String) -> Int {
        assert((_buffer.offset + fbeOffset + 4) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + 4) > _buffer.size) {
            return 0
        }
        
        let bytes = value.data(using: .utf8)!

        let fbeStringSize = bytes.count
        assert((_buffer.offset + fbeOffset + 4 + fbeStringSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + 4 + fbeStringSize) > _buffer.size) {
            return 4
        }
        
        write(offset: fbeOffset, value: UInt32(fbeStringSize))
        write(offset: fbeOffset + 4, value: bytes)
        return 4 + fbeStringSize
    }
}
