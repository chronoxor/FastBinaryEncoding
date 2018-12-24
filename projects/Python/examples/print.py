from proto import test


def main():
    print(str(test.StructSimple()) + '\n')
    print(str(test.StructOptional()) + '\n')
    print(str(test.StructNested()) + '\n')

    # Print bytes struct
    struct_bytes = test.StructBytes()
    struct_bytes.f1 = "ABC".encode()
    struct_bytes.f2 = "test".encode()
    print(str(struct_bytes) + '\n')

    # Print array struct
    struct_array = test.StructArray()
    struct_array.f1[0] = 48
    struct_array.f1[1] = 65
    struct_array.f2[0] = 97
    struct_array.f2[1] = None
    struct_array.f3[0] = "000".encode()
    struct_array.f3[1] = "AAA".encode()
    struct_array.f4[0] = "aaa".encode()
    struct_array.f4[1] = None
    struct_array.f5[0] = test.EnumSimple.ENUM_VALUE_1
    struct_array.f5[1] = test.EnumSimple.ENUM_VALUE_2
    struct_array.f6[0] = test.EnumSimple.ENUM_VALUE_1
    struct_array.f6[1] = None
    struct_array.f7[0] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_array.f7[1] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3
    struct_array.f8[0] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_array.f8[1] = None
    struct_array.f9[0] = test.StructSimple()
    struct_array.f9[1] = test.StructSimple()
    struct_array.f10[0] = test.StructSimple()
    struct_array.f10[1] = None
    print(str(struct_array) + '\n')

    # Print vector struct
    struct_vector = test.StructVector()
    struct_vector.f1.append(48)
    struct_vector.f1.append(65)
    struct_vector.f2.append(97)
    struct_vector.f2.append(None)
    struct_vector.f3.append("000".encode())
    struct_vector.f3.append("AAA".encode())
    struct_vector.f4.append("aaa".encode())
    struct_vector.f4.append(None)
    struct_vector.f5.append(test.EnumSimple.ENUM_VALUE_1)
    struct_vector.f5.append(test.EnumSimple.ENUM_VALUE_2)
    struct_vector.f6.append(test.EnumSimple.ENUM_VALUE_1)
    struct_vector.f6.append(None)
    struct_vector.f7.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2)
    struct_vector.f7.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3)
    struct_vector.f8.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2)
    struct_vector.f8.append(None)
    struct_vector.f9.append(test.StructSimple())
    struct_vector.f9.append(test.StructSimple())
    struct_vector.f10.append(test.StructSimple())
    struct_vector.f10.append(None)
    print(str(struct_vector) + '\n')

    # Print list struct
    struct_list = test.StructList()
    struct_list.f1.append(48)
    struct_list.f1.append(65)
    struct_list.f2.append(97)
    struct_list.f2.append(None)
    struct_list.f3.append("000".encode())
    struct_list.f3.append("AAA".encode())
    struct_list.f4.append("aaa".encode())
    struct_list.f4.append(None)
    struct_list.f5.append(test.EnumSimple.ENUM_VALUE_1)
    struct_list.f5.append(test.EnumSimple.ENUM_VALUE_2)
    struct_list.f6.append(test.EnumSimple.ENUM_VALUE_1)
    struct_list.f6.append(None)
    struct_list.f7.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2)
    struct_list.f7.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3)
    struct_list.f8.append(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2)
    struct_list.f8.append(None)
    struct_list.f9.append(test.StructSimple())
    struct_list.f9.append(test.StructSimple())
    struct_list.f10.append(test.StructSimple())
    struct_list.f10.append(None)
    print(str(struct_list) + '\n')

    # Print set struct
    struct_set = test.StructSet()
    struct_set.f1.add(48)
    struct_set.f1.add(65)
    struct_set.f1.add(97)
    struct_set.f2.add(test.EnumSimple.ENUM_VALUE_1)
    struct_set.f2.add(test.EnumSimple.ENUM_VALUE_2)
    struct_set.f3.add(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2)
    struct_set.f3.add(test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3)
    s1 = test.StructSimple()
    s1.id = 48
    struct_set.f4.add(s1)
    s2 = test.StructSimple()
    s2.id = 65
    struct_set.f4.add(s2)
    print(str(struct_set) + '\n')

    # Print map struct
    struct_map = test.StructMap()
    struct_map.f1[10] = 48
    struct_map.f1[20] = 65
    struct_map.f2[10] = 97
    struct_map.f2[20] = None
    struct_map.f3[10] = "000".encode()
    struct_map.f3[20] = "AAA".encode()
    struct_map.f4[10] = "aaa".encode()
    struct_map.f4[20] = None
    struct_map.f5[10] = test.EnumSimple.ENUM_VALUE_1
    struct_map.f5[20] = test.EnumSimple.ENUM_VALUE_2
    struct_map.f6[10] = test.EnumSimple.ENUM_VALUE_1
    struct_map.f6[20] = None
    struct_map.f7[10] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_map.f7[20] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3
    struct_map.f8[10] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_map.f8[20] = None
    s1 = test.StructSimple()
    s1.id = 48
    struct_map.f9[10] = s1
    s2 = test.StructSimple()
    s2.id = 65
    struct_map.f9[20] = s2
    struct_map.f10[10] = s1
    struct_map.f10[20] = None
    print(str(struct_map) + '\n')

    # Print hash struct
    struct_hash = test.StructHash()
    struct_hash.f1["10"] = 48
    struct_hash.f1["20"] = 65
    struct_hash.f2["10"] = 97
    struct_hash.f2["20"] = None
    struct_hash.f3["10"] = "000".encode()
    struct_hash.f3["20"] = "AAA".encode()
    struct_hash.f4["10"] = "aaa".encode()
    struct_hash.f4["20"] = None
    struct_hash.f5["10"] = test.EnumSimple.ENUM_VALUE_1
    struct_hash.f5["20"] = test.EnumSimple.ENUM_VALUE_2
    struct_hash.f6["10"] = test.EnumSimple.ENUM_VALUE_1
    struct_hash.f6["20"] = None
    struct_hash.f7["10"] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_hash.f7["20"] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2 | test.FlagsSimple.FLAG_VALUE_3
    struct_hash.f8["10"] = test.FlagsSimple.FLAG_VALUE_1 | test.FlagsSimple.FLAG_VALUE_2
    struct_hash.f8["20"] = None
    s1 = test.StructSimple()
    s1.id = 48
    struct_hash.f9["10"] = s1
    s2 = test.StructSimple()
    s2.id = 65
    struct_hash.f9["20"] = s2
    struct_hash.f10["10"] = s1
    struct_hash.f10["20"] = None
    print(str(struct_hash) + '\n')

    # Print extended hash struct
    struct_hash_ex = test.StructHashEx()
    s1 = test.StructSimple()
    s1.id = 48
    struct_hash_ex.f1[s1] = test.StructNested()
    s2 = test.StructSimple()
    s2.id = 65
    struct_hash_ex.f1[s2] = test.StructNested()
    struct_hash_ex.f2[s1] = test.StructNested()
    struct_hash_ex.f2[s2] = None
    print(str(struct_hash_ex) + '\n')


if __name__ == "__main__":
    main()
