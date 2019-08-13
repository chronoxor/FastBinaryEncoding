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

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //XCTAssertEqual(verifyDecimal(low: 0x00000000, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000), Decimal.zero)
//        XCTAssertEqual(verifyDecimal(low: 0x00000001, mid: 0x00000000, high: 0x00000000, negative: false, scale: 0x00000000), Decimal(integerLiteral: 1))
//        XCTAssertEqual(verifyDecimal(low: 0x107A4000, mid: 0x00005AF3, high: 0x00000000, negative: false, scale: 0x00000000), Decimal(integerLiteral: 100000000000000))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: UInt8(0x000E0000 >> 16)), Decimal.init(string: "100000000000000.00000000000000"))
        XCTAssertEqual(verifyDecimal(low: 0x10000000, mid: 0x3E250261, high: 0x204FCE5E, negative: false, scale: 0x00000000), Decimal(string: "10000000000000000000000000000"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func verifyDecimal(low: Int32, mid: Int32, high: Int32, negative: Bool, scale: UInt8) -> Decimal {
//        let flags = negative ? ((Int32(scale) >> 16) | Int32(80000000)) : (Int32(scale) >> 16)
//
//        var buffer = Data(count: 16)
//
//        Buffer.write(buffer: &buffer, offset: 0, value: low)
//        Buffer.write(buffer: &buffer, offset: 4, value: mid)
//        Buffer.write(buffer: &buffer, offset: 8, value: high)
//        Buffer.write(buffer: &buffer, offset: 12, value: flags)
//
//        let model = FieldModelDecimal(buffer: Buffer(buffer: buffer), offset: 0)
//        let value1 = model.get()
//        model.set(value: value1)
//        if ((Buffer.readInt32(buffer: buffer, offset: 0) != low) ||
//            (Buffer.readInt32(buffer: buffer, offset: 4) != mid) ||
//            (Buffer.readInt32(buffer: buffer, offset: 8) != high) ||
//            (Buffer.readInt32(buffer: buffer, offset: 12) != flags)) {
            return Decimal.leastNonzeroMagnitude
//        }
//
//        let finalModel = FinalModelDecimal(Buffer(buffer), 0)
//        let size = Size()
//        let value2 = finalModel.get(size)
//        finalModel.set(value2)
//        if ((Buffer.readInt32(buffer, 0) != low) ||
//            (Buffer.readInt32(buffer, 4) != mid) ||
//            (Buffer.readInt32(buffer, 8) != high) ||
//            (Buffer.readInt32(buffer, 12) != flags) ||
//            (size.value != 16) || (value1.compareTo(value2) != 0)) {
//            return Decimal.leastNonzeroMagnitude
//        }

//        return value1
    }

}
