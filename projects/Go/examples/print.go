package main

import "fmt"
import "../proto/test"

func main() {
	fmt.Println(test.NewStructSimple())
	fmt.Println()

	fmt.Println(test.NewStructOptional())
	fmt.Println()

	fmt.Println(test.NewStructNested())
	fmt.Println()

	// Print bytes struct
	structBytes := test.NewStructBytes()
	bytesF1 := []byte("ABC")
	structBytes.F1 = bytesF1
	bytesF2 := []byte("test")
	structBytes.F2 = &bytesF2
	fmt.Println(structBytes)
	fmt.Println()

	// Print array struct
	structArray := test.NewStructArray()
	structArray.F1[0] = 48
	structArray.F1[1] = 65
	arrayF2 := byte(97)
	structArray.F2[0] = &arrayF2
	structArray.F2[1] = nil
	structArray.F3[0] = []byte("000")
	structArray.F3[1] = []byte("AAA")
	arrayF4 := []byte("aaa")
	structArray.F4[0] = &arrayF4
	structArray.F4[1] = nil
	structArray.F5[0] = test.EnumSimple_ENUM_VALUE_1
	structArray.F5[1] = test.EnumSimple_ENUM_VALUE_2
	arrayF6 := test.EnumSimple_ENUM_VALUE_1
	structArray.F6[0] = &arrayF6
	structArray.F6[1] = nil
	structArray.F7[0] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structArray.F7[1] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3
	arrayF8 := test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structArray.F8[0] = &arrayF8
	structArray.F8[1] = nil
	structArray.F9[0] = *test.NewStructSimple()
	structArray.F9[1] = *test.NewStructSimple()
	structArray.F10[0] = test.NewStructSimple()
	structArray.F10[1] = nil
	fmt.Println(structArray)
	fmt.Println()

	// Print vector struct
	structVector := test.NewStructVector()
	structVector.F1 = append(structVector.F1, 48)
	structVector.F1 = append(structVector.F1, 65)
	vectorF2 := byte(97)
	structVector.F2 = append(structVector.F2, &vectorF2)
	structVector.F2 = append(structVector.F2, nil)
	structVector.F3 = append(structVector.F3, []byte("000"))
	structVector.F3 = append(structVector.F3, []byte("AAA"))
	vectorF4 := []byte("aaa")
	structVector.F4 = append(structVector.F4, &vectorF4)
	structVector.F4 = append(structVector.F4, nil)
	structVector.F5 = append(structVector.F5, test.EnumSimple_ENUM_VALUE_1)
	structVector.F5 = append(structVector.F5, test.EnumSimple_ENUM_VALUE_2)
	vectorF6 := test.EnumSimple_ENUM_VALUE_1
	structVector.F6 = append(structVector.F6, &vectorF6)
	structVector.F6 = append(structVector.F6, nil)
	structVector.F7 = append(structVector.F7, test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2)
	structVector.F7 = append(structVector.F7, test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3)
	vectorF8 := test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structVector.F8 = append(structVector.F8, &vectorF8)
	structVector.F8 = append(structVector.F8, nil)
	structVector.F9 = append(structVector.F9, *test.NewStructSimple())
	structVector.F9 = append(structVector.F9, *test.NewStructSimple())
	structVector.F10 = append(structVector.F10, test.NewStructSimple())
	structVector.F10 = append(structVector.F10, nil)
	fmt.Println(structVector)
	fmt.Println()

	// Print list struct
	structList := test.NewStructList()
	structList.F1 = append(structList.F1, 48)
	structList.F1 = append(structList.F1, 65)
	listF2 := byte(97)
	structList.F2 = append(structList.F2, &listF2)
	structList.F2 = append(structList.F2, nil)
	structList.F3 = append(structList.F3, []byte("000"))
	structList.F3 = append(structList.F3, []byte("AAA"))
	listF4 := []byte("aaa")
	structList.F4 = append(structList.F4, &listF4)
	structList.F4 = append(structList.F4, nil)
	structList.F5 = append(structList.F5, test.EnumSimple_ENUM_VALUE_1)
	structList.F5 = append(structList.F5, test.EnumSimple_ENUM_VALUE_2)
	listF6 := test.EnumSimple_ENUM_VALUE_1
	structList.F6 = append(structList.F6, &listF6)
	structList.F6 = append(structList.F6, nil)
	structList.F7 = append(structList.F7, test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2)
	structList.F7 = append(structList.F7, test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3)
	listF8 := test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structList.F8 = append(structList.F8, &listF8)
	structList.F8 = append(structList.F8, nil)
	structList.F9 = append(structList.F9, *test.NewStructSimple())
	structList.F9 = append(structList.F9, *test.NewStructSimple())
	structList.F10 = append(structList.F10, test.NewStructSimple())
	structList.F10 = append(structList.F10, nil)
	fmt.Println(structList)
	fmt.Println()

	// Print set struct
	structSet := test.NewStructSet()
	structSet.F1.Add(48)
	structSet.F1.Add(65)
	structSet.F1.Add(97)
	structSet.F2.Add(test.EnumSimple_ENUM_VALUE_1)
	structSet.F2.Add(test.EnumSimple_ENUM_VALUE_2)
	structSet.F3.Add(test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2)
	structSet.F3.Add(test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3)
	s1 := test.NewStructSimple()
	s1.Id = 48
	structSet.F4.Add(*s1)
	s2 := test.NewStructSimple()
	s2.Id = 65
	structSet.F4.Add(*s2)
	fmt.Println(structSet)
	fmt.Println()

	// Print map struct
	structMap := test.NewStructMap()
	structMap.F1[10] = 48
	structMap.F1[20] = 65
	mapF2 := byte(97)
	structMap.F2[10] = &mapF2
	structMap.F2[20] = nil
	structMap.F3[10] = []byte("000")
	structMap.F3[20] = []byte("AAA")
	mapF4 := []byte("aaa")
	structMap.F4[10] = &mapF4
	structMap.F4[20] = nil
	structMap.F5[10] = test.EnumSimple_ENUM_VALUE_1
	structMap.F5[20] = test.EnumSimple_ENUM_VALUE_2
	mapF6 := test.EnumSimple_ENUM_VALUE_1
	structMap.F6[10] = &mapF6
	structMap.F6[20] = nil
	structMap.F7[10] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structMap.F7[20] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3
	mapF8 := test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structMap.F8[10] = &mapF8
	structMap.F8[20] = nil
	s1.Id = 48
	structMap.F9[10] = *s1
	s2.Id = 65
	structMap.F9[20] = *s2
	structMap.F10[10] = s1
	structMap.F10[20] = nil
	fmt.Println(structMap)
	fmt.Println()

	// Print hash struct
	structHash := test.NewStructHash()
	structHash.F1["10"] = 48
	structHash.F1["20"] = 65
	hashF2 := byte(97)
	structHash.F2["10"] = &hashF2
	structHash.F2["20"] = nil
	structHash.F3["10"] = []byte("000")
	structHash.F3["20"] = []byte("AAA")
	hashF4 := []byte("aaa")
	structHash.F4["10"] = &hashF4
	structHash.F4["20"] = nil
	structHash.F5["10"] = test.EnumSimple_ENUM_VALUE_1
	structHash.F5["20"] = test.EnumSimple_ENUM_VALUE_2
	hashF6 := test.EnumSimple_ENUM_VALUE_1
	structHash.F6["10"] = &hashF6
	structHash.F6["20"] = nil
	structHash.F7["10"] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structHash.F7["20"] = test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2 | test.FlagsSimple_FLAG_VALUE_3
	hashF8 := test.FlagsSimple_FLAG_VALUE_1 | test.FlagsSimple_FLAG_VALUE_2
	structHash.F8["10"] = &hashF8
	structHash.F8["20"] = nil
	s1.Id = 48
	structHash.F9["10"] = *s1
	s2.Id = 65
	structHash.F9["20"] = *s2
	structHash.F10["10"] = s1
	structHash.F10["20"] = nil
	fmt.Println(structHash)
	fmt.Println()

	// Print extended hash struct
	structHashEx := test.NewStructHashEx()
	s1.Id = 48
	structHashEx.F1[s1.Key()] = struct{Key test.StructSimple; Value test.StructNested}{*s1, *test.NewStructNested()}
	s2.Id = 65
	structHashEx.F1[s2.Key()] = struct{Key test.StructSimple; Value test.StructNested}{*s2, *test.NewStructNested()}
	structHashEx.F2[s1.Key()] = struct{Key test.StructSimple; Value *test.StructNested}{*s1, test.NewStructNested()}
	structHashEx.F2[s2.Key()] = struct{Key test.StructSimple; Value *test.StructNested}{*s2, nil}
	fmt.Println(structHashEx)
	fmt.Println()
}
