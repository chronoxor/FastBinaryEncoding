// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: Fbe
// Version: 1.3.0.0

import Foundation

// Fast Binary Encoding Int64 field model
public class FieldModelInt64: FieldModel {
    public var _buffer = Buffer()
    public var _offset: Int = 0

    // Field size
    public let fbeSize: Int = 8

    public required init() {
        _buffer = Buffer()
        _offset = 0
    }

    public required init(buffer: Buffer, offset: Int) {
        _buffer = buffer
        _offset = offset
    }

    // Get the value
    public func get(defaults: Int64 = 0) -> Int64 {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return defaults
        }

        return readInt64(offset: fbeOffset)
    }

    // Set the value
    public func set(value: Int64) throws {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            assertionFailure("Model is broken!")
            return
        }

        write(offset: fbeOffset, value: value)
    }
}
