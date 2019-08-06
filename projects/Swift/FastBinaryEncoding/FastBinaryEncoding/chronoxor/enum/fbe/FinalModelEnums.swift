//
//  FinalModelEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/6/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FinalModelEnums: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    lazy var byte0: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var byte1: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var byte2: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var byte3: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var byte4: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var byte5: FinalModelEnumByte = FinalModelEnumByte(buffer: _buffer, offset: 0)
    lazy var char0: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var char1: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var char2: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var char3: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var char4: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var char5: FinalModelEnumChar = FinalModelEnumChar(buffer: _buffer, offset: 0)
    lazy var wchar0: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var wchar1: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var wchar2: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var wchar3: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var wchar4: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var wchar5: FinalModelEnumWChar = FinalModelEnumWChar(buffer: _buffer, offset: 0)
    lazy var int8b0: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var int8b1: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var int8b2: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var int8b3: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var int8b4: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var int8b5: FinalModelEnumInt8 = FinalModelEnumInt8(buffer: _buffer, offset: 0)
    lazy var uint8b0: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var uint8b1: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var uint8b2: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var uint8b3: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var uint8b4: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var uint8b5: FinalModelEnumUInt8 = FinalModelEnumUInt8(buffer: _buffer, offset: 0)
    lazy var int16b0: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var int16b1: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var int16b2: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var int16b3: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var int16b4: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var int16b5: FinalModelEnumInt16 = FinalModelEnumInt16(buffer: _buffer, offset: 0)
    lazy var uint16b0: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var uint16b1: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var uint16b2: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var uint16b3: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var uint16b4: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var uint16b5: FinalModelEnumUInt16 = FinalModelEnumUInt16(buffer: _buffer, offset: 0)
    lazy var int32b0: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var int32b1: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var int32b2: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var int32b3: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var int32b4: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var int32b5: FinalModelEnumInt32 = FinalModelEnumInt32(buffer: _buffer, offset: 0)
    lazy var uint32b0: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var uint32b1: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var uint32b2: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var uint32b3: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var uint32b4: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var uint32b5: FinalModelEnumUInt32 = FinalModelEnumUInt32(buffer: _buffer, offset: 0)
    lazy var int64b0: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var int64b1: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var int64b2: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var int64b3: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var int64b4: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var int64b5: FinalModelEnumInt64 = FinalModelEnumInt64(buffer: _buffer, offset: 0)
    lazy var uint64b0: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    lazy var uint64b1: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    lazy var uint64b2: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    lazy var uint64b3: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    lazy var uint64b4: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    lazy var uint64b5: FinalModelEnumUInt64 = FinalModelEnumUInt64(buffer: _buffer, offset: 0)
    
    func fbeAllocationSize(fbeValue: Enums) -> Int {
        let byteAllocationSize = byte0.fbeAllocationSize(value: fbeValue.byte0)
            + byte1.fbeAllocationSize(value: fbeValue.byte1)
            + byte2.fbeAllocationSize(value: fbeValue.byte2)
            + byte3.fbeAllocationSize(value: fbeValue.byte3)
            + byte4.fbeAllocationSize(value: fbeValue.byte4)
            + byte5.fbeAllocationSize(value: fbeValue.byte5)
        let charAllocationSize = char0.fbeAllocationSize(value: fbeValue.char0)
            + char1.fbeAllocationSize(value: fbeValue.char1)
            + char2.fbeAllocationSize(value: fbeValue.char2)
            + char3.fbeAllocationSize(value: fbeValue.char3)
            + char4.fbeAllocationSize(value: fbeValue.char4)
            + char5.fbeAllocationSize(value: fbeValue.char5)
        let wcharAllocationSize = wchar0.fbeAllocationSize(value: fbeValue.wchar0)
            + wchar1.fbeAllocationSize(value: fbeValue.wchar1)
            + wchar2.fbeAllocationSize(value: fbeValue.wchar2)
            + wchar3.fbeAllocationSize(value: fbeValue.wchar3)
            + wchar4.fbeAllocationSize(value: fbeValue.wchar4)
            + wchar5.fbeAllocationSize(value: fbeValue.wchar5)
        let int8bAllocationSize = int8b0.fbeAllocationSize(value: fbeValue.int8b0)
            + int8b1.fbeAllocationSize(value: fbeValue.int8b1)
            + int8b2.fbeAllocationSize(value: fbeValue.int8b2)
            + int8b3.fbeAllocationSize(value: fbeValue.int8b3)
            + int8b4.fbeAllocationSize(value: fbeValue.int8b4)
            + int8b5.fbeAllocationSize(value: fbeValue.int8b5)
        let int16bAllocationSize = int16b0.fbeAllocationSize(value: fbeValue.int16b0)
            + int16b1.fbeAllocationSize(value: fbeValue.int16b1)
            + int16b2.fbeAllocationSize(value: fbeValue.int16b2)
            + int16b3.fbeAllocationSize(value: fbeValue.int16b3)
            + int16b4.fbeAllocationSize(value: fbeValue.int16b4)
            + int16b5.fbeAllocationSize(value: fbeValue.int16b5)
        let int32bAllocationSize = int32b0.fbeAllocationSize(value: fbeValue.int32b0)
            + int32b1.fbeAllocationSize(value: fbeValue.int32b1)
            + int32b2.fbeAllocationSize(value: fbeValue.int32b2)
            + int32b3.fbeAllocationSize(value: fbeValue.int32b3)
            + int32b4.fbeAllocationSize(value: fbeValue.int32b4)
            + int32b5.fbeAllocationSize(value: fbeValue.int32b5)
        let int64bAllocationSize = int64b0.fbeAllocationSize(value: fbeValue.int64b0)
            + int64b1.fbeAllocationSize(value: fbeValue.int64b1)
            + int64b2.fbeAllocationSize(value: fbeValue.int64b2)
            + int64b3.fbeAllocationSize(value: fbeValue.int64b3)
            + int64b4.fbeAllocationSize(value: fbeValue.int64b4)
            + int64b5.fbeAllocationSize(value: fbeValue.int64b5)
        let uint8bAllocationSize = uint8b0.fbeAllocationSize(value: fbeValue.uint8b0)
            + uint8b1.fbeAllocationSize(value: fbeValue.uint8b1)
            + uint8b2.fbeAllocationSize(value: fbeValue.uint8b2)
            + uint8b3.fbeAllocationSize(value: fbeValue.uint8b3)
            + uint8b4.fbeAllocationSize(value: fbeValue.uint8b4)
            + uint8b5.fbeAllocationSize(value: fbeValue.uint8b5)
        let uint16bAllocationSize = uint16b0.fbeAllocationSize(value: fbeValue.uint16b0)
            + uint16b1.fbeAllocationSize(value: fbeValue.uint16b1)
            + uint16b2.fbeAllocationSize(value: fbeValue.uint16b2)
            + uint16b3.fbeAllocationSize(value: fbeValue.uint16b3)
            + uint16b4.fbeAllocationSize(value: fbeValue.uint16b4)
            + uint16b5.fbeAllocationSize(value: fbeValue.uint16b5)
        let uint32bAllocationSize = uint32b0.fbeAllocationSize(value: fbeValue.uint32b0)
            + uint32b1.fbeAllocationSize(value: fbeValue.uint32b1)
            + uint32b2.fbeAllocationSize(value: fbeValue.uint32b2)
            + uint32b3.fbeAllocationSize(value: fbeValue.uint32b3)
            + uint32b4.fbeAllocationSize(value: fbeValue.uint32b4)
            + uint32b5.fbeAllocationSize(value: fbeValue.uint32b5)
        let uint64bAllocationSize = uint64b0.fbeAllocationSize(value: fbeValue.uint64b0)
            + uint64b1.fbeAllocationSize(value: fbeValue.uint64b1)
            + uint64b2.fbeAllocationSize(value: fbeValue.uint64b2)
            + uint64b3.fbeAllocationSize(value: fbeValue.uint64b3)
            + uint64b4.fbeAllocationSize(value: fbeValue.uint64b4)
            + uint64b5.fbeAllocationSize(value: fbeValue.uint64b5)
        return 0 + byteAllocationSize + charAllocationSize + int8bAllocationSize + int16bAllocationSize + int32bAllocationSize + int64bAllocationSize + uint8bAllocationSize + uint16bAllocationSize + uint32bAllocationSize + uint64bAllocationSize + wcharAllocationSize
    }
    
    // Field type
    var fbeType: Int = fbeTypeConst
    
    static let fbeTypeConst: Int = 1
    
    init(buffer: Buffer = Buffer(), offset: Int = 0) {
        _buffer = buffer
        _offset = offset
    }
    
    // Check if the struct value is valid
    func verify() -> Int {
        _buffer.shift(offset: fbeOffset)
        let fbeResult = verifyFields()
        _buffer.unshift(offset: fbeOffset)
        return fbeResult
    }
    
    // Check if the struct fields are valid
    func verifyFields() -> Int {
        var fbeCurrentOffset = 0
        var fbeFieldSize = 0

        byte0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        byte1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        byte2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        byte3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        byte4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        byte5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = byte5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        char5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = char5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        wchar5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = wchar5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int8b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int8b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint8b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint8b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int16b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int16b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint16b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint16b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int32b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int32b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint32b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint32b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        int64b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = int64b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b0.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b1.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b2.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b3.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b4.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        uint64b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize = uint64b5.verify()
        if (fbeFieldSize == Int.max) {
            return Int.max
        }
        fbeCurrentOffset += fbeFieldSize

        return fbeCurrentOffset
    }
    
    // Get the struct value
    func get(fbeSize: Size, fbeValue: Enums = Enums()) -> Enums {
        _buffer.shift(offset: fbeOffset)
        fbeSize.value = getFields(fbeValue: fbeValue)
        _buffer.unshift(offset: fbeOffset)
        return fbeValue
    }
    
    // Get the struct fields values
    func getFields(fbeValue: Enums) -> Int {
        var fbeCurrentOffset: Int = 0
        var fbeCurrentSize: Int = 0
        var fbeFieldSize = Size()

        byte0.fbeOffset = fbeCurrentOffset
        fbeValue.byte0 = byte0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte1.fbeOffset = fbeCurrentOffset
        fbeValue.byte1 = byte1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte2.fbeOffset = fbeCurrentOffset
        fbeValue.byte2 = byte2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte3.fbeOffset = fbeCurrentOffset
        fbeValue.byte3 = byte3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte4.fbeOffset = fbeCurrentOffset
        fbeValue.byte4 = byte4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte5.fbeOffset = fbeCurrentOffset
        fbeValue.byte5 = byte5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char0.fbeOffset = fbeCurrentOffset
        fbeValue.char0 = char0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char1.fbeOffset = fbeCurrentOffset
        fbeValue.char1 = char1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char2.fbeOffset = fbeCurrentOffset
        fbeValue.char2 = char2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char3.fbeOffset = fbeCurrentOffset
        fbeValue.char3 = char3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char4.fbeOffset = fbeCurrentOffset
        fbeValue.char4 = char4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char5.fbeOffset = fbeCurrentOffset
        fbeValue.char5 = char5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar0.fbeOffset = fbeCurrentOffset
        fbeValue.wchar0 = wchar0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar1.fbeOffset = fbeCurrentOffset
        fbeValue.wchar1 = wchar1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar2.fbeOffset = fbeCurrentOffset
        fbeValue.wchar2 = wchar2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar3.fbeOffset = fbeCurrentOffset
        fbeValue.wchar3 = wchar3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar4.fbeOffset = fbeCurrentOffset
        fbeValue.wchar4 = wchar4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar5.fbeOffset = fbeCurrentOffset
        fbeValue.wchar5 = wchar5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b0.fbeOffset = fbeCurrentOffset
        fbeValue.int8b0 = int8b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b1.fbeOffset = fbeCurrentOffset
        fbeValue.int8b1 = int8b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b2.fbeOffset = fbeCurrentOffset
        fbeValue.int8b2 = int8b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b3.fbeOffset = fbeCurrentOffset
        fbeValue.int8b3 = int8b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b4.fbeOffset = fbeCurrentOffset
        fbeValue.int8b4 = int8b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b5.fbeOffset = fbeCurrentOffset
        fbeValue.int8b5 = int8b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b0.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b0 = uint8b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b1.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b1 = uint8b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b2.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b2 = uint8b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b3.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b3 = uint8b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b4.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b4 = uint8b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b5.fbeOffset = fbeCurrentOffset
        fbeValue.uint8b5 = uint8b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b0.fbeOffset = fbeCurrentOffset
        fbeValue.int16b0 = int16b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b1.fbeOffset = fbeCurrentOffset
        fbeValue.int16b1 = int16b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b2.fbeOffset = fbeCurrentOffset
        fbeValue.int16b2 = int16b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b3.fbeOffset = fbeCurrentOffset
        fbeValue.int16b3 = int16b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b4.fbeOffset = fbeCurrentOffset
        fbeValue.int16b4 = int16b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b5.fbeOffset = fbeCurrentOffset
        fbeValue.int16b5 = int16b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b0.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b0 = uint16b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b1.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b1 = uint16b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b2.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b2 = uint16b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b3.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b3 = uint16b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b4.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b4 = uint16b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b5.fbeOffset = fbeCurrentOffset
        fbeValue.uint16b5 = uint16b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b0.fbeOffset = fbeCurrentOffset
        fbeValue.int32b0 = int32b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b1.fbeOffset = fbeCurrentOffset
        fbeValue.int32b1 = int32b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b2.fbeOffset = fbeCurrentOffset
        fbeValue.int32b2 = int32b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b3.fbeOffset = fbeCurrentOffset
        fbeValue.int32b3 = int32b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b4.fbeOffset = fbeCurrentOffset
        fbeValue.int32b4 = int32b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b5.fbeOffset = fbeCurrentOffset
        fbeValue.int32b5 = int32b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b0.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b0 = uint32b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b1.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b1 = uint32b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b2.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b2 = uint32b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b3.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b3 = uint32b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b4.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b4 = uint32b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b5.fbeOffset = fbeCurrentOffset
        fbeValue.uint32b5 = uint32b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b0.fbeOffset = fbeCurrentOffset
        fbeValue.int64b0 = int64b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b1.fbeOffset = fbeCurrentOffset
        fbeValue.int64b1 = int64b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b2.fbeOffset = fbeCurrentOffset
        fbeValue.int64b2 = int64b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b3.fbeOffset = fbeCurrentOffset
        fbeValue.int64b3 = int64b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b4.fbeOffset = fbeCurrentOffset
        fbeValue.int64b4 = int64b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b5.fbeOffset = fbeCurrentOffset
        fbeValue.int64b5 = int64b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b0.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b0 = uint64b0.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b1.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b1 = uint64b1.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b2.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b2 = uint64b2.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b3.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b3 = uint64b3.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b4.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b4 = uint64b4.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b5.fbeOffset = fbeCurrentOffset
        fbeValue.uint64b5 = uint64b5.get(size: &fbeFieldSize)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        return fbeCurrentSize
    }
    
    // Set the struct value
    func set(fbeValue: Enums) -> Int {
        _buffer.shift(offset: fbeOffset)
        let fbeSize = setFields(fbeValue: fbeValue)
        _buffer.unshift(offset: fbeOffset)
        return fbeSize
    }
    
    // Set the struct fields values
    func setFields(fbeValue: Enums) -> Int {
        var fbeCurrentOffset: Int = 0
        var fbeCurrentSize: Int = 0
        var fbeFieldSize = Size()

        byte0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte0.set(value: fbeValue.byte0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte1.set(value: fbeValue.byte1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte2.set(value: fbeValue.byte2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte3.set(value: fbeValue.byte3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte4.set(value: fbeValue.byte4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        byte5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = byte5.set(value: fbeValue.byte5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char0.set(value: fbeValue.char0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char1.set(value: fbeValue.char1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char2.set(value: fbeValue.char2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char3.set(value: fbeValue.char3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char4.set(value: fbeValue.char4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        char5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = char5.set(value: fbeValue.char5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar0.set(value: fbeValue.wchar0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar1.set(value: fbeValue.wchar1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar2.set(value: fbeValue.wchar2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar3.set(value: fbeValue.wchar3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar4.set(value: fbeValue.wchar4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        wchar5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = wchar5.set(value: fbeValue.wchar5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b0.set(value: fbeValue.int8b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b1.set(value: fbeValue.int8b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b2.set(value: fbeValue.int8b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b3.set(value: fbeValue.int8b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b4.set(value: fbeValue.int8b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int8b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int8b5.set(value: fbeValue.int8b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b0.set(value: fbeValue.uint8b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b1.set(value: fbeValue.uint8b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b2.set(value: fbeValue.uint8b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b3.set(value: fbeValue.uint8b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b4.set(value: fbeValue.uint8b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint8b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint8b5.set(value: fbeValue.uint8b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b0.set(value: fbeValue.int16b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b1.set(value: fbeValue.int16b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b2.set(value: fbeValue.int16b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b3.set(value: fbeValue.int16b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b4.set(value: fbeValue.int16b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int16b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int16b5.set(value: fbeValue.int16b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b0.set(value: fbeValue.uint16b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b1.set(value: fbeValue.uint16b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b2.set(value: fbeValue.uint16b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b3.set(value: fbeValue.uint16b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b4.set(value: fbeValue.uint16b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint16b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint16b5.set(value: fbeValue.uint16b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b0.set(value: fbeValue.int32b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b1.set(value: fbeValue.int32b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b2.set(value: fbeValue.int32b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b3.set(value: fbeValue.int32b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b4.set(value: fbeValue.int32b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int32b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int32b5.set(value: fbeValue.int32b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b0.set(value: fbeValue.uint32b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b1.set(value: fbeValue.uint32b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b2.set(value: fbeValue.uint32b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b3.set(value: fbeValue.uint32b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b4.set(value: fbeValue.uint32b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint32b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint32b5.set(value: fbeValue.uint32b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b0.set(value: fbeValue.int64b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b1.set(value: fbeValue.int64b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b2.set(value: fbeValue.int64b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b3.set(value: fbeValue.int64b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b4.set(value: fbeValue.int64b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        int64b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = int64b5.set(value: fbeValue.int64b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b0.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b0.set(value: fbeValue.uint64b0)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b1.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b1.set(value: fbeValue.uint64b1)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b2.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b2.set(value: fbeValue.uint64b2)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b3.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b3.set(value: fbeValue.uint64b3)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b4.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b4.set(value: fbeValue.uint64b4)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        uint64b5.fbeOffset = fbeCurrentOffset
        fbeFieldSize.value = uint64b5.set(value: fbeValue.uint64b5)
        fbeCurrentOffset += fbeFieldSize.value
        fbeCurrentSize += fbeFieldSize.value

        return fbeCurrentSize
    }
}

class FinalModelEnumByte: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 1
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumByte) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumByte {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumByte()
        }
        
        size.value = fbeSize
        return EnumByte(value: readByte(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumByte) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumChar: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 1
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumChar) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumChar {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumChar()
        }
        
        size.value = fbeSize
        return EnumChar(value: readChar(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumChar) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumInt8: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 1
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumInt8) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumInt8 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumInt8()
        }
        
        size.value = fbeSize
        return EnumInt8(value: readInt8(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt8) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumInt16: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 2
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumInt16) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumInt16 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumInt16()
        }
        
        size.value = fbeSize
        return EnumInt16(value: readInt16(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt16) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumInt32: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 4
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumInt32) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumInt32 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumInt32()
        }
        
        size.value = fbeSize
        return EnumInt32(value: readInt32(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt32) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumInt64: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 8
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumInt64) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumInt64 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumInt64()
        }
        
        size.value = fbeSize
        return EnumInt64(value: readInt64(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt64) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumUInt8: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 1
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumUInt8) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumUInt8 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumUInt8()
        }
        
        size.value = fbeSize
        return EnumUInt8(value: readUInt8(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt8) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumUInt16: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 2
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumUInt16) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumUInt16 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumUInt16()
        }
        
        size.value = fbeSize
        return EnumUInt16(value: readUInt16(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt16) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumUInt32: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 4
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumUInt32) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumUInt32 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumUInt32()
        }
        
        size.value = fbeSize
        return EnumUInt32(value: readUInt32(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt32) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumUInt64: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 8
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumUInt64) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumUInt64 {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumUInt64()
        }
        
        size.value = fbeSize
        return EnumUInt64(value: readUInt64(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt64) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

class FinalModelEnumWChar: FinalModel {
    var _buffer: Buffer
    var _offset: Int
    
    // Final size
    let fbeSize: Int = 4
    
    init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }
    
    // Get the allocation size
    func fbeAllocationSize(value: EnumWChar) -> Int {
        return fbeSize
    }
    
    // Check if the value is valid
    func verify() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return Int.max
        }
        
        return fbeSize
    }
    
    // Get the value
    func get(size: inout Size) -> EnumWChar {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return EnumWChar()
        }
        
        size.value = fbeSize
        return EnumWChar(value: readWChar(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumWChar) -> Int {
        assert(_buffer.offset + fbeOffset + fbeSize <= _buffer.size, "Model is broken!")
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        write(offset: fbeOffset, value: value.raw)
        return fbeSize
    }
}

