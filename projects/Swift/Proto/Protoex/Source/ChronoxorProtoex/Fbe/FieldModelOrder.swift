//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: protoex.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

import Foundation
import ChronoxorFbe
import ChronoxorProto

// Fast Binary Encoding Order field model
public class FieldModelOrder: FieldModel {

    public var _buffer: Buffer
    public var _offset: Int

    let id: ChronoxorFbe.FieldModelInt32
    let symbol: ChronoxorFbe.FieldModelString
    let side: FieldModelOrderSide
    let type: FieldModelOrderType
    let price: ChronoxorFbe.FieldModelDouble
    let volume: ChronoxorFbe.FieldModelDouble
    let tp: ChronoxorFbe.FieldModelDouble
    let sl: ChronoxorFbe.FieldModelDouble

    // Field size
    public let fbeSize: Int = 4

    // Field body size
    public let fbeBody: Int

    // Set the struct value (end phase)
    public required init() {
        let buffer = Buffer()
        let offset = 0

        _buffer = buffer
        _offset = offset

        id = FieldModelInt32(buffer: buffer, offset: 4 + 4)
        symbol = FieldModelString(buffer: buffer, offset: id.fbeOffset + id.fbeSize)
        side = FieldModelOrderSide(buffer: buffer, offset: symbol.fbeOffset + symbol.fbeSize)
        type = FieldModelOrderType(buffer: buffer, offset: side.fbeOffset + side.fbeSize)
        price = FieldModelDouble(buffer: buffer, offset: type.fbeOffset + type.fbeSize)
        volume = FieldModelDouble(buffer: buffer, offset: price.fbeOffset + price.fbeSize)
        tp = FieldModelDouble(buffer: buffer, offset: volume.fbeOffset + volume.fbeSize)
        sl = FieldModelDouble(buffer: buffer, offset: tp.fbeOffset + tp.fbeSize)

        var fbeBody = (4 + 4)
            fbeBody += id.fbeSize
            fbeBody += symbol.fbeSize
            fbeBody += side.fbeSize
            fbeBody += type.fbeSize
            fbeBody += price.fbeSize
            fbeBody += volume.fbeSize
            fbeBody += tp.fbeSize
            fbeBody += sl.fbeSize
        self.fbeBody = fbeBody
    }

    // 
    public required init(buffer: Buffer = Buffer(), offset: Int = 0) {
        _buffer = buffer
        _offset = offset

        id = FieldModelInt32(buffer: buffer, offset: 4 + 4)
        symbol = FieldModelString(buffer: buffer, offset: id.fbeOffset + id.fbeSize)
        side = FieldModelOrderSide(buffer: buffer, offset: symbol.fbeOffset + symbol.fbeSize)
        type = FieldModelOrderType(buffer: buffer, offset: side.fbeOffset + side.fbeSize)
        price = FieldModelDouble(buffer: buffer, offset: type.fbeOffset + type.fbeSize)
        volume = FieldModelDouble(buffer: buffer, offset: price.fbeOffset + price.fbeSize)
        tp = FieldModelDouble(buffer: buffer, offset: volume.fbeOffset + volume.fbeSize)
        sl = FieldModelDouble(buffer: buffer, offset: tp.fbeOffset + tp.fbeSize)

        var fbeBody = (4 + 4)
            fbeBody += id.fbeSize
            fbeBody += symbol.fbeSize
            fbeBody += side.fbeSize
            fbeBody += type.fbeSize
            fbeBody += price.fbeSize
            fbeBody += volume.fbeSize
            fbeBody += tp.fbeSize
            fbeBody += sl.fbeSize
        self.fbeBody = fbeBody
    }

    // Field extra size
    public var fbeExtra: Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }

        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4) > _buffer.size) {
            return 0
        }

        _buffer.shift(offset: fbeStructOffset)

        var fbeResult = fbeBody
            fbeResult += id.fbeExtra
            fbeResult += symbol.fbeExtra
            fbeResult += side.fbeExtra
            fbeResult += type.fbeExtra
            fbeResult += price.fbeExtra
            fbeResult += volume.fbeExtra
            fbeResult += tp.fbeExtra
            fbeResult += sl.fbeExtra

        _buffer.unshift(offset: fbeStructOffset)

        return fbeResult
    }

    // Field type
    public var fbeType: Int = fbeTypeConst
    public static let fbeTypeConst: Int = 1

    // Check if the struct value is valid
    func verify(fbeVerifyType: Bool = true) -> Bool {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            return true
        }

        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size) {
            return false
        }

        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        if fbeStructSize < (4 + 4) {
            return false
        }

        let fbeStructType = Int(readUInt32(offset: fbeStructOffset + 4))
        if fbeVerifyType && (fbeStructType != fbeType) {
            return false
        }

        _buffer.shift(offset: fbeStructOffset)
        let fbeResult = verifyFields(fbeStructSize: fbeStructSize)
        _buffer.unshift(offset: fbeStructOffset)
        return fbeResult
    }

    // Check if the struct fields are valid
    public func verifyFields(fbeStructSize: Int) -> Bool {
        var fbeCurrentSize = 4 + 4

        if (fbeCurrentSize + id.fbeSize) > fbeStructSize {
            return true
        }
        if !id.verify() {
            return false
        }
        fbeCurrentSize += id.fbeSize

        if (fbeCurrentSize + symbol.fbeSize) > fbeStructSize {
            return true
        }
        if !symbol.verify() {
            return false
        }
        fbeCurrentSize += symbol.fbeSize

        if (fbeCurrentSize + side.fbeSize) > fbeStructSize {
            return true
        }
        if !side.verify() {
            return false
        }
        fbeCurrentSize += side.fbeSize

        if (fbeCurrentSize + type.fbeSize) > fbeStructSize {
            return true
        }
        if !type.verify() {
            return false
        }
        fbeCurrentSize += type.fbeSize

        if (fbeCurrentSize + price.fbeSize) > fbeStructSize {
            return true
        }
        if !price.verify() {
            return false
        }
        fbeCurrentSize += price.fbeSize

        if (fbeCurrentSize + volume.fbeSize) > fbeStructSize {
            return true
        }
        if !volume.verify() {
            return false
        }
        fbeCurrentSize += volume.fbeSize

        if (fbeCurrentSize + tp.fbeSize) > fbeStructSize {
            return true
        }
        if !tp.verify() {
            return false
        }
        fbeCurrentSize += tp.fbeSize

        if (fbeCurrentSize + sl.fbeSize) > fbeStructSize {
            return true
        }
        if !sl.verify() {
            return false
        }
        fbeCurrentSize += sl.fbeSize

        return true
    }

    // Get the struct value (begin phase)
    func getBegin() -> Int {
        if _buffer.offset + fbeOffset + fbeSize > _buffer.size {
            return 0
        }

        let fbeStructOffset = Int(readUInt32(offset: fbeOffset))
        if (fbeStructOffset == 0) || ((_buffer.offset + fbeStructOffset + 4 + 4) > _buffer.size) {
            assertionFailure("Model is broken!")
            return 0
        }

        let fbeStructSize = Int(readUInt32(offset: fbeStructOffset))
        if fbeStructSize < 4 + 4 {
            assertionFailure("Model is broken!")
            return 0
        }

        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }

    // Get the struct value (end phase)
    func getEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }

    // Get the struct value
    public func get() -> Order {
        var fbeValue = Order()
        return get(fbeValue: &fbeValue)
    }

    public func get(fbeValue: inout Order) -> Order {
        let fbeBegin = getBegin()
        if fbeBegin == 0 {
            return fbeValue
        }

        let fbeStructSize = Int(readUInt32(offset: 0))
        getFields(fbeValue: &fbeValue, fbeStructSize: fbeStructSize)
        getEnd(fbeBegin: fbeBegin)
        return fbeValue
    }

    // Get the struct fields values
    public func getFields(fbeValue: inout Order, fbeStructSize: Int) {
        var fbeCurrentSize = 4 + 4

        if fbeCurrentSize + id.fbeSize <= fbeStructSize {
            fbeValue.id = id.get()
        } else {
            fbeValue.id = 0
        }
        fbeCurrentSize += id.fbeSize

        if fbeCurrentSize + symbol.fbeSize <= fbeStructSize {
            fbeValue.symbol = symbol.get()
        } else {
            fbeValue.symbol = ""
        }
        fbeCurrentSize += symbol.fbeSize

        if fbeCurrentSize + side.fbeSize <= fbeStructSize {
            fbeValue.side = side.get()
        } else {
            fbeValue.side = ChronoxorProtoex.OrderSide()
        }
        fbeCurrentSize += side.fbeSize

        if fbeCurrentSize + type.fbeSize <= fbeStructSize {
            fbeValue.type = type.get()
        } else {
            fbeValue.type = ChronoxorProtoex.OrderType()
        }
        fbeCurrentSize += type.fbeSize

        if fbeCurrentSize + price.fbeSize <= fbeStructSize {
            fbeValue.price = price.get(defaults: 0.0)
        } else {
            fbeValue.price = 0.0
        }
        fbeCurrentSize += price.fbeSize

        if fbeCurrentSize + volume.fbeSize <= fbeStructSize {
            fbeValue.volume = volume.get(defaults: 0.0)
        } else {
            fbeValue.volume = 0.0
        }
        fbeCurrentSize += volume.fbeSize

        if fbeCurrentSize + tp.fbeSize <= fbeStructSize {
            fbeValue.tp = tp.get(defaults: 10.0)
        } else {
            fbeValue.tp = 10.0
        }
        fbeCurrentSize += tp.fbeSize

        if fbeCurrentSize + sl.fbeSize <= fbeStructSize {
            fbeValue.sl = sl.get(defaults: -10.0)
        } else {
            fbeValue.sl = -10.0
        }
        fbeCurrentSize += sl.fbeSize
    }

    // Set the struct value (begin phase)
    func setBegin() throws -> Int {
        if (_buffer.offset + fbeOffset + fbeSize) > _buffer.size {
            assertionFailure("Model is broken!")
            return 0
        }

        let fbeStructSize = fbeBody
        let fbeStructOffset = try _buffer.allocate(size: fbeStructSize) - _buffer.offset
        if (fbeStructOffset <= 0) || ((_buffer.offset + fbeStructOffset + fbeStructSize) > _buffer.size) {
            assertionFailure("Model is broken!")
            return 0
        }

        write(offset: fbeOffset, value: UInt32(fbeStructOffset))
        write(offset: fbeStructOffset, value: UInt32(fbeStructSize))
        write(offset: fbeStructOffset + 4, value: UInt32(fbeType))

        _buffer.shift(offset: fbeStructOffset)
        return fbeStructOffset
    }

    // Set the struct value (end phase)
    public func setEnd(fbeBegin: Int) {
        _buffer.unshift(offset: fbeBegin)
    }

    // Set the struct value
    public func set(value fbeValue: Order) throws {
        let fbeBegin = try setBegin()
        if fbeBegin == 0 {
            return
        }

        try setFields(fbeValue: fbeValue)
        setEnd(fbeBegin: fbeBegin)
    }

    // Set the struct fields values
    public func setFields(fbeValue: Order) throws {
        try id.set(value: fbeValue.id)
        try symbol.set(value: fbeValue.symbol)
        try side.set(value: fbeValue.side)
        try type.set(value: fbeValue.type)
        try price.set(value: fbeValue.price)
        try volume.set(value: fbeValue.volume)
        try tp.set(value: fbeValue.tp)
        try sl.set(value: fbeValue.sl)
    }
}
