//
//  Model.swift
//  fbe-example
//
//  Created by Andrey on 8/2/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Model {
    
    // Get bytes buffer
    private(set) var buffer: Buffer
    
    // Initialize a new model
    init(buffer: Buffer = Buffer()) {
        self.buffer = buffer
    }
    
    // Attach memory buffer methods
    func attach() { buffer.attach() }
    func attach(capacity: Int) { buffer.attach(capacity: capacity) }
    func attach(buffer: Data) { self.buffer.attach(buffer: buffer) }
    func attach(buffer: Data, offset: Int) { self.buffer.attach(buffer: buffer, offset: offset) }
    func attach(buffer: Data, size: Int, offset: Int) { self.buffer.attach(buffer: buffer, size: size, offset: offset) }
    func attach(buffer: Buffer) { self.buffer.attach(buffer: buffer.data, size: buffer.size, offset: buffer.offset) }
    func attach(buffer: Buffer, offset: Int) { self.buffer.attach(buffer: buffer.data, size: buffer.size, offset: offset) }

    // Model buffer operations
    func allocate(size: Int) throws -> Int { return try buffer.allocate(size: size) }
    func remove(offset: Int, size: Int) throws { try buffer.remove(offset: offset, size: size) }
    func reserve(capacity: Int) throws { try buffer.reserve(capacity: capacity) }
    func resize(size: Int) throws{ try buffer.resize(size: size) }
    func reset() { buffer.reset() }
    func shift(offset: Int) { buffer.shift(offset: offset) }
    func unshift(offset: Int) { buffer.unshift(offset: offset) }

    // Buffer I/O methods
    func readUInt32(offset: Int) -> UInt { return UInt(Buffer.readUInt32(buffer: buffer.data, offset: buffer.offset + offset)) }
    func write(offset: Int, value: UInt32) { Buffer.write(buffer: &buffer.data, offset: buffer.offset + offset, value: value) }
}
