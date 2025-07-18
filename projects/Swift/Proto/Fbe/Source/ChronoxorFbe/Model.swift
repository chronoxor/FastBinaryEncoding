//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: FBE
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

import Foundation

// Fast Binary Encoding base model
open class Model {

    // Get bytes buffer
    public private(set) var buffer: Buffer

    // Initialize a new model
    public init(buffer: Buffer = Buffer()) {
        self.buffer = buffer
    }

    // Attach memory buffer methods
    public func attach() { buffer.attach() }
    public func attach(capacity: Int) { buffer.attach(capacity: capacity) }
    public func attach(buffer: Data) { self.buffer.attach(buffer: buffer) }
    public func attach(buffer: Data, offset: Int) { self.buffer.attach(buffer: buffer, offset: offset) }
    public func attach(buffer: Data, size: Int, offset: Int) { self.buffer.attach(buffer: buffer, size: size, offset: offset) }
    public func attach(buffer: Buffer) { self.buffer.attach(buffer: buffer.data, size: buffer.size, offset: buffer.offset) }
    public func attach(buxffer: Buffer, offset: Int) { self.buffer.attach(buffer: buffer.data, size: buffer.size, offset: offset) }

    // Model buffer operations
    public func allocate(size: Int) throws -> Int { return try buffer.allocate(size: size) }
    public func remove(offset: Int, size: Int) throws { try buffer.remove(offset: offset, size: size) }
    public func reserve(capacity: Int) throws { try buffer.reserve(capacity: capacity) }
    public func resize(size: Int) throws { try buffer.resize(size: size) }
    public func reset() { buffer.reset() }
    public func shift(offset: Int) { buffer.shift(offset: offset) }
    public func unshift(offset: Int) { buffer.unshift(offset: offset) }

    // Buffer I/O methods
    public func readUInt32(offset: Int) -> UInt { return UInt(Buffer.readUInt32(buffer: buffer, offset: buffer.offset + offset)) }
    public func write(offset: Int, value: UInt32) { Buffer.write(buffer: &buffer, offset: buffer.offset + offset, value: value) }
}
