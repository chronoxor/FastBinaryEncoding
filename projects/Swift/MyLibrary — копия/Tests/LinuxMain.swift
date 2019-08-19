import XCTest

import MyLibraryTests

var tests = [XCTestCaseEntry]()
tests += MyLibraryTests.allTests()
XCTMain(tests)
