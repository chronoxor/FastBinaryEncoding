//
//  TestDecimal.swift
//

import XCTest
import ChronoxorFbe
import ChronoxorProto

class TestDecimal: XCTestCase {
    func testDecimal() {
        XCTAssertEqual(verifyDecimal(low: 0x00000000, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000), Decimal.zero)
        XCTAssertEqual(verifyDecimal(low: 0x00000001, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000), Decimal(integerLiteral: 1))
        XCTAssertEqual(verifyDecimal(low: 0x107A4000, mid: 0x00005AF3, high: 0x00000000, negative: false, scale: 0x00000000), Decimal(string: "100000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x000E0000 >> 16)), Decimal(string: "100000000000000.00000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x00000000)), Decimal(string: "10000000000000000000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x001C0000 >> 16)), Decimal(string: "1.0000000000000000000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00000000)), Decimal(string: "123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00090000 >> 16)), Decimal(string: "0.123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00120000 >> 16)), Decimal(string: "0.000000000123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x001B0000 >> 16)), Decimal(string: "0.000000000000000000123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00000000)), Decimal(string: "4294967295")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0x00000000, negative: false, scale: UInt8(0x00000000)), Decimal(string: "18446744073709551615")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: false, scale: UInt8(0x00000000)), Decimal(string: "79228162514264337593543950335")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: true, scale: UInt8(0x00000000)), Decimal(string: "-79228162514264337593543950335")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: true, scale: UInt8(0x001C0000 >> 16)), Decimal(string: "-7.9228162514264337593543950335")!)
    }

    func verifyDecimal(low: UInt32, mid: UInt32, high: UInt32, negative: Bool, scale: UInt8) -> Decimal {
        let flags = negative ? ((UInt32(scale) << 16) | 0x80000000) : (UInt32(scale) << 16)

        let data = Data(count: 16)
        var buffer = Buffer(buffer: data)

        Buffer.write(buffer: &buffer, offset: 0, value: low)
        Buffer.write(buffer: &buffer, offset: 4, value: mid)
        Buffer.write(buffer: &buffer, offset: 8, value: high)
        Buffer.write(buffer: &buffer, offset: 12, value: flags)

        let model = FieldModelDecimal(buffer: buffer, offset: 0)
        let value1 = model.get()

        try! model.set(value: value1)
        if (Buffer.readUInt32(buffer: buffer, offset: 0) != low) ||
            (Buffer.readUInt32(buffer: buffer, offset: 4) != mid) ||
            (Buffer.readUInt32(buffer: buffer, offset: 8) != high) ||
            (Buffer.readUInt32(buffer: buffer, offset: 12) != flags) {
            return Decimal.nan
        }

        let finalModel = FinalModelDecimal(buffer: buffer, offset: 0)
        var size = Size()
        let value2 = finalModel.get(size: &size)
        _ = try! finalModel.set(value: value2)
        if
            (Buffer.readUInt32(buffer: buffer, offset: 0) != low) ||
            (Buffer.readUInt32(buffer: buffer, offset: 4) != mid) ||
            (Buffer.readUInt32(buffer: buffer, offset: 8) != high) ||
            (Buffer.readUInt32(buffer: buffer, offset: 12) != flags) ||
            (size.value != 16) || value1 != value2 {
            return Decimal.nan
        }

        return value2
    }
}
