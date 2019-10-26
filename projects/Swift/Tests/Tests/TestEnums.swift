//
//  TestEnums.swift
//

import Foundation
import XCTest
import ChronoxorEnums

class TestEnums: XCTestCase {
    func testSerializationEnums() {
        let enums1 = Enums()

        // Serialize enums to the FBE stream
        let writer = EnumsModel()
        XCTAssertEqual(writer.model.fbeOffset, 4)
        let serialized = try? writer.serialize(value: enums1)
        XCTAssertEqual(serialized, writer.buffer.size)
        XCTAssertTrue(writer.verify())
        writer.next(prev: serialized!)
        XCTAssertEqual(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        XCTAssertEqual(writer.buffer.size, 232)

        // Deserialize enums from the FBE stream
        var enums2 = Enums()
        let reader = EnumsModel()
        XCTAssertEqual(reader.model.fbeOffset, 4)
        reader.attach(buffer: writer.buffer)
        XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &enums2)
        XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)
        XCTAssertEqual(reader.model.fbeOffset, 4 + reader.buffer.size)

        XCTAssertEqual(enums2.byte0, EnumByte.ENUM_VALUE_0)
        XCTAssertEqual(enums2.byte1, EnumByte.ENUM_VALUE_1)
        XCTAssertEqual(enums2.byte2, EnumByte.ENUM_VALUE_2)
        XCTAssertEqual(enums2.byte3, EnumByte.ENUM_VALUE_3)
        XCTAssertEqual(enums2.byte4, EnumByte.ENUM_VALUE_4)
        XCTAssertEqual(enums2.byte5, enums1.byte3)

        XCTAssertEqual(enums2.char0, EnumChar.ENUM_VALUE_0)
        XCTAssertEqual(enums2.char1, EnumChar.ENUM_VALUE_1)
        XCTAssertEqual(enums2.char2, EnumChar.ENUM_VALUE_2)
        XCTAssertEqual(enums2.char3, EnumChar.ENUM_VALUE_3)
        XCTAssertEqual(enums2.char4, EnumChar.ENUM_VALUE_4)
        XCTAssertEqual(enums2.char5, enums1.char3)

        XCTAssertEqual(enums2.wchar0, EnumWChar.ENUM_VALUE_0)
        XCTAssertEqual(enums2.wchar1, EnumWChar.ENUM_VALUE_1)
        XCTAssertEqual(enums2.wchar2, EnumWChar.ENUM_VALUE_2)
        XCTAssertEqual(enums2.wchar3, EnumWChar.ENUM_VALUE_3)
        XCTAssertEqual(enums2.wchar4, EnumWChar.ENUM_VALUE_4)
        XCTAssertEqual(enums2.wchar5, enums1.wchar3)

        XCTAssertEqual(enums2.int8b0, EnumInt8.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int8b1, EnumInt8.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int8b2, EnumInt8.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int8b3, EnumInt8.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int8b4, EnumInt8.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int8b5, enums1.int8b3)

        XCTAssertEqual(enums2.uint8b0, EnumUInt8.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint8b1, EnumUInt8.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint8b2, EnumUInt8.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint8b3, EnumUInt8.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint8b4, EnumUInt8.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint8b5, enums1.uint8b3)

        XCTAssertEqual(enums2.int16b0, EnumInt16.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int16b1, EnumInt16.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int16b2, EnumInt16.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int16b3, EnumInt16.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int16b4, EnumInt16.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int16b5, enums1.int16b3)

        XCTAssertEqual(enums2.uint16b0, EnumUInt16.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint16b1, EnumUInt16.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint16b2, EnumUInt16.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint16b3, EnumUInt16.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint16b4, EnumUInt16.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint16b5, enums1.uint16b3)

        XCTAssertEqual(enums2.int32b0, EnumInt32.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int32b1, EnumInt32.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int32b2, EnumInt32.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int32b3, EnumInt32.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int32b4, EnumInt32.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int32b5, enums1.int32b3)

        XCTAssertEqual(enums2.uint32b0, EnumUInt32.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint32b1, EnumUInt32.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint32b2, EnumUInt32.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint32b3, EnumUInt32.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint32b4, EnumUInt32.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint32b5, enums1.uint32b3)

        XCTAssertEqual(enums2.int64b0, EnumInt64.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int64b1, EnumInt64.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int64b2, EnumInt64.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int64b3, EnumInt64.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int64b4, EnumInt64.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int64b5, enums1.int64b3)

        XCTAssertEqual(enums2.uint64b0, EnumUInt64.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint64b1, EnumUInt64.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint64b2, EnumUInt64.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint64b3, EnumUInt64.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint64b4, EnumUInt64.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint64b5, enums1.uint64b3)
    }

    func testSerializationFinalEnums() {
        let enums1 = Enums()

        // Serialize enums to the FBE stream
        let writer = EnumsFinalModel()
        let serialized = try? writer.serialize(value: enums1)
        XCTAssertEqual(serialized, writer.buffer.size)
        XCTAssertTrue(writer.verify())
        writer.next(prev: serialized!)

        // Check the serialized FBE size
        XCTAssertEqual(writer.buffer.size, 224)

        // Deserialize enums from the FBE stream
        var enums2 = Enums()
        let reader = EnumsFinalModel()
        reader.attach(buffer: writer.buffer)
        XCTAssertTrue(reader.verify())
        let deserialized = reader.deserialize(value: &enums2)
        XCTAssertEqual(deserialized, reader.buffer.size)
        reader.next(prev: deserialized)

        XCTAssertEqual(enums2.byte0, EnumByte.ENUM_VALUE_0)
        XCTAssertEqual(enums2.byte1, EnumByte.ENUM_VALUE_1)
        XCTAssertEqual(enums2.byte2, EnumByte.ENUM_VALUE_2)
        XCTAssertEqual(enums2.byte3, EnumByte.ENUM_VALUE_3)
        XCTAssertEqual(enums2.byte4, EnumByte.ENUM_VALUE_4)
        XCTAssertEqual(enums2.byte5, enums1.byte3)

        XCTAssertEqual(enums2.char0, EnumChar.ENUM_VALUE_0)
        XCTAssertEqual(enums2.char1, EnumChar.ENUM_VALUE_1)
        XCTAssertEqual(enums2.char2, EnumChar.ENUM_VALUE_2)
        XCTAssertEqual(enums2.char3, EnumChar.ENUM_VALUE_3)
        XCTAssertEqual(enums2.char4, EnumChar.ENUM_VALUE_4)
        XCTAssertEqual(enums2.char5, enums1.char3)

        XCTAssertEqual(enums2.wchar0, EnumWChar.ENUM_VALUE_0)
        XCTAssertEqual(enums2.wchar1, EnumWChar.ENUM_VALUE_1)
        XCTAssertEqual(enums2.wchar2, EnumWChar.ENUM_VALUE_2)
        XCTAssertEqual(enums2.wchar3, EnumWChar.ENUM_VALUE_3)
        XCTAssertEqual(enums2.wchar4, EnumWChar.ENUM_VALUE_4)
        XCTAssertEqual(enums2.wchar5, enums1.wchar3)

        XCTAssertEqual(enums2.int8b0, EnumInt8.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int8b1, EnumInt8.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int8b2, EnumInt8.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int8b3, EnumInt8.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int8b4, EnumInt8.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int8b5, enums1.int8b3)

        XCTAssertEqual(enums2.uint8b0, EnumUInt8.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint8b1, EnumUInt8.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint8b2, EnumUInt8.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint8b3, EnumUInt8.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint8b4, EnumUInt8.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint8b5, enums1.uint8b3)

        XCTAssertEqual(enums2.int16b0, EnumInt16.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int16b1, EnumInt16.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int16b2, EnumInt16.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int16b3, EnumInt16.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int16b4, EnumInt16.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int16b5, enums1.int16b3)

        XCTAssertEqual(enums2.uint16b0, EnumUInt16.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint16b1, EnumUInt16.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint16b2, EnumUInt16.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint16b3, EnumUInt16.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint16b4, EnumUInt16.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint16b5, enums1.uint16b3)

        XCTAssertEqual(enums2.int32b0, EnumInt32.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int32b1, EnumInt32.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int32b2, EnumInt32.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int32b3, EnumInt32.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int32b4, EnumInt32.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int32b5, enums1.int32b3)

        XCTAssertEqual(enums2.uint32b0, EnumUInt32.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint32b1, EnumUInt32.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint32b2, EnumUInt32.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint32b3, EnumUInt32.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint32b4, EnumUInt32.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint32b5, enums1.uint32b3)

        XCTAssertEqual(enums2.int64b0, EnumInt64.ENUM_VALUE_0)
        XCTAssertEqual(enums2.int64b1, EnumInt64.ENUM_VALUE_1)
        XCTAssertEqual(enums2.int64b2, EnumInt64.ENUM_VALUE_2)
        XCTAssertEqual(enums2.int64b3, EnumInt64.ENUM_VALUE_3)
        XCTAssertEqual(enums2.int64b4, EnumInt64.ENUM_VALUE_4)
        XCTAssertEqual(enums2.int64b5, enums1.int64b3)

        XCTAssertEqual(enums2.uint64b0, EnumUInt64.ENUM_VALUE_0)
        XCTAssertEqual(enums2.uint64b1, EnumUInt64.ENUM_VALUE_1)
        XCTAssertEqual(enums2.uint64b2, EnumUInt64.ENUM_VALUE_2)
        XCTAssertEqual(enums2.uint64b3, EnumUInt64.ENUM_VALUE_3)
        XCTAssertEqual(enums2.uint64b4, EnumUInt64.ENUM_VALUE_4)
        XCTAssertEqual(enums2.uint64b5, enums1.uint64b3)
    }
}
