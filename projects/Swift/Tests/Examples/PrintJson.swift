//
//  PrintJson.swift
//

import XCTest
import ChronoxorTest

class PrintJson: XCTestCase {
    func testPrintJson() {
        print(try! StructSimple().toJson())
        print("")

        print(try! StructOptional().toJson())
        print("")

        print(try! StructNested().toJson())
        print("")
    }
}
