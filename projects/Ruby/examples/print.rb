require_relative '../proto/test'

puts Test::StructSimple.new
puts
puts Test::StructOptional.new
puts
puts Test::StructNested.new
puts

# Print bytes struct
struct_bytes = Test::StructBytes.new
struct_bytes.f1 = 'ABC'
struct_bytes.f2 = 'test'
puts struct_bytes
puts

# Print array struct
struct_array = Test::StructArray.new
struct_array.f1[0] = 48
struct_array.f1[1] = 65
struct_array.f2[0] = 97
struct_array.f2[1] = nil
struct_array.f3[0] = '000'
struct_array.f3[1] = 'AAA'
struct_array.f4[0] = 'aaa'
struct_array.f4[1] = nil
struct_array.f5[0] = Test::EnumSimple.ENUM_VALUE_1
struct_array.f5[1] = Test::EnumSimple.ENUM_VALUE_2
struct_array.f6[0] = Test::EnumSimple.ENUM_VALUE_1
struct_array.f6[1] = nil
struct_array.f7[0] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_array.f7[1] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
struct_array.f8[0] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_array.f8[1] = nil
struct_array.f9[0] = Test::StructSimple.new
struct_array.f9[1] = Test::StructSimple.new
struct_array.f10[0] = Test::StructSimple.new
struct_array.f10[1] = nil
puts struct_array
puts

# Print vector struct
struct_vector = Test::StructVector.new
struct_vector.f1.push(48)
struct_vector.f1.push(65)
struct_vector.f2.push(97)
struct_vector.f2.push(nil)
struct_vector.f3.push('000')
struct_vector.f3.push('AAA')
struct_vector.f4.push('aaa')
struct_vector.f4.push(nil)
struct_vector.f5.push(Test::EnumSimple.ENUM_VALUE_1)
struct_vector.f5.push(Test::EnumSimple.ENUM_VALUE_2)
struct_vector.f6.push(Test::EnumSimple.ENUM_VALUE_1)
struct_vector.f6.push(nil)
struct_vector.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
struct_vector.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
struct_vector.f8.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
struct_vector.f8.push(nil)
struct_vector.f9.push(Test::StructSimple.new)
struct_vector.f9.push(Test::StructSimple.new)
struct_vector.f10.push(Test::StructSimple.new)
struct_vector.f10.push(nil)
puts struct_vector
puts

# Print list struct
struct_list = Test::StructList.new
struct_list.f1.push(48)
struct_list.f1.push(65)
struct_list.f2.push(97)
struct_list.f2.push(nil)
struct_list.f3.push('000')
struct_list.f3.push('AAA')
struct_list.f4.push('aaa')
struct_list.f4.push(nil)
struct_list.f5.push(Test::EnumSimple.ENUM_VALUE_1)
struct_list.f5.push(Test::EnumSimple.ENUM_VALUE_2)
struct_list.f6.push(Test::EnumSimple.ENUM_VALUE_1)
struct_list.f6.push(nil)
struct_list.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
struct_list.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
struct_list.f8.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
struct_list.f8.push(nil)
struct_list.f9.push(Test::StructSimple.new)
struct_list.f9.push(Test::StructSimple.new)
struct_list.f10.push(Test::StructSimple.new)
struct_list.f10.push(nil)
puts struct_list
puts

# Print set struct
struct_set = Test::StructSet.new
struct_set.f1.add(48)
struct_set.f1.add(65)
struct_set.f1.add(97)
struct_set.f2.add(Test::EnumSimple.ENUM_VALUE_1)
struct_set.f2.add(Test::EnumSimple.ENUM_VALUE_2)
struct_set.f3.add(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
struct_set.f3.add(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
s1 = Test::StructSimple.new
s1.id = 48
struct_set.f4.add(s1)
s2 = Test::StructSimple.new
s2.id = 65
struct_set.f4.add(s2)
puts struct_set
puts

# Print map struct
struct_map = Test::StructMap.new
struct_map.f1[10] = 48
struct_map.f1[20] = 65
struct_map.f2[10] = 97
struct_map.f2[20] = nil
struct_map.f3[10] = '000'
struct_map.f3[20] = 'AAA'
struct_map.f4[10] = 'aaa'
struct_map.f4[20] = nil
struct_map.f5[10] = Test::EnumSimple.ENUM_VALUE_1
struct_map.f5[20] = Test::EnumSimple.ENUM_VALUE_2
struct_map.f6[10] = Test::EnumSimple.ENUM_VALUE_1
struct_map.f6[20] = nil
struct_map.f7[10] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_map.f7[20] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
struct_map.f8[10] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_map.f8[20] = nil
s1 = Test::StructSimple.new
s1.id = 48
struct_map.f9[10] = s1
s2 = Test::StructSimple.new
s2.id = 65
struct_map.f9[20] = s2
struct_map.f10[10] = s1
struct_map.f10[20] = nil
puts struct_map
puts

# Print hash struct
struct_hash = Test::StructHash.new
struct_hash.f1['10'] = 48
struct_hash.f1['20'] = 65
struct_hash.f2['10'] = 97
struct_hash.f2['20'] = nil
struct_hash.f3['10'] = '000'
struct_hash.f3['20'] = 'AAA'
struct_hash.f4['10'] = 'aaa'
struct_hash.f4['20'] = nil
struct_hash.f5['10'] = Test::EnumSimple.ENUM_VALUE_1
struct_hash.f5['20'] = Test::EnumSimple.ENUM_VALUE_2
struct_hash.f6['10'] = Test::EnumSimple.ENUM_VALUE_1
struct_hash.f6['20'] = nil
struct_hash.f7['10'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_hash.f7['20'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
struct_hash.f8['10'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
struct_hash.f8['20'] = nil
s1 = Test::StructSimple.new
s1.id = 48
struct_hash.f9['10'] = s1
s2 = Test::StructSimple.new
s2.id = 65
struct_hash.f9['20'] = s2
struct_hash.f10['10'] = s1
struct_hash.f10['20'] = nil
puts struct_hash
puts

# Print extended hash struct
struct_hash_ex = Test::StructHashEx.new
s1 = Test::StructSimple.new
s1.id = 48
struct_hash_ex.f1[s1] = Test::StructNested.new
s2 = Test::StructSimple.new
s2.id = 65
struct_hash_ex.f1[s2] = Test::StructNested.new
struct_hash_ex.f2[s1] = Test::StructNested.new
struct_hash_ex.f2[s2] = nil
puts struct_hash_ex
puts
