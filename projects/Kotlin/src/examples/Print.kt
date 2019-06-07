package examples

import java.util.*

import com.chronoxor.test.*

object Print
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        println(StructSimple())
        println()

        println(StructOptional())
        println()

        println(StructNested())
        println()

        // Print bytes struct
        val structBytes = StructBytes()
        structBytes.f1 = "ABC".toByteArray()
        structBytes.f2 = "test".toByteArray()
        println(structBytes)
        println()

        // Print array struct
        val structArray = StructArray()
        structArray.f1[0] = 48
        structArray.f1[1] = 65
        structArray.f2[0] = 97
        structArray.f2[1] = null
        structArray.f3[0] = "000".toByteArray()
        structArray.f3[1] = "AAA".toByteArray()
        structArray.f4[0] = "aaa".toByteArray()
        structArray.f4[1] = null
        structArray.f5[0] = EnumSimple.ENUM_VALUE_1
        structArray.f5[1] = EnumSimple.ENUM_VALUE_2
        structArray.f6[0] = EnumSimple.ENUM_VALUE_1
        structArray.f6[1] = null
        structArray.f7[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structArray.f7[1] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value))
        structArray.f8[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structArray.f8[1] = null
        structArray.f9[0] = StructSimple()
        structArray.f9[1] = StructSimple()
        structArray.f10[0] = StructSimple()
        structArray.f10[1] = null
        println(structArray)
        println()

        // Print vector struct
        val structVector = StructVector()
        structVector.f1.add(48.toByte())
        structVector.f1.add(65.toByte())
        structVector.f2.add(97.toByte())
        structVector.f2.add(null)
        structVector.f3.add("000".toByteArray())
        structVector.f3.add("AAA".toByteArray())
        structVector.f4.add("aaa".toByteArray())
        structVector.f4.add(null)
        structVector.f5.add(EnumSimple.ENUM_VALUE_1)
        structVector.f5.add(EnumSimple.ENUM_VALUE_2)
        structVector.f6.add(EnumSimple.ENUM_VALUE_1)
        structVector.f6.add(null)
        structVector.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value)))
        structVector.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value)))
        structVector.f8.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value)))
        structVector.f8.add(null)
        structVector.f9.add(StructSimple())
        structVector.f9.add(StructSimple())
        structVector.f10.add(StructSimple())
        structVector.f10.add(null)
        println(structVector)
        println()

        // Print list struct
        val structList = StructList()
        structList.f1.addLast(48.toByte())
        structList.f1.addLast(65.toByte())
        structList.f2.addLast(97.toByte())
        structList.f2.addLast(null)
        structList.f3.addLast("000".toByteArray())
        structList.f3.addLast("AAA".toByteArray())
        structList.f4.addLast("aaa".toByteArray())
        structList.f4.addLast(null)
        structList.f5.addLast(EnumSimple.ENUM_VALUE_1)
        structList.f5.addLast(EnumSimple.ENUM_VALUE_2)
        structList.f6.addLast(EnumSimple.ENUM_VALUE_1)
        structList.f6.addLast(null)
        structList.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value)))
        structList.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value)))
        structList.f8.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value)))
        structList.f8.addLast(null)
        structList.f9.addLast(StructSimple())
        structList.f9.addLast(StructSimple())
        structList.f10.addLast(StructSimple())
        structList.f10.addLast(null)
        println(structList)
        println()

        // Print set struct
        val structSet = StructSet()
        structSet.f1.add(48.toByte())
        structSet.f1.add(65.toByte())
        structSet.f1.add(97.toByte())
        structSet.f2.add(EnumSimple.ENUM_VALUE_1)
        structSet.f2.add(EnumSimple.ENUM_VALUE_2)
        structSet.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value)))
        structSet.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value)))
        val s1 = StructSimple()
        s1.id = 48
        structSet.f4.add(s1)
        val s2 = StructSimple()
        s2.id = 65
        structSet.f4.add(s2)
        println(structSet)
        println()

        // Print map struct
        val structMap = StructMap()
        structMap.f1[10] = 48.toByte()
        structMap.f1[20] = 65.toByte()
        structMap.f2[10] = 97.toByte()
        structMap.f2[20] = null
        structMap.f3[10] = "000".toByteArray()
        structMap.f3[20] = "AAA".toByteArray()
        structMap.f4[10] = "aaa".toByteArray()
        structMap.f4[20] = null
        structMap.f5[10] = EnumSimple.ENUM_VALUE_1
        structMap.f5[20] = EnumSimple.ENUM_VALUE_2
        structMap.f6[10] = EnumSimple.ENUM_VALUE_1
        structMap.f6[20] = null
        structMap.f7[10] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structMap.f7[20] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value))
        structMap.f8[10] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structMap.f8[20] = null
        s1.id = 48
        structMap.f9[10] = s1
        s2.id = 65
        structMap.f9[20] = s2
        structMap.f10[10] = s1
        structMap.f10[20] = null
        println(structMap)
        println()

        // Print hash struct
        val structHash = StructHash()
        structHash.f1["10"] = 48.toByte()
        structHash.f1["20"] = 65.toByte()
        structHash.f2["10"] = 97.toByte()
        structHash.f2["20"] = null
        structHash.f3["10"] = "000".toByteArray()
        structHash.f3["20"] = "AAA".toByteArray()
        structHash.f4["10"] = "aaa".toByteArray()
        structHash.f4["20"] = null
        structHash.f5["10"] = EnumSimple.ENUM_VALUE_1
        structHash.f5["20"] = EnumSimple.ENUM_VALUE_2
        structHash.f6["10"] = EnumSimple.ENUM_VALUE_1
        structHash.f6["20"] = null
        structHash.f7["10"] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structHash.f7["20"] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value, FlagsSimple.FLAG_VALUE_3.value))
        structHash.f8["10"] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.value, FlagsSimple.FLAG_VALUE_2.value))
        structHash.f8["20"] = null
        s1.id = 48
        structHash.f9["10"] = s1
        s2.id = 65
        structHash.f9["20"] = s2
        structHash.f10["10"] = s1
        structHash.f10["20"] = null
        println(structHash)
        println()

        // Print extended hash struct
        val structHashEx = StructHashEx()
        s1.id = 48
        structHashEx.f1[s1] = StructNested()
        s2.id = 65
        structHashEx.f1[s2] = StructNested()
        structHashEx.f2[s1] = StructNested()
        structHashEx.f2[s2] = null
        println(structHashEx)
        println()
    }
}
