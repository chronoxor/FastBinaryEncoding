//
// Created by Ivan Shynkarenka on 06.08.2018
//

#include "test.h"

#include "../proto/test_models.h"
#include "../proto/test_final_models.h"

bool Compare(FBE::decimal_t value1, double value2)
{
    return (fabs((double)value1 - value2) <= (0.000000000001 * fmin(fabs((double)value1), fabs(value2))));
}

FBE::decimal_t VerifyDecimal(uint32_t low, uint32_t mid, uint32_t high, bool negative, uint8_t scale)
{
    uint32_t flags = negative ? ((scale << 16) | 0x80000000) : (scale << 16);

    uint8_t data[16];
    *((uint32_t*)(data + 0)) = low;
    *((uint32_t*)(data + 4)) = mid;
    *((uint32_t*)(data + 8)) = high;
    *((uint32_t*)(data + 12)) = flags;

    FBE::FBEBuffer buffer(data, 16);

    FBE::FieldModel<FBE::decimal_t> model(buffer, 0);
    FBE::decimal_t value1;
    FBE::decimal_t value2;
    model.get(value1);
    model.set(value1);
    model.get(value2);
    if (!Compare(value1, value2))
        throw std::logic_error("Invalid decimal serialization!");

    FBE::FinalModel<FBE::decimal_t> final_model(buffer, 0);
    FBE::decimal_t value3;
    FBE::decimal_t value4;
    if (final_model.get(value3) != 16)
        throw std::logic_error("Invalid decimal final serialization!");
    final_model.set(value3);
    if (final_model.get(value4) != 16)
        throw std::logic_error("Invalid decimal final serialization!");
    if (!Compare(value3, value4))
        throw std::logic_error("Invalid decimal final serialization!");

    return value1;
}

TEST_CASE("Decimal tests", "[FBE]")
{
    REQUIRE(Compare(VerifyDecimal(0x00000000, 0x00000000, 0x00000000, false, (uint8_t)0x00000000), 0.0));
    REQUIRE(Compare(VerifyDecimal(0x00000001, 0x00000000, 0x00000000, false, (uint8_t)0x00000000), 1.0));
    REQUIRE(Compare(VerifyDecimal(0x107A4000, 0x00005AF3, 0x00000000, false, (uint8_t)0x00000000), 100000000000000.0));
    REQUIRE(Compare(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (uint8_t)(0x000E0000 >> 16)), 100000000000000.00000000000000));
    REQUIRE(Compare(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (uint8_t)0x00000000), 10000000000000000000000000000.0));
    REQUIRE(Compare(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (uint8_t)(0x001C0000 >> 16)), 1.0000000000000000000000000000));
    REQUIRE(Compare(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (uint8_t)0x00000000), 123456789.0));
    REQUIRE(Compare(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (uint8_t)(0x00090000 >> 16)), 0.123456789));
    REQUIRE(Compare(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (uint8_t)(0x00120000 >> 16)), 0.000000000123456789));
    REQUIRE(Compare(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (uint8_t)(0x001B0000 >> 16)), 0.000000000000000000123456789));
    REQUIRE(Compare(VerifyDecimal(0xFFFFFFFF, 0x00000000, 0x00000000, false, (uint8_t)0x00000000), 4294967295.0));
    REQUIRE(Compare(VerifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, false, (uint8_t)0x00000000), 18446744073709551615.0));
    //REQUIRE(Compare(VerifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, false, (uint8_t)0x00000000), 79228162514264337593543950335.0));
    //REQUIRE(Compare(VerifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, (uint8_t)0x00000000), -79228162514264337593543950335.0));
    REQUIRE(Compare(VerifyDecimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, (uint8_t)(0x001C0000 >> 16)), -7.9228162514264337593543950335));
}
