//
//  FieldModelEnums.swift
//  FastBinaryEncoding
//
//  Created by Andrey on 8/5/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class FieldModelEnums: FieldModel {
    var _buffer: Buffer
    var _offset: Int
    
    lazy var byte0: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: 4 + 4)
    lazy var byte1: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: byte0.fbeOffset + byte0.fbeSize)
    lazy var byte2: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: byte1.fbeOffset + byte1.fbeSize)
    lazy var byte3: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: byte2.fbeOffset + byte2.fbeSize)
    lazy var byte4: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: byte3.fbeOffset + byte3.fbeSize)
    lazy var byte5: FieldModelEnumByte = FieldModelEnumByte(buffer: _buffer, offset: byte4.fbeOffset + byte4.fbeSize)
    lazy var char0: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: byte5.fbeOffset + byte5.fbeSize)
    lazy var char1: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: char0.fbeOffset + char0.fbeSize)
    lazy var char2: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: char1.fbeOffset + char1.fbeSize)
    lazy var char3: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: char2.fbeOffset + char2.fbeSize)
    lazy var char4: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: char3.fbeOffset + char3.fbeSize)
    lazy var char5: FieldModelEnumChar = FieldModelEnumChar(buffer: _buffer, offset: char4.fbeOffset + char4.fbeSize)
    lazy var wchar0: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: char5.fbeOffset + char5.fbeSize)
    lazy var wchar1: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: wchar0.fbeOffset + wchar0.fbeSize)
    lazy var wchar2: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: wchar1.fbeOffset + wchar1.fbeSize)
    lazy var wchar3: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: wchar2.fbeOffset + wchar2.fbeSize)
    lazy var wchar4: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: wchar3.fbeOffset + wchar3.fbeSize)
    lazy var wchar5: FieldModelEnumWChar = FieldModelEnumWChar(buffer: _buffer, offset: wchar4.fbeOffset + wchar4.fbeSize)
    lazy var int8b0: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: wchar5.fbeOffset + wchar5.fbeSize)
    lazy var int8b1: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: int8b0.fbeOffset + int8b0.fbeSize)
    lazy var int8b2: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: int8b1.fbeOffset + int8b1.fbeSize)
    lazy var int8b3: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: int8b2.fbeOffset + int8b2.fbeSize)
    lazy var int8b4: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: int8b3.fbeOffset + int8b3.fbeSize)
    lazy var int8b5: FieldModelEnumInt8 = FieldModelEnumInt8(buffer: _buffer, offset: int8b4.fbeOffset + int8b4.fbeSize)
    lazy var uint8b0: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: int8b5.fbeOffset + int8b5.fbeSize)
    lazy var uint8b1: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: uint8b0.fbeOffset + uint8b0.fbeSize)
    lazy var uint8b2: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: uint8b1.fbeOffset + uint8b1.fbeSize)
    lazy var uint8b3: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: uint8b2.fbeOffset + uint8b2.fbeSize)
    lazy var uint8b4: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: uint8b3.fbeOffset + uint8b3.fbeSize)
    lazy var uint8b5: FieldModelEnumUInt8 = FieldModelEnumUInt8(buffer: _buffer, offset: uint8b4.fbeOffset + uint8b4.fbeSize)
    lazy var int16b0: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: uint8b5.fbeOffset + uint8b5.fbeSize)
    lazy var int16b1: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: int16b0.fbeOffset + int16b0.fbeSize)
    lazy var int16b2: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: int16b1.fbeOffset + int16b1.fbeSize)
    lazy var int16b3: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: int16b2.fbeOffset + int16b2.fbeSize)
    lazy var int16b4: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: int16b3.fbeOffset + int16b3.fbeSize)
    lazy var int16b5: FieldModelEnumInt16 = FieldModelEnumInt16(buffer: _buffer, offset: int16b4.fbeOffset + int16b4.fbeSize)
    lazy var uint16b0: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: int16b5.fbeOffset + int16b5.fbeSize)
    lazy var uint16b1: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: uint16b0.fbeOffset + uint16b0.fbeSize)
    lazy var uint16b2: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: uint16b1.fbeOffset + uint16b1.fbeSize)
    lazy var uint16b3: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: uint16b2.fbeOffset + uint16b2.fbeSize)
    lazy var uint16b4: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: uint16b3.fbeOffset + uint16b3.fbeSize)
    lazy var uint16b5: FieldModelEnumUInt16 = FieldModelEnumUInt16(buffer: _buffer, offset: uint16b4.fbeOffset + uint16b4.fbeSize)
    lazy var int32b0: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: uint16b5.fbeOffset + uint16b5.fbeSize)
    lazy var int32b1: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: int32b0.fbeOffset + int32b0.fbeSize)
    lazy var int32b2: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: int32b1.fbeOffset + int32b1.fbeSize)
    lazy var int32b3: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: int32b2.fbeOffset + int32b2.fbeSize)
    lazy var int32b4: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: int32b3.fbeOffset + int32b3.fbeSize)
    lazy var int32b5: FieldModelEnumInt32 = FieldModelEnumInt32(buffer: _buffer, offset: int32b4.fbeOffset + int32b4.fbeSize)
    lazy var uint32b0: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: int32b5.fbeOffset + int32b5.fbeSize)
    lazy var uint32b1: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: uint32b0.fbeOffset + uint32b0.fbeSize)
    lazy var uint32b2: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: uint32b1.fbeOffset + uint32b1.fbeSize)
    lazy var uint32b3: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: uint32b2.fbeOffset + uint32b2.fbeSize)
    lazy var uint32b4: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: uint32b3.fbeOffset + uint32b3.fbeSize)
    lazy var uint32b5: FieldModelEnumUInt32 = FieldModelEnumUInt32(buffer: _buffer, offset: uint32b4.fbeOffset + uint32b4.fbeSize)
    lazy var int64b0: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: uint32b5.fbeOffset + uint32b5.fbeSize)
    lazy var int64b1: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: int64b0.fbeOffset + int64b0.fbeSize)
    lazy var int64b2: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: int64b1.fbeOffset + int64b1.fbeSize)
    lazy var int64b3: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: int64b2.fbeOffset + int64b2.fbeSize)
    lazy var int64b4: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: int64b3.fbeOffset + int64b3.fbeSize)
    lazy var int64b5: FieldModelEnumInt64 = FieldModelEnumInt64(buffer: _buffer, offset: int64b4.fbeOffset + int64b4.fbeSize)
    lazy var uint64b0: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: int64b5.fbeOffset + int64b5.fbeSize)
    lazy var uint64b1: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: uint64b0.fbeOffset + uint64b0.fbeSize)
    lazy var uint64b2: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: uint64b1.fbeOffset + uint64b1.fbeSize)
    lazy var uint64b3: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: uint64b2.fbeOffset + uint64b2.fbeSize)
    lazy var uint64b4: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: uint64b3.fbeOffset + uint64b3.fbeSize)
    lazy var uint64b5: FieldModelEnumUInt64 = FieldModelEnumUInt64(buffer: _buffer, offset: uint64b4.fbeOffset + uint64b4.fbeSize)
    
    // Field size
    let fbeSize: Int = 4
    
    lazy var fbeBody: Int = { () -> Int in
        let byteSize = byte0.fbeSize
            + byte1.fbeSize
            + byte2.fbeSize
            + byte3.fbeSize
            + byte4.fbeSize
            + byte5.fbeSize
        let charSize = char0.fbeSize
            + char1.fbeSize
            + char2.fbeSize
            + char3.fbeSize
            + char4.fbeSize
            + char5.fbeSize
        let wcharSize = wchar0.fbeSize
            + wchar1.fbeSize
            + wchar2.fbeSize
            + wchar3.fbeSize
            + wchar4.fbeSize
            + wchar5.fbeSize
        let int8bSize = int8b0.fbeSize
            + int8b1.fbeSize
            + int8b2.fbeSize
            + int8b3.fbeSize
            + int8b4.fbeSize
            + int8b5.fbeSize
        let int16bSize = int16b0.fbeSize
            + int16b1.fbeSize
            + int16b2.fbeSize
            + int16b3.fbeSize
            + int16b4.fbeSize
            + int16b5.fbeSize
        let int32bSize = int32b0.fbeSize
            + int32b1.fbeSize
            + int32b2.fbeSize
            + int32b3.fbeSize
            + int32b4.fbeSize
            + int32b5.fbeSize
        
        let int64bSize = int64b0.fbeSize
            + int64b1.fbeSize
            + int64b2.fbeSize
            + int64b3.fbeSize
            + int64b4.fbeSize
            + int64b5.fbeSize
        let uint8bSize = uint8b0.fbeSize
            + uint8b1.fbeSize
            + uint8b2.fbeSize
            + uint8b3.fbeSize
            + uint8b4.fbeSize
            + uint8b5.fbeSize
        let uint16bSize = uint16b0.fbeSize
            + uint16b1.fbeSize
            + uint16b2.fbeSize
            + uint16b3.fbeSize
            + uint16b4.fbeSize
            + uint16b5.fbeSize
        let uint32bSize = uint32b0.fbeSize
            + uint32b1.fbeSize
            + uint32b2.fbeSize
            + uint32b3.fbeSize
            + uint32b4.fbeSize
            + uint32b5.fbeSize
        let uint64bSize = uint64b0.fbeSize
            + uint64b1.fbeSize
            + uint64b2.fbeSize
            + uint64b3.fbeSize
            + uint64b4.fbeSize
            + uint64b5.fbeSize
        return 4 + 4
            + byteSize
            + charSize
            + wcharSize
            + int8bSize
            + int16bSize
            + int32bSize
            + int64bSize
            + uint8bSize
            + uint16bSize
            + uint32bSize
            + uint64bSize
    }()
    
    var fbeExtra: Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if fbeStructOffset == 0 || ((_buffer.offset + fbeStructOffset + 4) > _buffer.size) {
            return 0
        }
        
        _buffer.shift(offset: fbeStructOffset)
        
        let byteExtra = byte0.fbeExtra
            + byte1.fbeExtra
            + byte2.fbeExtra
            + byte3.fbeExtra
            + byte4.fbeExtra
            + byte5.fbeExtra
        let charExtra = char0.fbeExtra
            + char1.fbeExtra
            + char2.fbeExtra
            + char3.fbeExtra
            + char4.fbeExtra
            + char5.fbeExtra
        let wcharExtra = wchar0.fbeExtra
            + wchar1.fbeExtra
            + wchar2.fbeExtra
            + wchar3.fbeExtra
            + wchar4.fbeExtra
            + wchar5.fbeExtra
        let int8bExtra = int8b0.fbeExtra
            + int8b1.fbeExtra
            + int8b2.fbeExtra
            + int8b3.fbeExtra
            + int8b4.fbeExtra
            + int8b5.fbeExtra
        let int16bExtra = int16b0.fbeExtra
            + int16b1.fbeExtra
            + int16b2.fbeExtra
            + int16b3.fbeExtra
            + int16b4.fbeExtra
            + int16b5.fbeExtra
        let int32bExtra = int32b0.fbeExtra
            + int32b1.fbeExtra
            + int32b2.fbeExtra
            + int32b3.fbeExtra
            + int32b4.fbeExtra
            + int32b5.fbeExtra
        
        let int64bExtra = int64b0.fbeExtra
            + int64b1.fbeExtra
            + int64b2.fbeExtra
            + int64b3.fbeExtra
            + int64b4.fbeExtra
            + int64b5.fbeExtra
        let uint8bExtra = uint8b0.fbeExtra
            + uint8b1.fbeExtra
            + uint8b2.fbeExtra
            + uint8b3.fbeExtra
            + uint8b4.fbeExtra
            + uint8b5.fbeExtra
        let uint16bExtra = uint16b0.fbeExtra
            + uint16b1.fbeExtra
            + uint16b2.fbeExtra
            + uint16b3.fbeExtra
            + uint16b4.fbeExtra
            + uint16b5.fbeExtra
        let uint32bExtra = uint32b0.fbeExtra
            + uint32b1.fbeExtra
            + uint32b2.fbeExtra
            + uint32b3.fbeExtra
            + uint32b4.fbeExtra
            + uint32b5.fbeExtra
        let uint64bExtra = uint64b0.fbeExtra
            + uint64b1.fbeExtra
            + uint64b2.fbeExtra
            + uint64b3.fbeExtra
            + uint64b4.fbeExtra
            + uint64b5.fbeExtra
        
        let fbeResult = fbeBody
            + byteExtra
            + charExtra
            + wcharExtra
            + int8bExtra
            + int16bExtra
            + int32bExtra
            + int64bExtra
            + uint8bExtra
            + uint16bExtra
            + uint32bExtra
            + uint64bExtra
        
        _buffer.unshift(offset: fbeStructOffset)
        
        return fbeResult
    }
    
    // Field type
    var fbeType: Int = fbeTypeConst
    
    static let fbeTypeConst: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    func verify(fbeVerifyType: Bool = true) -> Bool {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return true
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if ((fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size)) {
            return false
        }
        
        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        if (fbeStructSize < (4 + 4)) {
            return false
        }
        
        let fbeStructType = Int(readUInt32(offset: fbeStructOffset + 4))
        if (fbeVerifyType && (fbeStructType != fbeType)) {
            return false
        }
        
        _buffer.shift(offset: fbeStructOffset)
        let fbeResult = verifyFields(fbeStructSize: fbeStructSize)
        _buffer.unshift(offset: fbeStructOffset)
        return fbeResult
    }
    
    func verifyFields(fbeStructSize: Int) -> Bool {
        var fbeCurrentSize = 4 + 4
        
        if ((fbeCurrentSize + byte0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!byte0.verify()) {
            return false
        }
        fbeCurrentSize += byte0.fbeSize
        
        if ((fbeCurrentSize + byte1.fbeSize) > fbeStructSize) {
            return true
        }
        if (!byte1.verify()) {
            return false
        }
        fbeCurrentSize += byte1.fbeSize
        
        if ((fbeCurrentSize + byte2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!byte2.verify()) {
            return false
        }
        fbeCurrentSize += byte2.fbeSize
        
        if ((fbeCurrentSize + byte3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!byte3.verify()) {
            return false
        }
        fbeCurrentSize += byte3.fbeSize
        
        if ((fbeCurrentSize + byte4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!byte4.verify()) {
            return false
        }
        fbeCurrentSize += byte4.fbeSize
        
        if ((fbeCurrentSize + byte5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!byte5.verify()) {
            return false
        }
        fbeCurrentSize += byte5.fbeSize
        
        if ((fbeCurrentSize + char0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char0.verify()) {
            return false
        }
        fbeCurrentSize += char0.fbeSize
        
        if ((fbeCurrentSize + char1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char1.verify()) {
            return false
        }
        fbeCurrentSize += char1.fbeSize
        
        if ((fbeCurrentSize + char2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char2.verify()) {
            return false
        }
        fbeCurrentSize += char2.fbeSize
        
        if ((fbeCurrentSize + char3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char3.verify()) {
            return false
        }
        fbeCurrentSize += char3.fbeSize
        
        if ((fbeCurrentSize + char4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char4.verify()) {
            return false
        }
        fbeCurrentSize += char4.fbeSize
        
        if ((fbeCurrentSize + char5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!char5.verify()) {
            return false
        }
        fbeCurrentSize += char5.fbeSize
        
        if ((fbeCurrentSize + wchar0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar0.verify()) {
            return false
        }
        fbeCurrentSize += wchar0.fbeSize
        
        if ((fbeCurrentSize + wchar1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar1.verify()) {
            return false
        }
        fbeCurrentSize += wchar1.fbeSize
        
        if ((fbeCurrentSize + wchar2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar2.verify()) {
            return false
        }
        fbeCurrentSize += wchar2.fbeSize
        
        if ((fbeCurrentSize + wchar3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar3.verify()) {
            return false
        }
        fbeCurrentSize += wchar3.fbeSize
        
        if ((fbeCurrentSize + wchar4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar4.verify()) {
            return false
        }
        fbeCurrentSize += wchar4.fbeSize
        
        if ((fbeCurrentSize + wchar5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!wchar5.verify()) {
            return false
        }
        fbeCurrentSize += wchar5.fbeSize
        
        if ((fbeCurrentSize + int8b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b0.verify()) {
            return false
        }
        fbeCurrentSize += int8b0.fbeSize
        
        if ((fbeCurrentSize + int8b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b1.verify()) {
            return false
        }
        fbeCurrentSize += int8b1.fbeSize
        
        if ((fbeCurrentSize + int8b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b2.verify()) {
            return false
        }
        fbeCurrentSize += int8b2.fbeSize
        
        if ((fbeCurrentSize + int8b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b3.verify()) {
            return false
        }
        fbeCurrentSize += int8b3.fbeSize
        
        if ((fbeCurrentSize + int8b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b4.verify()) {
            return false
        }
        fbeCurrentSize += int8b4.fbeSize
        
        if ((fbeCurrentSize + int8b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int8b5.verify()) {
            return false
        }
        fbeCurrentSize += int8b5.fbeSize
        
        if ((fbeCurrentSize + uint8b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b0.verify()) {
            return false
        }
        fbeCurrentSize += uint8b0.fbeSize
        
        if ((fbeCurrentSize + uint8b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b1.verify()) {
            return false
        }
        fbeCurrentSize += uint8b1.fbeSize
        
        if ((fbeCurrentSize + uint8b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b2.verify()) {
            return false
        }
        fbeCurrentSize += uint8b2.fbeSize
        
        if ((fbeCurrentSize + uint8b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b3.verify()) {
            return false
        }
        fbeCurrentSize += uint8b3.fbeSize
        
        if ((fbeCurrentSize + uint8b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b4.verify()) {
            return false
        }
        fbeCurrentSize += uint8b4.fbeSize
        
        if ((fbeCurrentSize + uint8b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint8b5.verify()) {
            return false
        }
        fbeCurrentSize += uint8b5.fbeSize
        
        if ((fbeCurrentSize + int16b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b0.verify()) {
            return false
        }
        fbeCurrentSize += int16b0.fbeSize
        
        if ((fbeCurrentSize + int16b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b1.verify()) {
            return false
        }
        fbeCurrentSize += int16b1.fbeSize
        
        if ((fbeCurrentSize + int16b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b2.verify()) {
            return false
        }
        fbeCurrentSize += int16b2.fbeSize
        
        if ((fbeCurrentSize + int16b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b3.verify()) {
            return false
        }
        fbeCurrentSize += int16b3.fbeSize
        
        if ((fbeCurrentSize + int16b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b4.verify()) {
            return false
        }
        fbeCurrentSize += int16b4.fbeSize
        
        if ((fbeCurrentSize + int16b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int16b5.verify()) {
            return false
        }
        fbeCurrentSize += int16b5.fbeSize
        
        if ((fbeCurrentSize + uint16b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b0.verify()) {
            return false
        }
        fbeCurrentSize += uint16b0.fbeSize
        
        if ((fbeCurrentSize + uint16b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b1.verify()) {
            return false
        }
        fbeCurrentSize += uint16b1.fbeSize
        
        if ((fbeCurrentSize + uint16b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b2.verify()) {
            return false
        }
        fbeCurrentSize += uint16b2.fbeSize
        
        if ((fbeCurrentSize + uint16b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b3.verify()) {
            return false
        }
        fbeCurrentSize += uint16b3.fbeSize
        
        if ((fbeCurrentSize + uint16b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b4.verify()) {
            return false
        }
        fbeCurrentSize += uint16b4.fbeSize
        
        if ((fbeCurrentSize + uint16b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint16b5.verify()) {
            return false
        }
        fbeCurrentSize += uint16b5.fbeSize
        
        if ((fbeCurrentSize + int32b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b0.verify()) {
            return false
        }
        fbeCurrentSize += int32b0.fbeSize
        
        if ((fbeCurrentSize + int32b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b1.verify()) {
            return false
        }
        fbeCurrentSize += int32b1.fbeSize
        
        if ((fbeCurrentSize + int32b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b2.verify()) {
            return false
        }
        fbeCurrentSize += int32b2.fbeSize
        
        if ((fbeCurrentSize + int32b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b3.verify()) {
            return false
        }
        fbeCurrentSize += int32b3.fbeSize
        
        if ((fbeCurrentSize + int32b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b4.verify()) {
            return false
        }
        fbeCurrentSize += int32b4.fbeSize
        
        if ((fbeCurrentSize + int32b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int32b5.verify()) {
            return false
        }
        fbeCurrentSize += int32b5.fbeSize
        
        if ((fbeCurrentSize + uint32b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b0.verify()) {
            return false
        }
        fbeCurrentSize += uint32b0.fbeSize
        
        if ((fbeCurrentSize + uint32b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b1.verify()) {
            return false
        }
        fbeCurrentSize += uint32b1.fbeSize
        
        if ((fbeCurrentSize + uint32b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b2.verify()) {
            return false
        }
        fbeCurrentSize += uint32b2.fbeSize
        
        if ((fbeCurrentSize + uint32b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b3.verify()) {
            return false
        }
        fbeCurrentSize += uint32b3.fbeSize
        
        if ((fbeCurrentSize + uint32b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b4.verify()) {
            return false
        }
        fbeCurrentSize += uint32b4.fbeSize
        
        if ((fbeCurrentSize + uint32b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint32b5.verify()) {
            return false
        }
        fbeCurrentSize += uint32b5.fbeSize
        
        if ((fbeCurrentSize + int64b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b0.verify()) {
            return false
        }
        fbeCurrentSize += int64b0.fbeSize
        
        if ((fbeCurrentSize + int64b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b1.verify()) {
            return false
        }
        fbeCurrentSize += int64b1.fbeSize
        
        if ((fbeCurrentSize + int64b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b2.verify()) {
            return false
        }
        fbeCurrentSize += int64b2.fbeSize
        
        if ((fbeCurrentSize + int64b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b3.verify()) {
            return false
        }
        fbeCurrentSize += int64b3.fbeSize
        
        if ((fbeCurrentSize + int64b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b4.verify()) {
            return false
        }
        fbeCurrentSize += int64b4.fbeSize
        
        if ((fbeCurrentSize + int64b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!int64b5.verify()) {
            return false
        }
        fbeCurrentSize += int64b5.fbeSize
        
        if ((fbeCurrentSize + uint64b0.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b0.verify()) {
            return false
        }
        fbeCurrentSize += uint64b0.fbeSize
        
        if ((fbeCurrentSize + uint64b1.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b1.verify()) {
            return false
        }
        fbeCurrentSize += uint64b1.fbeSize
        
        if ((fbeCurrentSize + uint64b2.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b2.verify()) {
            return false
        }
        fbeCurrentSize += uint64b2.fbeSize
        
        if ((fbeCurrentSize + uint64b3.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b3.verify()) {
            return false
        }
        fbeCurrentSize += uint64b3.fbeSize
        
        if ((fbeCurrentSize + uint64b4.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b4.verify()) {
            return false
        }
        fbeCurrentSize += uint64b4.fbeSize
        
        if ((fbeCurrentSize + uint64b5.fbeSize) > fbeStructSize) {
            return true
        }
        
        if (!uint64b5.verify()) {
            return false
        }
        fbeCurrentSize += uint64b5.fbeSize
        
        return true
    }
    
    func getBegin() -> Int {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        assert((fbeStructOffset > 0) && ((_buffer.offset + fbeStructOffset + 4 + 4) <= _buffer.size), "Model is broken!")
        if ((fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size)) {
            return 0
        }
        
        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        assert(fbeStructSize >= (4 + 4), "Model is broken!")
        if (fbeStructSize < (4 + 4)) {
            return 0
        }
        
        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }
    
    func getEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }
    
    func get(fbeValue: Enums = Enums()) -> Enums {
        let fbeBegin = getBegin()
        if (fbeBegin == 0) {
            return fbeValue
        }
        
        let fbeStructSize = Int(readUInt32(offset: 0))
        getFields(fbeValue: fbeValue, fbeStructSize: fbeStructSize)
        getEnd(fbeBegin: fbeBegin)
        return fbeValue
    }
    
    func getFields(fbeValue: Enums, fbeStructSize: Int) {
        var fbeCurrentSize = 4 + 4
        
        if ((fbeCurrentSize + byte0.fbeSize) <= fbeStructSize) {
            fbeValue.byte0 = byte0.get(defaults: EnumByte.ENUM_VALUE_0) }
        else {
            fbeValue.byte0 = EnumByte.ENUM_VALUE_0
        }
        
        fbeCurrentSize += byte0.fbeSize
        
        if ((fbeCurrentSize + byte1.fbeSize) <= fbeStructSize) {
            fbeValue.byte1 = byte1.get(defaults: EnumByte.ENUM_VALUE_1) }
        else {
            fbeValue.byte1 = EnumByte.ENUM_VALUE_1
        }
        
        fbeCurrentSize += byte1.fbeSize
        
        if ((fbeCurrentSize + byte2.fbeSize) <= fbeStructSize) {
            fbeValue.byte2 = byte2.get(defaults: EnumByte.ENUM_VALUE_2)
        } else {
            fbeValue.byte2 = EnumByte.ENUM_VALUE_2
        }
        
        fbeCurrentSize += byte2.fbeSize
        
        if ((fbeCurrentSize + byte3.fbeSize) <= fbeStructSize) {
            fbeValue.byte3 = byte3.get(defaults: EnumByte.ENUM_VALUE_3)
        } else {
            fbeValue.byte3 = EnumByte.ENUM_VALUE_3
        }
        
        fbeCurrentSize += byte3.fbeSize
        
        if ((fbeCurrentSize + byte4.fbeSize) <= fbeStructSize) {
            fbeValue.byte4 = byte4.get(defaults: EnumByte.ENUM_VALUE_4)
        } else {
            fbeValue.byte4 = EnumByte.ENUM_VALUE_4
        }
        
        fbeCurrentSize += byte4.fbeSize
        
        if ((fbeCurrentSize + byte5.fbeSize) <= fbeStructSize) {
            fbeValue.byte5 = byte5.get(defaults: EnumByte.ENUM_VALUE_5)
        } else {
            fbeValue.byte5 = EnumByte.ENUM_VALUE_5
        }
        
        fbeCurrentSize += byte5.fbeSize
        
        if ((fbeCurrentSize + char0.fbeSize) <= fbeStructSize) {
            fbeValue.char0 = char0.get(defaults: EnumChar.ENUM_VALUE_0)
        } else {
            fbeValue.char0 = EnumChar.ENUM_VALUE_0
        }
        
        fbeCurrentSize += char0.fbeSize
        
        if ((fbeCurrentSize + char1.fbeSize) <= fbeStructSize) {
            fbeValue.char1 = char1.get(defaults: EnumChar.ENUM_VALUE_1)
        } else {
            fbeValue.char1 = EnumChar.ENUM_VALUE_1
        }
        
        fbeCurrentSize += char1.fbeSize
        
        if ((fbeCurrentSize + char2.fbeSize) <= fbeStructSize) {
            fbeValue.char2 = char2.get(defaults: EnumChar.ENUM_VALUE_2)
        } else {
            fbeValue.char2 = EnumChar.ENUM_VALUE_2
        }
        
        fbeCurrentSize += char2.fbeSize
        
        if ((fbeCurrentSize + char3.fbeSize) <= fbeStructSize) {
            fbeValue.char3 = char3.get(defaults: EnumChar.ENUM_VALUE_3)
        } else {
            fbeValue.char3 = EnumChar.ENUM_VALUE_3
        }
        
        fbeCurrentSize += char3.fbeSize
        
        if ((fbeCurrentSize + char4.fbeSize) <= fbeStructSize) {
            fbeValue.char4 = char4.get(defaults: EnumChar.ENUM_VALUE_4)
        } else {
            fbeValue.char4 = EnumChar.ENUM_VALUE_4
        }
        
        fbeCurrentSize += char4.fbeSize
        
        if ((fbeCurrentSize + char5.fbeSize) <= fbeStructSize) {
            fbeValue.char5 = char5.get(defaults: EnumChar.ENUM_VALUE_5)
        } else {
            fbeValue.char5 = EnumChar.ENUM_VALUE_5
        }
        
        fbeCurrentSize += char5.fbeSize
        
        if ((fbeCurrentSize + wchar0.fbeSize) <= fbeStructSize) {
            fbeValue.wchar0 = wchar0.get(defaults: EnumWChar.ENUM_VALUE_0)
        } else {
            fbeValue.wchar0 = EnumWChar.ENUM_VALUE_0
        }
        
        fbeCurrentSize += wchar0.fbeSize
        
        if ((fbeCurrentSize + wchar1.fbeSize) <= fbeStructSize) {
            fbeValue.wchar1 = wchar1.get(defaults: EnumWChar.ENUM_VALUE_1)
        } else {
            fbeValue.wchar1 = EnumWChar.ENUM_VALUE_1
        }
        
        fbeCurrentSize += wchar1.fbeSize
        
        if ((fbeCurrentSize + wchar2.fbeSize) <= fbeStructSize) {
            fbeValue.wchar2 = wchar2.get(defaults: EnumWChar.ENUM_VALUE_2)
        } else {
            fbeValue.wchar2 = EnumWChar.ENUM_VALUE_2
        }
        
        fbeCurrentSize += wchar2.fbeSize
        
        if ((fbeCurrentSize + wchar3.fbeSize) <= fbeStructSize) {
            fbeValue.wchar3 = wchar3.get(defaults: EnumWChar.ENUM_VALUE_3)
        } else {
            fbeValue.wchar3 = EnumWChar.ENUM_VALUE_3
        }
        
        fbeCurrentSize += wchar3.fbeSize
        
        if ((fbeCurrentSize + wchar4.fbeSize) <= fbeStructSize) {
            fbeValue.wchar4 = wchar4.get(defaults: EnumWChar.ENUM_VALUE_4)
        } else {
            fbeValue.wchar4 = EnumWChar.ENUM_VALUE_4
        }
        
        fbeCurrentSize += wchar4.fbeSize
        
        if ((fbeCurrentSize + wchar5.fbeSize) <= fbeStructSize) {
            fbeValue.wchar5 = wchar5.get(defaults: EnumWChar.ENUM_VALUE_5)
        } else {
            fbeValue.wchar5 = EnumWChar.ENUM_VALUE_5
        }
        
        fbeCurrentSize += wchar5.fbeSize
        
        if ((fbeCurrentSize + int8b0.fbeSize) <= fbeStructSize) {
            fbeValue.int8b0 = int8b0.get(defaults: EnumInt8.ENUM_VALUE_0)
        } else {
            fbeValue.int8b0 = EnumInt8.ENUM_VALUE_0
        }
        
        fbeCurrentSize += int8b0.fbeSize
        
        if ((fbeCurrentSize + int8b1.fbeSize) <= fbeStructSize) {
            fbeValue.int8b1 = int8b1.get(defaults: EnumInt8.ENUM_VALUE_1)
        } else {
            fbeValue.int8b1 = EnumInt8.ENUM_VALUE_1
        }
        
        fbeCurrentSize += int8b1.fbeSize
        
        if ((fbeCurrentSize + int8b2.fbeSize) <= fbeStructSize) {
            fbeValue.int8b2 = int8b2.get(defaults: EnumInt8.ENUM_VALUE_2)
        } else {
            fbeValue.int8b2 = EnumInt8.ENUM_VALUE_2
        }
        
        fbeCurrentSize += int8b2.fbeSize
        
        if ((fbeCurrentSize + int8b3.fbeSize) <= fbeStructSize) {
            fbeValue.int8b3 = int8b3.get(defaults: EnumInt8.ENUM_VALUE_3)
        } else {
            fbeValue.int8b3 = EnumInt8.ENUM_VALUE_3
        }
        
        fbeCurrentSize += int8b3.fbeSize
        
        if ((fbeCurrentSize + int8b4.fbeSize) <= fbeStructSize) {
            fbeValue.int8b4 = int8b4.get(defaults: EnumInt8.ENUM_VALUE_4)
        } else {
            fbeValue.int8b4 = EnumInt8.ENUM_VALUE_4
        }
        
        fbeCurrentSize += int8b4.fbeSize
        
        if ((fbeCurrentSize + int8b5.fbeSize) <= fbeStructSize) {
            fbeValue.int8b5 = int8b5.get(defaults: EnumInt8.ENUM_VALUE_5)
        } else {
            fbeValue.int8b5 = EnumInt8.ENUM_VALUE_5
        }
        
        fbeCurrentSize += int8b5.fbeSize
        
        if ((fbeCurrentSize + uint8b0.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b0 = uint8b0.get(defaults: EnumUInt8.ENUM_VALUE_0)
        } else {
            fbeValue.uint8b0 = EnumUInt8.ENUM_VALUE_0
        }
        
        fbeCurrentSize += uint8b0.fbeSize
        
        if ((fbeCurrentSize + uint8b1.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b1 = uint8b1.get(defaults: EnumUInt8.ENUM_VALUE_1)
        } else {
            fbeValue.uint8b1 = EnumUInt8.ENUM_VALUE_1
        }
        
        fbeCurrentSize += uint8b1.fbeSize
        
        if ((fbeCurrentSize + uint8b2.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b2 = uint8b2.get(defaults: EnumUInt8.ENUM_VALUE_2)
        } else {
            fbeValue.uint8b2 = EnumUInt8.ENUM_VALUE_2
        }
        
        fbeCurrentSize += uint8b2.fbeSize
        
        if ((fbeCurrentSize + uint8b3.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b3 = uint8b3.get(defaults: EnumUInt8.ENUM_VALUE_3)
        } else {
            fbeValue.uint8b3 = EnumUInt8.ENUM_VALUE_3
        }
        
        fbeCurrentSize += uint8b3.fbeSize
        
        if ((fbeCurrentSize + uint8b4.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b4 = uint8b4.get(defaults: EnumUInt8.ENUM_VALUE_4)
        } else {
            fbeValue.uint8b4 = EnumUInt8.ENUM_VALUE_4
        }
        
        fbeCurrentSize += uint8b4.fbeSize
        
        if ((fbeCurrentSize + uint8b5.fbeSize) <= fbeStructSize) {
            fbeValue.uint8b5 = uint8b5.get(defaults: EnumUInt8.ENUM_VALUE_5)
        } else {
            fbeValue.uint8b5 = EnumUInt8.ENUM_VALUE_5
        }
        
        fbeCurrentSize += uint8b5.fbeSize
        
        if ((fbeCurrentSize + int16b0.fbeSize) <= fbeStructSize) {
            fbeValue.int16b0 = int16b0.get(defaults: EnumInt16.ENUM_VALUE_0)
        } else {
            fbeValue.int16b0 = EnumInt16.ENUM_VALUE_0
        }
        
        fbeCurrentSize += int16b0.fbeSize
        
        if ((fbeCurrentSize + int16b1.fbeSize) <= fbeStructSize) {
            fbeValue.int16b1 = int16b1.get(defaults: EnumInt16.ENUM_VALUE_1)
        } else {
            fbeValue.int16b1 = EnumInt16.ENUM_VALUE_1
        }
        
        fbeCurrentSize += int16b1.fbeSize
        
        if ((fbeCurrentSize + int16b2.fbeSize) <= fbeStructSize) {
            fbeValue.int16b2 = int16b2.get(defaults: EnumInt16.ENUM_VALUE_2)
        } else {
            fbeValue.int16b2 = EnumInt16.ENUM_VALUE_2
        }
        
        fbeCurrentSize += int16b2.fbeSize
        
        if ((fbeCurrentSize + int16b3.fbeSize) <= fbeStructSize) {
            fbeValue.int16b3 = int16b3.get(defaults: EnumInt16.ENUM_VALUE_3)
        } else {
            fbeValue.int16b3 = EnumInt16.ENUM_VALUE_3
        }
        
        fbeCurrentSize += int16b3.fbeSize
        
        if ((fbeCurrentSize + int16b4.fbeSize) <= fbeStructSize) {
            fbeValue.int16b4 = int16b4.get(defaults: EnumInt16.ENUM_VALUE_4)
        } else {
            fbeValue.int16b4 = EnumInt16.ENUM_VALUE_4
        }
        
        fbeCurrentSize += int16b4.fbeSize
        
        if ((fbeCurrentSize + int16b5.fbeSize) <= fbeStructSize) {
            fbeValue.int16b5 = int16b5.get(defaults: EnumInt16.ENUM_VALUE_5)
        } else {
            fbeValue.int16b5 = EnumInt16.ENUM_VALUE_5
        }
        
        fbeCurrentSize += int16b5.fbeSize
        
        if ((fbeCurrentSize + uint16b0.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b0 = uint16b0.get(defaults: EnumUInt16.ENUM_VALUE_0)
        } else {
            fbeValue.uint16b0 = EnumUInt16.ENUM_VALUE_0
        }
        
        fbeCurrentSize += uint16b0.fbeSize
        
        if ((fbeCurrentSize + uint16b1.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b1 = uint16b1.get(defaults: EnumUInt16.ENUM_VALUE_1)
        } else {
            fbeValue.uint16b1 = EnumUInt16.ENUM_VALUE_1
        }
        
        fbeCurrentSize += uint16b1.fbeSize
        
        if ((fbeCurrentSize + uint16b2.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b2 = uint16b2.get(defaults: EnumUInt16.ENUM_VALUE_2)
        } else {
            fbeValue.uint16b2 = EnumUInt16.ENUM_VALUE_2
        }
        
        fbeCurrentSize += uint16b2.fbeSize
        
        if ((fbeCurrentSize + uint16b3.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b3 = uint16b3.get(defaults: EnumUInt16.ENUM_VALUE_3)
        } else {
            fbeValue.uint16b3 = EnumUInt16.ENUM_VALUE_3
        }
        
        fbeCurrentSize += uint16b3.fbeSize
        
        if ((fbeCurrentSize + uint16b4.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b4 = uint16b4.get(defaults: EnumUInt16.ENUM_VALUE_4)
        } else {
            fbeValue.uint16b4 = EnumUInt16.ENUM_VALUE_4
        }
        
        fbeCurrentSize += uint16b4.fbeSize
        
        if ((fbeCurrentSize + uint16b5.fbeSize) <= fbeStructSize) {
            fbeValue.uint16b5 = uint16b5.get(defaults: EnumUInt16.ENUM_VALUE_5)
        } else {
            fbeValue.uint16b5 = EnumUInt16.ENUM_VALUE_5
        }
        
        fbeCurrentSize += uint16b5.fbeSize
        
        if ((fbeCurrentSize + int32b0.fbeSize) <= fbeStructSize) {
            fbeValue.int32b0 = int32b0.get(defaults: EnumInt32.ENUM_VALUE_0)
        } else {
            fbeValue.int32b0 = EnumInt32.ENUM_VALUE_0
        }
        
        fbeCurrentSize += int32b0.fbeSize
        
        if ((fbeCurrentSize + int32b1.fbeSize) <= fbeStructSize) {
            fbeValue.int32b1 = int32b1.get(defaults: EnumInt32.ENUM_VALUE_1)
        } else {
            fbeValue.int32b1 = EnumInt32.ENUM_VALUE_1
        }
        
        fbeCurrentSize += int32b1.fbeSize
        
        if ((fbeCurrentSize + int32b2.fbeSize) <= fbeStructSize) {
            fbeValue.int32b2 = int32b2.get(defaults: EnumInt32.ENUM_VALUE_2)
        } else {
            fbeValue.int32b2 = EnumInt32.ENUM_VALUE_2
        }
        
        fbeCurrentSize += int32b2.fbeSize
        
        if ((fbeCurrentSize + int32b3.fbeSize) <= fbeStructSize) {
            fbeValue.int32b3 = int32b3.get(defaults: EnumInt32.ENUM_VALUE_3)
        } else {
            fbeValue.int32b3 = EnumInt32.ENUM_VALUE_3
        }
        
        fbeCurrentSize += int32b3.fbeSize
        
        if ((fbeCurrentSize + int32b4.fbeSize) <= fbeStructSize) {
            fbeValue.int32b4 = int32b4.get(defaults: EnumInt32.ENUM_VALUE_4)
        } else {
            fbeValue.int32b4 = EnumInt32.ENUM_VALUE_4
        }
        
        fbeCurrentSize += int32b4.fbeSize
        
        if ((fbeCurrentSize + int32b5.fbeSize) <= fbeStructSize) {
            fbeValue.int32b5 = int32b5.get(defaults: EnumInt32.ENUM_VALUE_5)
        } else {
            fbeValue.int32b5 = EnumInt32.ENUM_VALUE_5
        }
        
        fbeCurrentSize += int32b5.fbeSize
        
        if ((fbeCurrentSize + uint32b0.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b0 = uint32b0.get(defaults: EnumUInt32.ENUM_VALUE_0)
        } else {
            fbeValue.uint32b0 = EnumUInt32.ENUM_VALUE_0
        }
        
        fbeCurrentSize += uint32b0.fbeSize
        
        if ((fbeCurrentSize + uint32b1.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b1 = uint32b1.get(defaults: EnumUInt32.ENUM_VALUE_1)
        } else {
            fbeValue.uint32b1 = EnumUInt32.ENUM_VALUE_1
        }
        
        fbeCurrentSize += uint32b1.fbeSize
        
        if ((fbeCurrentSize + uint32b2.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b2 = uint32b2.get(defaults: EnumUInt32.ENUM_VALUE_2)
        } else {
            fbeValue.uint32b2 = EnumUInt32.ENUM_VALUE_2
        }
        
        fbeCurrentSize += uint32b2.fbeSize
        
        if ((fbeCurrentSize + uint32b3.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b3 = uint32b3.get(defaults: EnumUInt32.ENUM_VALUE_3)
        } else {
            fbeValue.uint32b3 = EnumUInt32.ENUM_VALUE_3
        }
        
        fbeCurrentSize += uint32b3.fbeSize
        
        if ((fbeCurrentSize + uint32b4.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b4 = uint32b4.get(defaults: EnumUInt32.ENUM_VALUE_4)
        } else {
            fbeValue.uint32b4 = EnumUInt32.ENUM_VALUE_4
        }
        
        fbeCurrentSize += uint32b4.fbeSize
        
        if ((fbeCurrentSize + uint32b5.fbeSize) <= fbeStructSize) {
            fbeValue.uint32b5 = uint32b5.get(defaults: EnumUInt32.ENUM_VALUE_5)
        } else {
            fbeValue.uint32b5 = EnumUInt32.ENUM_VALUE_5
        }
        
        fbeCurrentSize += uint32b5.fbeSize
        
        if ((fbeCurrentSize + int64b0.fbeSize) <= fbeStructSize) {
            fbeValue.int64b0 = int64b0.get(defaults: EnumInt64.ENUM_VALUE_0)
        } else {
            fbeValue.int64b0 = EnumInt64.ENUM_VALUE_0
        }
        
        fbeCurrentSize += int64b0.fbeSize
        
        if ((fbeCurrentSize + int64b1.fbeSize) <= fbeStructSize) {
            fbeValue.int64b1 = int64b1.get(defaults: EnumInt64.ENUM_VALUE_1)
        } else {
            fbeValue.int64b1 = EnumInt64.ENUM_VALUE_1
        }
        
        fbeCurrentSize += int64b1.fbeSize
        
        if ((fbeCurrentSize + int64b2.fbeSize) <= fbeStructSize) {
            fbeValue.int64b2 = int64b2.get(defaults: EnumInt64.ENUM_VALUE_2)
        } else {
            fbeValue.int64b2 = EnumInt64.ENUM_VALUE_2
        }
        
        fbeCurrentSize += int64b2.fbeSize
        
        if ((fbeCurrentSize + int64b3.fbeSize) <= fbeStructSize) {
            fbeValue.int64b3 = int64b3.get(defaults: EnumInt64.ENUM_VALUE_3)
        } else {
            fbeValue.int64b3 = EnumInt64.ENUM_VALUE_3
        }
        
        fbeCurrentSize += int64b3.fbeSize
        
        if ((fbeCurrentSize + int64b4.fbeSize) <= fbeStructSize) {
            fbeValue.int64b4 = int64b4.get(defaults: EnumInt64.ENUM_VALUE_4)
        } else {
            fbeValue.int64b4 = EnumInt64.ENUM_VALUE_4
        }
        
        fbeCurrentSize += int64b4.fbeSize
        
        if ((fbeCurrentSize + int64b5.fbeSize) <= fbeStructSize) {
            fbeValue.int64b5 = int64b5.get(defaults: EnumInt64.ENUM_VALUE_5)
        } else {
            fbeValue.int64b5 = EnumInt64.ENUM_VALUE_5
        }
        
        fbeCurrentSize += int64b5.fbeSize
        
        if ((fbeCurrentSize + uint64b0.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b0 = uint64b0.get(defaults: EnumUInt64.ENUM_VALUE_0)
        } else {
            fbeValue.uint64b0 = EnumUInt64.ENUM_VALUE_0
        }
        
        fbeCurrentSize += uint64b0.fbeSize
        
        if ((fbeCurrentSize + uint64b1.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b1 = uint64b1.get(defaults: EnumUInt64.ENUM_VALUE_1)
        } else {
            fbeValue.uint64b1 = EnumUInt64.ENUM_VALUE_1
        }
        
        fbeCurrentSize += uint64b1.fbeSize
        
        if ((fbeCurrentSize + uint64b2.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b2 = uint64b2.get(defaults: EnumUInt64.ENUM_VALUE_2)
        } else {
            fbeValue.uint64b2 = EnumUInt64.ENUM_VALUE_2
        }
        
        fbeCurrentSize += uint64b2.fbeSize
        
        if ((fbeCurrentSize + uint64b3.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b3 = uint64b3.get(defaults: EnumUInt64.ENUM_VALUE_3)
        } else {
            fbeValue.uint64b3 = EnumUInt64.ENUM_VALUE_3
        }
        
        fbeCurrentSize += uint64b3.fbeSize
        
        if ((fbeCurrentSize + uint64b4.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b4 = uint64b4.get(defaults: EnumUInt64.ENUM_VALUE_4)
        } else {
            fbeValue.uint64b4 = EnumUInt64.ENUM_VALUE_4
        }
        
        fbeCurrentSize += uint64b4.fbeSize
        
        if ((fbeCurrentSize + uint64b5.fbeSize) <= fbeStructSize) {
            fbeValue.uint64b5 = uint64b5.get(defaults: EnumUInt64.ENUM_VALUE_5)
        } else {
            fbeValue.uint64b5 = EnumUInt64.ENUM_VALUE_5
        }
        
        fbeCurrentSize += uint64b5.fbeSize
    }
    
    func setBegin() throws -> Int {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return 0
        }
        
        let fbeStructSize = fbeBody
        let fbeStructOffset = try _buffer.allocate(size: fbeStructSize) - _buffer.offset
        assert((fbeStructOffset > 0) && ((_buffer.offset + fbeStructOffset + fbeStructSize) <= _buffer.size), "Model is broken!")
        if ((fbeStructOffset <= 0) || ((_buffer.offset + fbeStructOffset + fbeStructSize) > _buffer.size)) {
            return 0
        }
        
        write(offset: fbeOffset, value: UInt32(fbeStructOffset))
        write(offset: fbeStructOffset, value: UInt32(fbeStructSize))
        write(offset: fbeStructOffset + 4, value: UInt32(fbeType))
        
        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }
    
    func setEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }
    
    func set(fbeValue: Enums) throws {
        let fbeBegin = try setBegin()
        if (fbeBegin == 0) {
            return
        }
        
        setFields(fbeValue: fbeValue)
        setEnd(fbeBegin: fbeBegin)
    }
    
    func setFields(fbeValue: Enums) {
        byte0.set(value: fbeValue.byte0)
        byte1.set(value: fbeValue.byte1)
        byte2.set(value: fbeValue.byte2)
        byte3.set(value: fbeValue.byte3)
        byte4.set(value: fbeValue.byte4)
        byte5.set(value: fbeValue.byte5)
        char0.set(value: fbeValue.char0)
        char1.set(value: fbeValue.char1)
        char2.set(value: fbeValue.char2)
        char3.set(value: fbeValue.char3)
        char4.set(value: fbeValue.char4)
        char5.set(value: fbeValue.char5)
        wchar0.set(value: fbeValue.wchar0)
        wchar1.set(value: fbeValue.wchar1)
        wchar2.set(value: fbeValue.wchar2)
        wchar3.set(value: fbeValue.wchar3)
        wchar4.set(value: fbeValue.wchar4)
        wchar5.set(value: fbeValue.wchar5)
        int8b0.set(value: fbeValue.int8b0)
        int8b1.set(value: fbeValue.int8b1)
        int8b2.set(value: fbeValue.int8b2)
        int8b3.set(value: fbeValue.int8b3)
        int8b4.set(value: fbeValue.int8b4)
        int8b5.set(value: fbeValue.int8b5)
        uint8b0.set(value: fbeValue.uint8b0)
        uint8b1.set(value: fbeValue.uint8b1)
        uint8b2.set(value: fbeValue.uint8b2)
        uint8b3.set(value: fbeValue.uint8b3)
        uint8b4.set(value: fbeValue.uint8b4)
        uint8b5.set(value: fbeValue.uint8b5)
        int16b0.set(value: fbeValue.int16b0)
        int16b1.set(value: fbeValue.int16b1)
        int16b2.set(value: fbeValue.int16b2)
        int16b3.set(value: fbeValue.int16b3)
        int16b4.set(value: fbeValue.int16b4)
        int16b5.set(value: fbeValue.int16b5)
        uint16b0.set(value: fbeValue.uint16b0)
        uint16b1.set(value: fbeValue.uint16b1)
        uint16b2.set(value: fbeValue.uint16b2)
        uint16b3.set(value: fbeValue.uint16b3)
        uint16b4.set(value: fbeValue.uint16b4)
        uint16b5.set(value: fbeValue.uint16b5)
        int32b0.set(value: fbeValue.int32b0)
        int32b1.set(value: fbeValue.int32b1)
        int32b2.set(value: fbeValue.int32b2)
        int32b3.set(value: fbeValue.int32b3)
        int32b4.set(value: fbeValue.int32b4)
        int32b5.set(value: fbeValue.int32b5)
        uint32b0.set(value: fbeValue.uint32b0)
        uint32b1.set(value: fbeValue.uint32b1)
        uint32b2.set(value: fbeValue.uint32b2)
        uint32b3.set(value: fbeValue.uint32b3)
        uint32b4.set(value: fbeValue.uint32b4)
        uint32b5.set(value: fbeValue.uint32b5)
        int64b0.set(value: fbeValue.int64b0)
        int64b1.set(value: fbeValue.int64b1)
        int64b2.set(value: fbeValue.int64b2)
        int64b3.set(value: fbeValue.int64b3)
        int64b4.set(value: fbeValue.int64b4)
        int64b5.set(value: fbeValue.int64b5)
        uint64b0.set(value: fbeValue.uint64b0)
        uint64b1.set(value: fbeValue.uint64b1)
        uint64b2.set(value: fbeValue.uint64b2)
        uint64b3.set(value: fbeValue.uint64b3)
        uint64b4.set(value: fbeValue.uint64b4)
        uint64b5.set(value: fbeValue.uint64b5)
    }
}

class FieldModelEnumByte: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumByte = EnumByte()) -> EnumByte {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumByte(value: readByte(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumByte) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumChar: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumChar = EnumChar()) -> EnumChar {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumChar(value: readChar(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumChar) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumInt8: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumInt8 = EnumInt8()) -> EnumInt8 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumInt8(value: readInt8(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt8) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumInt16: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 2
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumInt16 = EnumInt16()) -> EnumInt16 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumInt16(value: readInt16(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt16) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumInt32: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumInt32 = EnumInt32()) -> EnumInt32 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumInt32(value: readInt32(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt32) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumInt64: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 8
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumInt64 = EnumInt64()) -> EnumInt64 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumInt64(value: readInt64(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumInt64) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumUInt8: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 1
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumUInt8 = EnumUInt8()) -> EnumUInt8 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumUInt8(value: readUInt8(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt8) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumUInt16: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 2
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumUInt16 = EnumUInt16()) -> EnumUInt16 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumUInt16(value: readUInt16(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt16) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumUInt32: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumUInt32 = EnumUInt32()) -> EnumUInt32 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumUInt32(value: readUInt32(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt32) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumUInt64: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 8
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumUInt64 = EnumUInt64()) -> EnumUInt64 {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumUInt64(value: readUInt64(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumUInt64) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

class FieldModelEnumWChar: FieldModel {
    
    var _buffer: Buffer = Buffer()
    var _offset: Int = 0
    
    var fbeSize: Int = 4
    
    required init() {
        _buffer = Buffer()
        _offset = 0
    }
    
    // Get the value
    func get(defaults: EnumWChar = EnumWChar()) -> EnumWChar {
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return defaults
        }
        
        return EnumWChar(value: readInt32(offset: fbeOffset))
    }
    
    // Set the value
    func set(value: EnumWChar) {
        assert((_buffer.offset + fbeOffset + fbeSize) <= _buffer.size, "Model is broken!")
        if ((_buffer.offset + fbeOffset + fbeSize) > _buffer.size) {
            return
        }
        
        write(offset: fbeOffset, value: value.raw)
    }
}

