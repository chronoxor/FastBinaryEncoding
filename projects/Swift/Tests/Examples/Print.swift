//
//  Print.swift
//

import XCTest
@testable import ChronoxorTest

class ExamplePrint: XCTestCase {
    func testPrint() {
        print(StructSimple().description)
        print("")

        print(StructOptional().description)
        print("")

        print(StructNested().description)
        print("")

        // Print bytes struct
        var structBytes = StructBytes()
        structBytes.f1 = "ABC".data(using: .utf8)!
        structBytes.f2 = "test".data(using: .utf8)!
        print(structBytes.description)
        print("")

        // Print array struct
        var structArray = StructArray()
        structArray.f1 = Array(repeating: 0, count: 2)
        structArray.f1[0] = 48
        structArray.f1[1] = 65
        structArray.f2 = Array(repeating: nil, count: 2)
        structArray.f2[0] = 97
        structArray.f2[1] = nil
        structArray.f3 = Array(repeating: "000".data(using: .utf8)!, count: 2)
        structArray.f3[0] = "000".data(using: .utf8)!
        structArray.f3[1] = "AAA".data(using: .utf8)!
        structArray.f4 = Array(repeating: nil, count: 2)
        structArray.f4[0] = "aaa".data(using: .utf8)!
        structArray.f4[1] = nil
        structArray.f5 = Array(repeating: EnumSimple.ENUM_VALUE_1, count: 2)
        structArray.f5[0] = EnumSimple.ENUM_VALUE_1
        structArray.f5[1] = EnumSimple.ENUM_VALUE_2
        structArray.f6 = Array(repeating: nil, count: 2)
        structArray.f6[0] = EnumSimple.ENUM_VALUE_1
        structArray.f6[1] = nil
        structArray.f7 = Array(repeating: FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]), count: 2)
        structArray.f7[0] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structArray.f7[1] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!])
        structArray.f8 = Array(repeating: nil, count: 2)
        structArray.f8[0] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structArray.f8[1] = nil
        structArray.f9 = Array(repeating: StructSimple(), count: 2)
        structArray.f9[0] = StructSimple()
        structArray.f9[1] = StructSimple()
        structArray.f10 = Array(repeating: nil, count: 2)
        structArray.f10[0] = StructSimple()
        structArray.f10[1] = nil
        print(structArray.description)
        print("")

        // Print vector struct
        var structVector = StructVector()
        structVector.f1.append(48)
        structVector.f1.append(65)
        structVector.f2.append(97)
        structVector.f2.append(nil)
        structVector.f3.append("000".data(using: .utf8)!)
        structVector.f3.append("AAA".data(using: .utf8)!)
        structVector.f4.append("aaa".data(using: .utf8)!)
        structVector.f4.append(nil)
        structVector.f5.append(EnumSimple.ENUM_VALUE_1)
        structVector.f5.append(EnumSimple.ENUM_VALUE_2)
        structVector.f6.append(EnumSimple.ENUM_VALUE_1)
        structVector.f6.append(nil)
        structVector.f7.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]))
        structVector.f7.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!]))
        structVector.f8.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]))
        structVector.f8.append(nil)
        structVector.f9.append(StructSimple())
        structVector.f9.append(StructSimple())
        structVector.f10.append(StructSimple())
        structVector.f10.append(nil)
        print(structVector.description)
        print("")

        // Print list struct
        var structList = StructList()
        structList.f1.append(48)
        structList.f1.append(65)
        structList.f2.append(97)
        structList.f2.append(nil)
        structList.f3.append("000".data(using: .utf8)!)
        structList.f3.append("AAA".data(using: .utf8)!)
        structList.f4.append("aaa".data(using: .utf8)!)
        structList.f4.append(nil)
        structList.f5.append(EnumSimple.ENUM_VALUE_1)
        structList.f5.append(EnumSimple.ENUM_VALUE_2)
        structList.f6.append(EnumSimple.ENUM_VALUE_1)
        structList.f6.append(nil)
        structList.f7.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]))
        structList.f7.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!]))
        structList.f8.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]))
        structList.f8.append(nil)
        structList.f9.append(StructSimple())
        structList.f9.append(StructSimple())
        structList.f10.append(StructSimple())
        structList.f10.append(nil)
        print(structList.description)
        print("")

        // Print set struct
        var structSet = StructSet()
        structSet.f1.append(48)
        structSet.f1.append(65)
        structSet.f1.append(97)
        structSet.f2.append(EnumSimple.ENUM_VALUE_1)
        structSet.f2.append(EnumSimple.ENUM_VALUE_2)
        structSet.f3.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!]))
        structSet.f3.append(FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!]))
        var s1 = StructSimple()
        s1.id = 48
        structSet.f4.append(s1)
        var s2 = StructSimple()
        s2.id = 65
        structSet.f4.append(s2)
        print(structSet.description)
        print("")

        // Print map struct
        var structMap = StructMap()
        structMap.f1[10] = 48
        structMap.f1[20] = 65
        structMap.f2[10] = 97
        structMap.f2.updateValue(nil, forKey: 20)
        structMap.f3[10] = "000".data(using: .utf8)!
        structMap.f3[20] = "AAA".data(using: .utf8)!
        structMap.f4[10] = "aaa".data(using: .utf8)!
        structMap.f4.updateValue(nil, forKey: 20)
        structMap.f5[10] = EnumSimple.ENUM_VALUE_1
        structMap.f5[20] = EnumSimple.ENUM_VALUE_2
        structMap.f6[10] = EnumSimple.ENUM_VALUE_1
        structMap.f6.updateValue(nil, forKey: 20)
        structMap.f7[10] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structMap.f7[20] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!])
        structMap.f8[10] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structMap.f8.updateValue(nil, forKey: 20)
        s1.id = 48
        structMap.f9[10] = s1
        s2.id = 65
        structMap.f9[20] = s2
        structMap.f10[10] = s1
        structMap.f10.updateValue(nil, forKey: 20)
        print(structMap.description)
        print("")

        // Print hash struct
        var structHash = StructHash()
        structHash.f1["10"] = 48
        structHash.f1["20"] = 65
        structHash.f2["10"] = 97
        structHash.f2.updateValue(nil, forKey: "20")
        structHash.f3["10"] = "000".data(using: .utf8)!
        structHash.f3["20"] = "AAA".data(using: .utf8)!
        structHash.f4["10"] = "aaa".data(using: .utf8)!
        structHash.f4.updateValue(nil, forKey: "20")
        structHash.f5["10"] = EnumSimple.ENUM_VALUE_1
        structHash.f5["20"] = EnumSimple.ENUM_VALUE_2
        structHash.f6["10"] = EnumSimple.ENUM_VALUE_1
        structHash.f6.updateValue(nil, forKey: "20")
        structHash.f7["10"] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structHash.f7["20"] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!, FlagsSimple.FLAG_VALUE_3.value!])
        structHash.f8["10"] = FlagsSimple.fromSet(set: [FlagsSimple.FLAG_VALUE_1.value!, FlagsSimple.FLAG_VALUE_2.value!])
        structHash.f8.updateValue(nil, forKey: "20")
        s1.id = 48
        structHash.f9["10"] = s1
        s2.id = 65
        structHash.f9["20"] = s2
        structHash.f10["10"] = s1
        structHash.f10.updateValue(nil, forKey: "20")
        print(structHash.description)
        print("")

        // Print extended hash struct
        var structHashEx = StructHashEx()
        s1.id = 48
        structHashEx.f1[s1] = StructNested()
        s2.id = 65
        structHashEx.f1[s2] = StructNested()
        structHashEx.f2[s1] = StructNested()
        structHashEx.f2.updateValue(nil, forKey: s2)
        print(structHashEx.description)
        print("")
    }
}
