/*!
    \file print.cpp
    \brief Fast Binary Encoding print example
    \author Ivan Shynkarenka
    \date 18.04.2018
    \copyright MIT License
*/

#include "../proto/test.h"

#include <iostream>

const char* f1 = "ABC";
const char* f2 = "test";

int main(int argc, char** argv)
{
    std::cout << test::StructSimple() << std::endl << std::endl;
    std::cout << test::StructOptional() << std::endl << std::endl;
    std::cout << test::StructNested() << std::endl << std::endl;

    // Print bytes struct
    test::StructBytes struct_bytes;
    struct_bytes.f1.assign((const uint8_t*)f1, (const uint8_t*)f1 + strlen(f1));
    struct_bytes.f2.emplace();
    struct_bytes.f2.value().assign((const uint8_t*)f2, (const uint8_t*)f2 + strlen(f2));
    std::cout << struct_bytes << std::endl << std::endl;

    // Print array struct
    test::StructArray struct_array;
    struct_array.f1[0] = (uint8_t)48;
    struct_array.f1[1] = (uint8_t)65;
    struct_array.f2[0] = (uint8_t)97;
    struct_array.f2[1] = std::nullopt;
    struct_array.f3[0] = std::vector<uint8_t>(3, 48);
    struct_array.f3[1] = std::vector<uint8_t>(3, 65);
    struct_array.f4[0] = std::vector<uint8_t>(3, 97);
    struct_array.f4[1] = std::nullopt;
    struct_array.f5[0] = test::EnumSimple::ENUM_VALUE_1;
    struct_array.f5[1] = test::EnumSimple::ENUM_VALUE_2;
    struct_array.f6[0] = test::EnumSimple::ENUM_VALUE_1;
    struct_array.f6[1] = std::nullopt;
    struct_array.f7[0] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2;
    struct_array.f7[1] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3;
    struct_array.f8[0] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2;
    struct_array.f8[1] = std::nullopt;
    struct_array.f9[0] = test::StructSimple();
    struct_array.f9[1] = test::StructSimple();
    struct_array.f10[0] = test::StructSimple();
    struct_array.f10[1] = std::nullopt;
    std::cout << struct_array << std::endl << std::endl;

    // Print vector struct
    test::StructVector struct_vector;
    struct_vector.f1.emplace_back((uint8_t)48);
    struct_vector.f1.emplace_back((uint8_t)65);
    struct_vector.f2.emplace_back((uint8_t)97);
    struct_vector.f2.emplace_back(std::nullopt);
    struct_vector.f3.emplace_back(std::vector<uint8_t>(3, 48));
    struct_vector.f3.emplace_back(std::vector<uint8_t>(3, 65));
    struct_vector.f4.emplace_back(std::vector<uint8_t>(3, 97));
    struct_vector.f4.emplace_back(std::nullopt);
    struct_vector.f5.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct_vector.f5.emplace_back(test::EnumSimple::ENUM_VALUE_2);
    struct_vector.f6.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct_vector.f6.emplace_back(std::nullopt);
    struct_vector.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_vector.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct_vector.f8.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_vector.f8.emplace_back(std::nullopt);
    struct_vector.f9.emplace_back(test::StructSimple());
    struct_vector.f9.emplace_back(test::StructSimple());
    struct_vector.f10.emplace_back(test::StructSimple());
    struct_vector.f10.emplace_back(std::nullopt);
    std::cout << struct_vector << std::endl << std::endl;

    // Print list struct
    test::StructList struct_list;
    struct_list.f1.emplace_back((uint8_t)48);
    struct_list.f1.emplace_back((uint8_t)65);
    struct_list.f2.emplace_back((uint8_t)97);
    struct_list.f2.emplace_back(std::nullopt);
    struct_list.f3.emplace_back(std::vector<uint8_t>(3, 48));
    struct_list.f3.emplace_back(std::vector<uint8_t>(3, 65));
    struct_list.f4.emplace_back(std::vector<uint8_t>(3, 97));
    struct_list.f4.emplace_back(std::nullopt);
    struct_list.f5.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct_list.f5.emplace_back(test::EnumSimple::ENUM_VALUE_2);
    struct_list.f6.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct_list.f6.emplace_back(std::nullopt);
    struct_list.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_list.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct_list.f8.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_list.f8.emplace_back(std::nullopt);
    struct_list.f9.emplace_back(test::StructSimple());
    struct_list.f9.emplace_back(test::StructSimple());
    struct_list.f10.emplace_back(test::StructSimple());
    struct_list.f10.emplace_back(std::nullopt);
    std::cout << struct_list << std::endl << std::endl;

    // Print set struct
    test::StructSet struct_set;
    struct_set.f1.emplace((uint8_t)48);
    struct_set.f1.emplace((uint8_t)65);
    struct_set.f1.emplace((uint8_t)97);
    struct_set.f2.emplace(test::EnumSimple::ENUM_VALUE_1);
    struct_set.f2.emplace(test::EnumSimple::ENUM_VALUE_2);
    struct_set.f3.emplace(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_set.f3.emplace(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    test::StructSimple s1;
    s1.id = 48;
    struct_set.f4.emplace(s1);
    test::StructSimple s2;
    s2.id = 65;
    struct_set.f4.emplace(s2);
    std::cout << struct_set << std::endl << std::endl;

    // Print map struct
    test::StructMap struct_map;
    struct_map.f1.emplace(10, (uint8_t)48);
    struct_map.f1.emplace(20, (uint8_t)65);
    struct_map.f2.emplace(10, (uint8_t)97);
    struct_map.f2.emplace(20, std::nullopt);
    struct_map.f3.emplace(10, std::vector<uint8_t>(3, 48));
    struct_map.f3.emplace(20, std::vector<uint8_t>(3, 65));
    struct_map.f4.emplace(10, std::vector<uint8_t>(3, 97));
    struct_map.f4.emplace(20, std::nullopt);
    struct_map.f5.emplace(10, test::EnumSimple::ENUM_VALUE_1);
    struct_map.f5.emplace(20, test::EnumSimple::ENUM_VALUE_2);
    struct_map.f6.emplace(10, test::EnumSimple::ENUM_VALUE_1);
    struct_map.f6.emplace(20, std::nullopt);
    struct_map.f7.emplace(10, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_map.f7.emplace(20, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct_map.f8.emplace(10, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_map.f8.emplace(20, std::nullopt);
    s1.id = 48;
    struct_map.f9.emplace(10, s1);
    s2.id = 65;
    struct_map.f9.emplace(20, s2);
    struct_map.f10.emplace(10, s1);
    struct_map.f10.emplace(20, std::nullopt);
    std::cout << struct_map << std::endl << std::endl;

    // Print hash struct
    test::StructHash struct_hash;
    struct_hash.f1.emplace("10", (uint8_t)48);
    struct_hash.f1.emplace("20", (uint8_t)65);
    struct_hash.f2.emplace("10", (uint8_t)97);
    struct_hash.f2.emplace("20", std::nullopt);
    struct_hash.f3.emplace("10", std::vector<uint8_t>(3, 48));
    struct_hash.f3.emplace("20", std::vector<uint8_t>(3, 65));
    struct_hash.f4.emplace("10", std::vector<uint8_t>(3, 97));
    struct_hash.f4.emplace("20", std::nullopt);
    struct_hash.f5.emplace("10", test::EnumSimple::ENUM_VALUE_1);
    struct_hash.f5.emplace("20", test::EnumSimple::ENUM_VALUE_2);
    struct_hash.f6.emplace("10", test::EnumSimple::ENUM_VALUE_1);
    struct_hash.f6.emplace("20", std::nullopt);
    struct_hash.f7.emplace("10", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_hash.f7.emplace("20", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct_hash.f8.emplace("10", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct_hash.f8.emplace("20", std::nullopt);
    s1.id = 48;
    struct_hash.f9.emplace("10", s1);
    s2.id = 65;
    struct_hash.f9.emplace("20", s2);
    struct_hash.f10.emplace("10", s1);
    struct_hash.f10.emplace("20", std::nullopt);
    std::cout << struct_hash << std::endl << std::endl;

    // Print extended hash struct
    test::StructHashEx struct_hashex;
    s1.id = 48;
    struct_hashex.f1.emplace(s1, test::StructNested());
    s2.id = 65;
    struct_hashex.f1.emplace(s2, test::StructNested());
    struct_hashex.f2.emplace(s1, test::StructNested());
    struct_hashex.f2.emplace(s2, std::nullopt);
    std::cout << struct_hashex << std::endl << std::endl;

    return 0;
}
