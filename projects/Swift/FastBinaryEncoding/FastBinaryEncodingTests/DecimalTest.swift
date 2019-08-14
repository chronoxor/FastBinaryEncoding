//
//  DecimalTest.swift
//  FastBinaryEncodingTests
//
//  Created by Andrey on 8/12/19.
//  Copyright © 2019 Andrey. All rights reserved.
//

import XCTest
import proto
import fbe

class DecimalTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecimal() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(verifyDecimal(low: 0x00000000, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000, espected: Decimal.zero), Decimal.zero)
        XCTAssertEqual(verifyDecimal(low: 0x00000001, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000, espected: Decimal(integerLiteral: 1)), Decimal(integerLiteral: 1))
        XCTAssertEqual(verifyDecimal(low: 0x107A4000, mid: 0x00005AF3, high: 0x00000000, negative: false, scale: 0x00000000, espected: Decimal(integerLiteral: 100000000000000)), Decimal(integerLiteral: 100000000000000))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x000E0000 >> 16), espected: Decimal(string: "100000000000000.00000000000000")!), Decimal(string: "100000000000000.00000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x00000000), espected: Decimal(string: "10000000000000000000000000000")!), Decimal(string: "10000000000000000000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x001C0000 >> 16), espected: Decimal(string: "1.0000000000000000000000000000")!), Decimal(string: "1.0000000000000000000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00000000), espected: Decimal(string: "123456789")!), Decimal(string: "123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00090000 >> 16), espected: Decimal(string: "0.123456789")!), Decimal(string: "0.123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00120000 >> 16), espected: Decimal(string: "0.000000000123456789")!), Decimal(string: "0.000000000123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0x075BCD15, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x001B0000 >> 16), espected: Decimal(string: "0.000000000000000000123456789")!), Decimal(string: "0.000000000000000000123456789")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0x00000000, high: 0x00000000, negative: false, scale: UInt8(0x00000000), espected: Decimal(string: "4294967295")!), Decimal(string: "4294967295")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0x00000000, negative: false, scale: UInt8(0x00000000), espected: Decimal(string: "18446744073709551615")!), Decimal(string: "18446744073709551615")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: false, scale: UInt8(0x00000000), espected: Decimal(string: "79228162514264337593543950335")!), Decimal(string: "79228162514264337593543950335")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: true, scale: UInt8(0x00000000), espected: Decimal(string: "-79228162514264337593543950335")!), Decimal(string: "-79228162514264337593543950335")!)
        XCTAssertEqual(verifyDecimal(low: 0xFFFFFFFF, mid: 0xFFFFFFFF, high: 0xFFFFFFFF, negative: true, scale: UInt8(0x001C0000 >> 16), espected: Decimal(string: "-7.9228162514264337593543950335")!), Decimal(string: "-7.9228162514264337593543950335")!)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func verifyDecimal(low: UInt32, mid: UInt32, high: UInt32, negative: Bool, scale: UInt8, espected: Decimal) -> Decimal {
        let flags = negative ? ((UInt32(scale) << 16) | 0x80000000) : (UInt32(scale) << 16)

        var buffer = Data(count: 16)
        
        Buffer.write(buffer: &buffer, offset: 0, value: low)
        Buffer.write(buffer: &buffer, offset: 4, value: mid)
        Buffer.write(buffer: &buffer, offset: 8, value: high)
        Buffer.write(buffer: &buffer, offset: 12, value: flags)

        let model = FieldModelDecimal(buffer: Buffer(buffer: buffer), offset: 0)
        var value1 = model.get()

        model.set(value: espected)
        model.set(value: model.get())

        model.set(value: espected)
        if (Buffer.readUInt32(buffer: buffer, offset: 0) != low) ||
            (Buffer.readUInt32(buffer: buffer, offset: 4) != mid) ||
            (Buffer.readUInt32(buffer: buffer, offset: 8) != high) ||
            (Buffer.readUInt32(buffer: buffer, offset: 12) != flags) {
            return Decimal.nan
        }
        
        value1 = model.get()


        let finalModel = FinalModelDecimal(buffer: Buffer(buffer: buffer), offset: 0)
        var size = Size()
        let value2 = finalModel.get(size: &size)
        finalModel.set(value: value2)
        if ((Buffer.readUInt32(buffer: buffer, offset: 0) != low) ||
            (Buffer.readUInt32(buffer: buffer, offset: 4) != mid) ||
            (Buffer.readUInt32(buffer: buffer, offset: 8) != high) ||
            (Buffer.readUInt32(buffer: buffer, offset: 12) != flags) ||
            (size.value != 16) || value1 != value2) {
            return Decimal.leastNonzeroMagnitude
        }

        return value1
    }

}
