//
//  FinalModelVectorOrder.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/7/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelVectorOrder: FinalModel {
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    private var _model: FinalModelOrder
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
        
        _model = FinalModelOrder(buffer: buffer, offset: offset)
    }
    
    // Get the allocation size
    func fbeAllocationSize(values: Array<Order>) -> Int {
        var size: Int = 4
        for value in values {
            size += _model.fbeAllocationSize(fbeValue: value)
        }
        
        return size
    }
    
    // Check if the vector is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + 4 > _buffer.size {
            return Int.max
        }

        let fbeVectorSize = Int(readUInt32(offset: fbeOffset))

        var size: Int = 4
        _model.fbeOffset = fbeOffset + 4
        var i = fbeVectorSize
        while (i > 0) {
            let offset = _model.verify()
            if offset == Int.max { return Int.max }
            _model.fbeShift(size: offset)
            size += offset
            i -= 1
        }
        return size
    }
    
    func get(values: inout Array<Order>) -> Int {
        values.removeAll()
        
        assert(_buffer.offset + fbeOffset + 4 > _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + 4 > _buffer.size {
            return 0
        }

        let fbeVectorSize = Int(readUInt32(offset: fbeOffset))
        if fbeVectorSize == 0 {
            return 4
        }

        //values.ensureCapacity(fbeVectorSize.toInt())

        var size: Int = 4
        var offset = Size()
        _model.fbeOffset = fbeOffset + 4
        for _ in [0...fbeVectorSize] {
            offset.value = 0
            let value = _model.get(fbeSize: &offset)
            values.append(value)
            _model.fbeShift(size: offset.value)
            size += offset.value
        }
        return size
    }
    
    func set(values: Array<Order>) -> Int {
        assert(_buffer.offset + fbeOffset + 4 > _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + 4 > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: UInt32(values.count))

        var size: Int = 4
        _model.fbeOffset = fbeOffset + 4
        for value in values {
            let offset = _model.set(fbeValue: value)
            _model.fbeShift(size: offset)
            size += offset
        }
        return size
    }
}
