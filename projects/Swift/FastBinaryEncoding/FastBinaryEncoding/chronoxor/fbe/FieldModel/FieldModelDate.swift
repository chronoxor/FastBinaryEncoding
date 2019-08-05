//
//  FieldModelDate.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelDate: FieldModel {
    var _buffer = Buffer()
    var _offset: Int = 0
    
    // Field size
    let fbeSize: Int = 8
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: Date = Date(timeIntervalSince1970: 0)) -> Date {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        let nanoseconds = readInt64(offset: fbeOffset)
        return Date(timeIntervalSince1970: TimeInterval(nanoseconds / 1000000))
    }
    
    // Set the value
    func set(value: Date) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        let nanoseconds = value.timeIntervalSince1970 * 1000000
        write(offset: fbeOffset, value: UInt64(nanoseconds))
    }
}
