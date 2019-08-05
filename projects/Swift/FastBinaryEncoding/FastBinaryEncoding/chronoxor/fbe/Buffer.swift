//
//  Buffer.swift
//  fbe-example
//
//  Created by Andrey on 8/1/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation


// Fast Binary Encoding buffer based on dynamic byte array
class Buffer {
    
    // Is the buffer empty?
    var empty: Bool {
        return size == 0
    }
    // Get bytes memory buffer
    /* private(set) */ var data = Data()
    // Get bytes memory buffer capacity
    var capacity: Int {
        return data.count
    }
    // Get bytes memory buffer size
    private(set) var size: Int = 0
    // Get bytes memory buffer offset
    private(set) var offset: Int = 0
    
    // Initialize a new expandable buffer with zero capacity
    init() {}
    // Initialize a new expandable buffer with the given capacity
    init(capacity: Int) { attach(capacity: capacity) }
    // Initialize a new buffer based on the specified byte array
    init(buffer: Data) { attach(buffer: buffer) }
    // Initialize a new buffer based on the specified region (offset) of a byte array
    init(buffer: Data, offset: Int) { attach(buffer: buffer, offset: offset) }
    // Initialize a new buffer based on the specified region (size and offset) of a byte array
    init(buffer: Data, size: Int, offset: Int) { attach(buffer: buffer, size: size, offset: offset) }
    
    func attach() {
        data = Data(capacity: 0)
        size = 0
        offset = 0
    }
    
    // Attach memory buffer methods
    func attach(capacity: Int) {
        data = Data(capacity: capacity)
        size = 0
        offset = 0
    }
    
    func attach(buffer: Data) {
        data = buffer
        size = buffer.count
        offset = 0
    }
    
    func attach(buffer: Data, offset: Int) {
        data = buffer
        size = buffer.count
        self.offset = offset
    }
    
    func attach(buffer: Data, size: Int, offset: Int) {
        data = buffer
        self.size = size
        self.offset = offset
    }
    
    // Allocate memory in the current buffer and return offset to the allocated memory block
    func allocate(size: Int) throws -> Int {
        assert(size >= 0)
        
        if size < 0 {
            throw NSException(name: .invalidArgumentException, reason: "Invalid allocation size!") as! Error
        }
        
        let offset = self.size
        
        // Calculate a new buffer size
        let total = self.size + size
        
        if total <= data.count {
            self.size = total
            return offset
        }
        
        var data = Data(count: max(total, 2 * self.size))
        data.insert(contentsOf: self.data, at: 0)
        //data[0...] = self.data[0...self.size]
        self.data = data
        self.size = total
        
        return offset
    }
    
    // Remove some memory of the given size from the current buffer
    func remove(offset: Int, size: Int) throws {
        assert(offset + size <= self.size)
        if (offset + size > self.size) {
            throw NSException(name: .invalidArgumentException, reason: "Invalid offset & size!") as! Error
        }
        if (size != 0) {
            data[offset...] = data[(offset + size)...(self.size - size - offset)]
        }
        self.size -= size
        if (self.offset >= offset + size) {
            self.offset -= size
        } else if self.offset >= offset {
            self.offset -= self.offset - offset
            if (self.offset > self.size) {
                self.offset = self.size
            }
        }
    }
    
    // Reserve memory of the given capacity in the current buffer
    func reserve(capacity: Int) throws {
        assert(capacity >= 0, "Invalid reserve capacity!")
        if capacity < 0 {
            throw NSException(name: .invalidArgumentException, reason: "Invalid reserve capacity!") as! Error
        }

        if (capacity > data.count) {
            var data = Data(capacity: max(capacity, 2 * self.data.count))
            data[0...] = self.data[0...]
            self.data = data
        }
    }
    
    // Resize the current buffer
    func resize(size: Int) throws {
        try reserve(capacity: size)
        
        self.size = size
        
        if offset > self.size {
            offset = self.size
        }
    }

    
    // Reset the current buffer and its offset
    func reset() {
        size = 0
        offset = 0
    }
    
    // Shift the current buffer offset
    func shift(offset: Int) { self.offset += offset }
    // Unshift the current buffer offset
    func unshift(offset: Int) { self.offset -= offset }
}

// MARK: Buffer I/O methods
extension Buffer {
    class func readBoolean(buffer: Data, offset: Int) -> Bool {
        let index = offset
        return buffer[index] != 0
    }
    
    class func readByte(buffer: Data, offset: Int) -> Data.Element {
        let index = offset
        return buffer[index]
    }
    
    class func readChar(buffer: Data, offset: Int) -> CChar {
        return Buffer.readInt8(buffer: buffer, offset: offset)
    }

    class func readWChar(buffer: Data, offset: Int) -> CChar {
        return CChar(Buffer.readInt32(buffer: buffer, offset: offset))
    }
    
    class func readInt8(buffer: Data, offset: Int) -> Int8 {
        let index = offset
        return Int8(buffer[index])
    }
    
    class func readUInt8(buffer: Data, offset: Int) -> UInt8 {
        let index = offset
        return buffer[index]
    }
    
    class func readInt16(buffer: Data, offset: Int) -> Int16 {
        let index = offset
        return Int16(((buffer[index + 0] & 0xFF) << 0) |
                     ((buffer[index + 1] & 0xFF) << 8))
    }
    
    class func readUInt16(buffer: Data, offset: Int) -> UInt16 {
        let index = offset
        return UInt16(((UInt16(buffer[index + 0]) & UInt16(0xFF)) << 0) |
                      ((UInt16(buffer[index + 1]) & UInt16(0xFF)) << 8))
    }
    
    class func readInt32(buffer: Data, offset: Int) -> Int32 {
        let index = offset
        return Int32(((Int32(buffer[index + 0]) & 0xFF) <<  0) |
                     ((Int32(buffer[index + 1]) & 0xFF) <<  8) |
                     ((Int32(buffer[index + 2]) & 0xFF) << 16) |
                     ((Int32(buffer[index + 3]) & 0xFF) << 24))
    }
    
    class func readUInt32(buffer: Data, offset: Int) -> UInt32 {
        let index = offset
        let firstPart = ((UInt32(buffer[index + 0]) & UInt32(0xFF)) <<  0) |
                        ((UInt32(buffer[index + 1]) & UInt32(0xFF)) <<  8)
        
        let secondPart = ((UInt32(buffer[index + 2]) & UInt32(0xFF)) <<  16) |
                         ((UInt32(buffer[index + 3]) & UInt32(0xFF)) << 32)
        return UInt32(firstPart | secondPart)
    }
    
    class func readInt64(buffer: Data, offset: Int) -> Int64 {
        let index = offset
        let fPart = ((Int64(buffer[index + 0]) & 0xFF) <<  0) |
                    ((Int64(buffer[index + 1]) & 0xFF) <<  8) |
                    ((Int64(buffer[index + 2]) & 0xFF) <<  16)
        
        let sPart = ((Int64(buffer[index + 3]) & 0xFF) <<  24) |
                    ((Int64(buffer[index + 4]) & 0xFF) <<  32) |
                    ((Int64(buffer[index + 5]) & 0xFF) <<  40)
        
        let tPart = ((Int64(buffer[index + 6]) & 0xFF) <<  48) |
                    ((Int64(buffer[index + 7]) & 0xFF) <<  56)
        
        return Int64(fPart | sPart | tPart)
    }

    class func readUInt64(buffer: Data, offset: Int) -> UInt64 {
        let index = offset
        let fPart = ((UInt64(buffer[index + 0]) & UInt64(0xFF)) <<  0) |
                    ((UInt64(buffer[index + 1]) & UInt64(0xFF)) <<  8) |
                    ((UInt64(buffer[index + 2]) & UInt64(0xFF)) <<  16)
    
        let sPart = ((UInt64(buffer[index + 3]) & UInt64(0xFF)) <<  24) |
                    ((UInt64(buffer[index + 4]) & UInt64(0xFF)) <<  32) |
                    ((UInt64(buffer[index + 5]) & UInt64(0xFF)) <<  40)
    
        let tPart = ((UInt64(buffer[index + 6]) & UInt64(0xFF)) <<  48) |
                    ((UInt64(buffer[index + 7]) & UInt64(0xFF)) <<  56)
    
        return UInt64(fPart | sPart | tPart)
    }

    class func readInt64BE(buffer: Data, offset: Int) -> UInt64 {
        let index = offset
        let fPart = ((UInt64(buffer[index + 0]) & UInt64(0xFF)) << 56) |
                    ((UInt64(buffer[index + 1]) & UInt64(0xFF)) << 48) |
                    ((UInt64(buffer[index + 2]) & UInt64(0xFF)) << 40)
        
        let sPart = ((UInt64(buffer[index + 3]) & UInt64(0xFF)) << 38) |
                    ((UInt64(buffer[index + 4]) & UInt64(0xFF)) << 24) |
                    ((UInt64(buffer[index + 5]) & UInt64(0xFF)) << 16)
        
        let tPart = ((UInt64(buffer[index + 6]) & UInt64(0xFF)) <<  8) |
                    ((UInt64(buffer[index + 7]) & UInt64(0xFF)) <<  0)
        
        return UInt64(fPart | sPart | tPart)
    }
    
    class func readFloat(buffer: Data, offset: Int) -> Float {
        let bits = readUInt32(buffer: buffer, offset: offset)
        return Float(bitPattern: bits)
    }
    
    class func readDouble(buffer: Data, offset: Int) -> Double {
        let bits = readUInt64(buffer: buffer, offset: offset)
        return Double(bitPattern: bits)
    }
    
    class func readBytes(buffer: Data, offset: Int, size: Int) -> Data {
        var result = Data(capacity: size)
        result[0...] = buffer[offset...size]
        return result
    }
    
    class func readString(buffer: Data, offset: Int, size: Int) -> String {
        return String(bytes: buffer, encoding:.utf8) ?? "??"
    }
    
    class func readUUID(buffer: Data, offset: Int) -> UUID {
        return UUID(uuidString: String(bytes: buffer, encoding:.utf8) ?? "??")!
    }
    
    class func write(buffer: inout Data, offset: Int, value: Bool) {
        buffer[offset] = value ? 1 : 0
    }
    
    class func write(buffer: inout Data, offset: Int, value: Int8) {
        buffer[offset] = UInt8(value)
    }
    
    class func write(buffer: inout Data, offset: Int, value: Data.Element) {
        buffer[offset] = value
    }
    
    class func write(buffer: inout Data, offset: Int, value: Int16) {
        buffer[offset + 0] = Data.Element(value >> 0)
        buffer[offset + 1] = Data.Element(value >> 8)
    }
    
    class func write(buffer: inout Data, offset: Int, value: UInt16) {
        buffer[offset + 0] = Data.Element(value >> 0)
        buffer[offset + 1] = Data.Element(value >> 8)
    }
    
    class func write(buffer: inout Data, offset: Int, value: Int32) {
        buffer[offset + 0] = Data.Element(value >> 0)
        buffer[offset + 1] = Data.Element(value >>  8)
        buffer[offset + 2] = Data.Element(value >> 16)
        buffer[offset + 3] = Data.Element(value >> 24)
    }
    
    class func write(buffer: inout Data, offset: Int, value: UInt32) {
        buffer[offset + 0] = Data.Element(truncating: NSNumber(value: value >>  0))
        buffer[offset + 1] = Data.Element(truncating: NSNumber(value: value >>  8))
        buffer[offset + 2] = Data.Element(truncating: NSNumber(value: value >> 16))
        buffer[offset + 3] = Data.Element(truncating: NSNumber(value: value >> 24))
    }
    
    class func write(buffer: inout Data, offset: Int, value: Int64) {
        buffer[offset + 0] = Data.Element(value >> 0)
        buffer[offset + 1] = Data.Element(value >>  8)
        buffer[offset + 2] = Data.Element(value >> 16)
        buffer[offset + 3] = Data.Element(value >> 24)
        buffer[offset + 4] = Data.Element(value >> 32)
        buffer[offset + 5] = Data.Element(value >> 40)
        buffer[offset + 6] = Data.Element(value >> 48)
        buffer[offset + 7] = Data.Element(value >> 56)
    }
    
    class func write(buffer: inout Data, offset: Int, value: UInt64) {
        buffer[offset + 0] = Data.Element(truncating: NSNumber(value: value >>  0))
        buffer[offset + 1] = Data.Element(truncating: NSNumber(value: value >>  8))
        buffer[offset + 2] = Data.Element(truncating: NSNumber(value: value >> 16))
        buffer[offset + 3] = Data.Element(truncating: NSNumber(value: value >> 24))
        buffer[offset + 4] = Data.Element(truncating: NSNumber(value: value >> 32))
        buffer[offset + 5] = Data.Element(truncating: NSNumber(value: value >> 40))
        buffer[offset + 6] = Data.Element(truncating: NSNumber(value: value >> 48))
        buffer[offset + 7] = Data.Element(truncating: NSNumber(value: value >> 56))
    }
    
    private class func writeBE(buffer: inout Data, offset: Int, value: UInt64) {
        buffer[offset + 0] = Data.Element(value >> 56)
        buffer[offset + 1] = Data.Element(value >> 48)
        buffer[offset + 2] = Data.Element(value >> 40)
        buffer[offset + 3] = Data.Element(value >> 32)
        buffer[offset + 4] = Data.Element(value >> 24)
        buffer[offset + 5] = Data.Element(value >> 16)
        buffer[offset + 6] = Data.Element(value >>  8)
        buffer[offset + 7] = Data.Element(value >>  0)
    }
    
    class func write(buffer: inout Data, offset: Int, value: Float) {
        let bits = value.bitPattern
        Buffer.write(buffer: &buffer, offset: offset, value: bits)
    }
    
    class func write(buffer: inout Data, offset: Int, value: Double) {
        let bits = value.bitPattern
        Buffer.write(buffer: &buffer, offset: offset, value: bits)
    }
    
    class func write(buffer: inout Data, offset: Int, value: Data) {
        buffer[offset...] = value[0...value.count - 1]
    }

    class func write(buffer: inout Data, offset: Int, value: Data, valueOffset: Int, valueSize: Int) {
        buffer[offset...] = value[valueOffset...valueSize]
    }
    
    class func write(buffer: inout Data, offset: Int, value: Data.Element, valueCount: Int) {
        for i in 0...valueCount {
            buffer[offset + i] = value
        }
    }
    
    class func write(buffer: inout Data, offset: Int, value: UUID) {
        //Buffer.writeBE(buffer: &buffer, offset: offset, value: value.uuidString)
    }
}
