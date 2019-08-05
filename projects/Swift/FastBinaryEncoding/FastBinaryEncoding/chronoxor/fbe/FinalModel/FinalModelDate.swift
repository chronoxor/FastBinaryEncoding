//
//  FinalModelDate.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelDate: FinalModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    func fbeAllocationSize(value: Date) -> Int {
        return fbeSize
    }
    
    // Field size
    let fbeSize: Int = 8
    
    func verify() -> Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: Size) -> Date {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return Date(timeIntervalSince1970: 0)
        }
        
        size.value = fbeSize
        let nanoseconds = readInt64(offset: fbeOffset)
        return Date(timeIntervalSince1970: TimeInterval(nanoseconds / 1000000))
    }
    
    // Set the value
    func set(value: Date) -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let nanoseconds = value.timeIntervalSince1970 * 1000000
        write(offset: fbeOffset, value: UInt64(nanoseconds))
        return fbeSize
    }
}
