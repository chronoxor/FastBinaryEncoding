//
// Created by Ivan Shynkarenka on 09.07.2018
//

#include "test.h"

#include "../proto/proto_final_models.h"
#include "../proto/test_final_models.h"

TEST_CASE("Serialization (Final): domain", "[FBE]")
{
    // Create a new account with some orders
    proto::Account account1 = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account1.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account1.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account1.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the FBE stream
    FBE::proto::AccountFinalModel writer;
    size_t serialized = writer.serialize(account1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 152);

    // Deserialize the account from the FBE stream
    proto::Account account2;
    FBE::proto::AccountFinalModel reader;
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(account2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(account2.id == 1);
    REQUIRE(account2.name == "Test");
    REQUIRE((account2.state | proto::State::good));
    REQUIRE(std::string(account2.wallet.currency) == "USD");
    REQUIRE(account2.wallet.amount == 1000.0);
    REQUIRE(account2.asset.has_value());
    REQUIRE(std::string(account2.asset.value().currency) == "EUR");
    REQUIRE(account2.asset.value().amount == 100.0);
    REQUIRE(account2.orders.size() == 3);
    REQUIRE(account2.orders[0].id == 1);
    REQUIRE(std::string(account2.orders[0].symbol) == "EURUSD");
    REQUIRE(account2.orders[0].side == proto::OrderSide::buy);
    REQUIRE(account2.orders[0].type == proto::OrderType::market);
    REQUIRE(account2.orders[0].price == 1.23456);
    REQUIRE(account2.orders[0].volume == 1000.0);
    REQUIRE(account2.orders[1].id == 2);
    REQUIRE(std::string(account2.orders[1].symbol) == "EURUSD");
    REQUIRE(account2.orders[1].side == proto::OrderSide::sell);
    REQUIRE(account2.orders[1].type == proto::OrderType::limit);
    REQUIRE(account2.orders[1].price == 1.0);
    REQUIRE(account2.orders[1].volume == 100.0);
    REQUIRE(account2.orders[2].id == 3);
    REQUIRE(std::string(account2.orders[2].symbol) == "EURUSD");
    REQUIRE(account2.orders[2].side == proto::OrderSide::buy);
    REQUIRE(account2.orders[2].type == proto::OrderType::stop);
    REQUIRE(account2.orders[2].price == 1.5);
    REQUIRE(account2.orders[2].volume == 10.0);
}

TEST_CASE("Serialization (Final): struct simple", "[FBE]")
{
    // Create a new struct
    test::StructSimple struct1;

    // Serialize the struct to the FBE stream
    FBE::test::StructSimpleFinalModel writer;
    REQUIRE(writer.fbe_type() == 110);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 304);

    // Deserialize the struct from the FBE stream
    test::StructSimple struct2;
    FBE::test::StructSimpleFinalModel reader;
    REQUIRE(reader.fbe_type() == 110);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1 == false);
    REQUIRE(struct2.f2 == true);
    REQUIRE(struct2.f3 == 0);
    REQUIRE(struct2.f4 == 0xFF);
    REQUIRE(struct2.f5 == '\0');
    REQUIRE(struct2.f6 == '!');
    REQUIRE(struct2.f7 == 0);
    REQUIRE(struct2.f8 == 0x0444);
    REQUIRE(struct2.f9 == 0);
    REQUIRE(struct2.f10 == 127);
    REQUIRE(struct2.f11 == 0);
    REQUIRE(struct2.f12 == 0xFF);
    REQUIRE(struct2.f13 == 0);
    REQUIRE(struct2.f14 == 32767);
    REQUIRE(struct2.f15 == 0);
    REQUIRE(struct2.f16 == 0xFFFF);
    REQUIRE(struct2.f17 == 0);
    REQUIRE(struct2.f18 == 2147483647);
    REQUIRE(struct2.f19 == 0);
    REQUIRE(struct2.f20 == 0xFFFFFFFF);
    REQUIRE(struct2.f21 == 0);
    REQUIRE(struct2.f22 == 9223372036854775807ll);
    REQUIRE(struct2.f23 == 0);
    REQUIRE(struct2.f24 == 0xFFFFFFFFFFFFFFFFull);
    REQUIRE(struct2.f25 == 0.0f);
    REQUIRE(std::abs(struct2.f26 - 123.456f) < 0.0001);
    REQUIRE(struct2.f27 == 0.0);
    REQUIRE(std::abs(struct2.f28 - -123.567e+123) < 1e+123);
    REQUIRE(struct2.f29 == 0.0);
    REQUIRE(struct2.f30 == 123456.123456);
    REQUIRE(struct2.f31 == "");
    REQUIRE(struct2.f32 == "Initial string!");
    REQUIRE(struct2.f33 == 0);
    REQUIRE(struct2.f34 == 0);
    REQUIRE(struct2.f35 > 1514764800000000000);
    REQUIRE(struct2.f36 == FBE::uuid_t());
    REQUIRE(struct2.f37 != FBE::uuid_t());
    REQUIRE(struct2.f38 == FBE::uuid_t("123e4567-e89b-12d3-a456-426655440000"));

    REQUIRE(struct2.f1 == struct1.f1);
    REQUIRE(struct2.f2 == struct1.f2);
    REQUIRE(struct2.f3 == struct1.f3);
    REQUIRE(struct2.f4 == struct1.f4);
    REQUIRE(struct2.f5 == struct1.f5);
    REQUIRE(struct2.f6 == struct1.f6);
    REQUIRE(struct2.f7 == struct1.f7);
    REQUIRE(struct2.f8 == struct1.f8);
    REQUIRE(struct2.f9 == struct1.f9);
    REQUIRE(struct2.f10 == struct1.f10);
    REQUIRE(struct2.f11 == struct1.f11);
    REQUIRE(struct2.f12 == struct1.f12);
    REQUIRE(struct2.f13 == struct1.f13);
    REQUIRE(struct2.f14 == struct1.f14);
    REQUIRE(struct2.f15 == struct1.f15);
    REQUIRE(struct2.f16 == struct1.f16);
    REQUIRE(struct2.f17 == struct1.f17);
    REQUIRE(struct2.f18 == struct1.f18);
    REQUIRE(struct2.f19 == struct1.f19);
    REQUIRE(struct2.f20 == struct1.f20);
    REQUIRE(struct2.f21 == struct1.f21);
    REQUIRE(struct2.f22 == struct1.f22);
    REQUIRE(struct2.f23 == struct1.f23);
    REQUIRE(struct2.f24 == struct1.f24);
    REQUIRE(struct2.f25 == struct1.f25);
    REQUIRE(struct2.f26 == struct1.f26);
    REQUIRE(struct2.f27 == struct1.f27);
    REQUIRE(struct2.f28 == struct1.f28);
    REQUIRE(struct2.f29 == struct1.f29);
    REQUIRE(struct2.f30 == struct1.f30);
    REQUIRE(struct2.f31 == struct1.f31);
    REQUIRE(struct2.f32 == struct1.f32);
    REQUIRE(struct2.f33 == struct1.f33);
    REQUIRE(struct2.f34 == struct1.f34);
    REQUIRE(struct2.f35 == struct1.f35);
    REQUIRE(struct2.f36 == struct1.f36);
    REQUIRE(struct2.f37 == struct1.f37);
    REQUIRE(struct2.f38 == struct1.f38);
    REQUIRE(struct2.f39 == struct1.f39);
    REQUIRE(struct2.f40 == struct1.f40);
}

TEST_CASE("Serialization (Final): struct optional", "[FBE]")
{
    // Create a new struct
    test::StructOptional struct1;

    // Serialize the struct to the FBE stream
    FBE::test::StructOptionalFinalModel writer;
    REQUIRE(writer.fbe_type() == 111);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 478);

    // Deserialize the struct from the FBE stream
    test::StructOptional struct2;
    FBE::test::StructOptionalFinalModel reader;
    REQUIRE(reader.fbe_type() == 111);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1 == false);
    REQUIRE(struct2.f2 == true);
    REQUIRE(struct2.f3 == 0);
    REQUIRE(struct2.f4 == 0xFF);
    REQUIRE(struct2.f5 == '\0');
    REQUIRE(struct2.f6 == '!');
    REQUIRE(struct2.f7 == 0);
    REQUIRE(struct2.f8 == 0x0444);
    REQUIRE(struct2.f9 == 0);
    REQUIRE(struct2.f10 == 127);
    REQUIRE(struct2.f11 == 0);
    REQUIRE(struct2.f12 == 0xFF);
    REQUIRE(struct2.f13 == 0);
    REQUIRE(struct2.f14 == 32767);
    REQUIRE(struct2.f15 == 0);
    REQUIRE(struct2.f16 == 0xFFFF);
    REQUIRE(struct2.f17 == 0);
    REQUIRE(struct2.f18 == 2147483647);
    REQUIRE(struct2.f19 == 0);
    REQUIRE(struct2.f20 == 0xFFFFFFFF);
    REQUIRE(struct2.f21 == 0);
    REQUIRE(struct2.f22 == 9223372036854775807ll);
    REQUIRE(struct2.f23 == 0);
    REQUIRE(struct2.f24 == 0xFFFFFFFFFFFFFFFFull);
    REQUIRE(struct2.f25 == 0.0f);
    REQUIRE(std::abs(struct2.f26 - 123.456f) < 0.0001);
    REQUIRE(struct2.f27 == 0.0);
    REQUIRE(std::abs(struct2.f28 - -123.567e+123) < 1e+123);
    REQUIRE(struct2.f29 == 0.0);
    REQUIRE(struct2.f30 == 123456.123456);
    REQUIRE(struct2.f31 == "");
    REQUIRE(struct2.f32 == "Initial string!");
    REQUIRE(struct2.f33 == 0);
    REQUIRE(struct2.f34 == 0);
    REQUIRE(struct2.f35 > 1514764800000000000);
    REQUIRE(struct2.f36 == FBE::uuid_t());
    REQUIRE(struct2.f37 != FBE::uuid_t());
    REQUIRE(struct2.f38 == FBE::uuid_t("123e4567-e89b-12d3-a456-426655440000"));

    REQUIRE(!struct2.f100.has_value());
    REQUIRE(struct2.f101.has_value());
    REQUIRE(struct2.f101.value() == true);
    REQUIRE(!struct2.f102.has_value());
    REQUIRE(!struct2.f103.has_value());
    REQUIRE(struct2.f104.has_value());
    REQUIRE(struct2.f104.value() == 0xFF);
    REQUIRE(!struct2.f105.has_value());
    REQUIRE(!struct2.f106.has_value());
    REQUIRE(struct2.f107.has_value());
    REQUIRE(struct2.f107.value() == '!');
    REQUIRE(!struct2.f108.has_value());
    REQUIRE(!struct2.f109.has_value());
    REQUIRE(struct2.f110.has_value());
    REQUIRE(struct2.f110.value() == 0x0444);
    REQUIRE(!struct2.f111.has_value());
    REQUIRE(!struct2.f112.has_value());
    REQUIRE(struct2.f113.has_value());
    REQUIRE(struct2.f113.value() == 127);
    REQUIRE(!struct2.f114.has_value());
    REQUIRE(!struct2.f115.has_value());
    REQUIRE(struct2.f116.has_value());
    REQUIRE(struct2.f116.value() == 0xFF);
    REQUIRE(!struct2.f117.has_value());
    REQUIRE(!struct2.f118.has_value());
    REQUIRE(struct2.f119.has_value());
    REQUIRE(struct2.f119.value() == 32767);
    REQUIRE(!struct2.f120.has_value());
    REQUIRE(!struct2.f121.has_value());
    REQUIRE(struct2.f122.has_value());
    REQUIRE(struct2.f122.value() == 0xFFFF);
    REQUIRE(!struct2.f123.has_value());
    REQUIRE(!struct2.f124.has_value());
    REQUIRE(struct2.f125.has_value());
    REQUIRE(struct2.f125.value() == 2147483647);
    REQUIRE(!struct2.f126.has_value());
    REQUIRE(!struct2.f127.has_value());
    REQUIRE(struct2.f128.has_value());
    REQUIRE(struct2.f128.value() == 0xFFFFFFFF);
    REQUIRE(!struct2.f129.has_value());
    REQUIRE(!struct2.f130.has_value());
    REQUIRE(struct2.f131.has_value());
    REQUIRE(struct2.f131.value() == 9223372036854775807ll);
    REQUIRE(!struct2.f132.has_value());
    REQUIRE(!struct2.f133.has_value());
    REQUIRE(struct2.f131.has_value());
    REQUIRE(struct2.f134.value() == 0xFFFFFFFFFFFFFFFFull);
    REQUIRE(!struct2.f135.has_value());
    REQUIRE(!struct2.f136.has_value());
    REQUIRE(struct2.f137.has_value());
    REQUIRE(std::abs(struct2.f137.value() - 123.456f) < 0.0001);
    REQUIRE(!struct2.f138.has_value());
    REQUIRE(!struct2.f139.has_value());
    REQUIRE(struct2.f140.has_value());
    REQUIRE(std::abs(struct2.f140.value() - -123.567e+123) < 1e+123);
    REQUIRE(!struct2.f141.has_value());
    REQUIRE(!struct2.f142.has_value());
    REQUIRE(struct2.f143.has_value());
    REQUIRE(struct2.f143.value() == 123456.123456);
    REQUIRE(!struct2.f144.has_value());
    REQUIRE(!struct2.f145.has_value());
    REQUIRE(struct2.f146.has_value());
    REQUIRE(struct2.f146.value() == "Initial string!");
    REQUIRE(!struct2.f147.has_value());
    REQUIRE(!struct2.f148.has_value());
    REQUIRE(struct2.f149.has_value());
    REQUIRE(struct2.f149.value() > 1514764800000000000);
    REQUIRE(!struct2.f150.has_value());
    REQUIRE(!struct2.f151.has_value());
    REQUIRE(struct2.f152.has_value());
    REQUIRE(struct2.f152.value() == FBE::uuid_t("123e4567-e89b-12d3-a456-426655440000"));
    REQUIRE(!struct2.f153.has_value());
    REQUIRE(!struct2.f154.has_value());
    REQUIRE(!struct2.f155.has_value());
    REQUIRE(!struct2.f156.has_value());
    REQUIRE(!struct2.f157.has_value());
    REQUIRE(!struct2.f158.has_value());
    REQUIRE(!struct2.f159.has_value());
    REQUIRE(!struct2.f160.has_value());
    REQUIRE(!struct2.f161.has_value());
    REQUIRE(!struct2.f162.has_value());
    REQUIRE(!struct2.f163.has_value());
    REQUIRE(!struct2.f164.has_value());
    REQUIRE(!struct2.f165.has_value());

    REQUIRE(struct2.f1 == struct1.f1);
    REQUIRE(struct2.f2 == struct1.f2);
    REQUIRE(struct2.f3 == struct1.f3);
    REQUIRE(struct2.f4 == struct1.f4);
    REQUIRE(struct2.f5 == struct1.f5);
    REQUIRE(struct2.f6 == struct1.f6);
    REQUIRE(struct2.f7 == struct1.f7);
    REQUIRE(struct2.f8 == struct1.f8);
    REQUIRE(struct2.f9 == struct1.f9);
    REQUIRE(struct2.f10 == struct1.f10);
    REQUIRE(struct2.f11 == struct1.f11);
    REQUIRE(struct2.f12 == struct1.f12);
    REQUIRE(struct2.f13 == struct1.f13);
    REQUIRE(struct2.f14 == struct1.f14);
    REQUIRE(struct2.f15 == struct1.f15);
    REQUIRE(struct2.f16 == struct1.f16);
    REQUIRE(struct2.f17 == struct1.f17);
    REQUIRE(struct2.f18 == struct1.f18);
    REQUIRE(struct2.f19 == struct1.f19);
    REQUIRE(struct2.f20 == struct1.f20);
    REQUIRE(struct2.f21 == struct1.f21);
    REQUIRE(struct2.f22 == struct1.f22);
    REQUIRE(struct2.f23 == struct1.f23);
    REQUIRE(struct2.f24 == struct1.f24);
    REQUIRE(struct2.f25 == struct1.f25);
    REQUIRE(struct2.f26 == struct1.f26);
    REQUIRE(struct2.f27 == struct1.f27);
    REQUIRE(struct2.f28 == struct1.f28);
    REQUIRE(struct2.f29 == struct1.f29);
    REQUIRE(struct2.f30 == struct1.f30);
    REQUIRE(struct2.f31 == struct1.f31);
    REQUIRE(struct2.f32 == struct1.f32);
    REQUIRE(struct2.f33 == struct1.f33);
    REQUIRE(struct2.f34 == struct1.f34);
    REQUIRE(struct2.f35 == struct1.f35);
    REQUIRE(struct2.f36 == struct1.f36);
    REQUIRE(struct2.f37 == struct1.f37);
    REQUIRE(struct2.f38 == struct1.f38);
    REQUIRE(struct2.f39 == struct1.f39);
    REQUIRE(struct2.f40 == struct1.f40);

    REQUIRE(struct2.f100 == struct1.f100);
    REQUIRE(struct2.f101 == struct1.f101);
    REQUIRE(struct2.f102 == struct1.f102);
    REQUIRE(struct2.f103 == struct1.f103);
    REQUIRE(struct2.f104 == struct1.f104);
    REQUIRE(struct2.f105 == struct1.f105);
    REQUIRE(struct2.f106 == struct1.f106);
    REQUIRE(struct2.f107 == struct1.f107);
    REQUIRE(struct2.f108 == struct1.f108);
    REQUIRE(struct2.f109 == struct1.f109);
    REQUIRE(struct2.f110 == struct1.f110);
    REQUIRE(struct2.f111 == struct1.f111);
    REQUIRE(struct2.f112 == struct1.f112);
    REQUIRE(struct2.f113 == struct1.f113);
    REQUIRE(struct2.f114 == struct1.f114);
    REQUIRE(struct2.f115 == struct1.f115);
    REQUIRE(struct2.f116 == struct1.f116);
    REQUIRE(struct2.f117 == struct1.f117);
    REQUIRE(struct2.f118 == struct1.f118);
    REQUIRE(struct2.f119 == struct1.f119);
    REQUIRE(struct2.f120 == struct1.f120);
    REQUIRE(struct2.f121 == struct1.f121);
    REQUIRE(struct2.f122 == struct1.f122);
    REQUIRE(struct2.f123 == struct1.f123);
    REQUIRE(struct2.f124 == struct1.f124);
    REQUIRE(struct2.f125 == struct1.f125);
    REQUIRE(struct2.f126 == struct1.f126);
    REQUIRE(struct2.f127 == struct1.f127);
    REQUIRE(struct2.f128 == struct1.f128);
    REQUIRE(struct2.f129 == struct1.f129);
    REQUIRE(struct2.f130 == struct1.f130);
    REQUIRE(struct2.f131 == struct1.f131);
    REQUIRE(struct2.f132 == struct1.f132);
    REQUIRE(struct2.f133 == struct1.f133);
    REQUIRE(struct2.f134 == struct1.f134);
    REQUIRE(struct2.f135 == struct1.f135);
    REQUIRE(struct2.f136 == struct1.f136);
    REQUIRE(struct2.f137 == struct1.f137);
    REQUIRE(struct2.f138 == struct1.f138);
    REQUIRE(struct2.f139 == struct1.f139);
    REQUIRE(struct2.f140 == struct1.f140);
    REQUIRE(struct2.f141 == struct1.f141);
    REQUIRE(struct2.f142 == struct1.f142);
    REQUIRE(struct2.f143 == struct1.f143);
    REQUIRE(struct2.f144 == struct1.f144);
    REQUIRE(struct2.f145 == struct1.f145);
    REQUIRE(struct2.f146 == struct1.f146);
    REQUIRE(struct2.f147 == struct1.f147);
    REQUIRE(struct2.f148 == struct1.f148);
    REQUIRE(struct2.f149 == struct1.f149);
    REQUIRE(struct2.f150 == struct1.f150);
    REQUIRE(struct2.f151 == struct1.f151);
    REQUIRE(struct2.f152 == struct1.f152);
    REQUIRE(struct2.f153 == struct1.f153);
    REQUIRE(struct2.f154 == struct1.f154);
    REQUIRE(struct2.f155 == struct1.f155);
    REQUIRE(struct2.f156 == struct1.f156);
    REQUIRE(struct2.f157 == struct1.f157);
}

TEST_CASE("Serialization (Final): struct nested", "[FBE]")
{
    // Create a new struct
    test::StructNested struct1;

    // Serialize the struct to the FBE stream
    FBE::test::StructNestedFinalModel writer;
    REQUIRE(writer.fbe_type() == 112);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 1267);

    // Deserialize the struct from the FBE stream
    test::StructNested struct2;
    FBE::test::StructNestedFinalModel reader;
    REQUIRE(reader.fbe_type() == 112);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1 == false);
    REQUIRE(struct2.f2 == true);
    REQUIRE(struct2.f3 == 0);
    REQUIRE(struct2.f4 == 0xFF);
    REQUIRE(struct2.f5 == '\0');
    REQUIRE(struct2.f6 == '!');
    REQUIRE(struct2.f7 == 0);
    REQUIRE(struct2.f8 == 0x0444);
    REQUIRE(struct2.f9 == 0);
    REQUIRE(struct2.f10 == 127);
    REQUIRE(struct2.f11 == 0);
    REQUIRE(struct2.f12 == 0xFF);
    REQUIRE(struct2.f13 == 0);
    REQUIRE(struct2.f14 == 32767);
    REQUIRE(struct2.f15 == 0);
    REQUIRE(struct2.f16 == 0xFFFF);
    REQUIRE(struct2.f17 == 0);
    REQUIRE(struct2.f18 == 2147483647);
    REQUIRE(struct2.f19 == 0);
    REQUIRE(struct2.f20 == 0xFFFFFFFF);
    REQUIRE(struct2.f21 == 0);
    REQUIRE(struct2.f22 == 9223372036854775807ll);
    REQUIRE(struct2.f23 == 0);
    REQUIRE(struct2.f24 == 0xFFFFFFFFFFFFFFFFull);
    REQUIRE(struct2.f25 == 0.0f);
    REQUIRE(std::abs(struct2.f26 - 123.456f) < 0.0001);
    REQUIRE(struct2.f27 == 0.0);
    REQUIRE(std::abs(struct2.f28 - -123.567e+123) < 1e+123);
    REQUIRE(struct2.f29 == 0.0);
    REQUIRE(struct2.f30 == 123456.123456);
    REQUIRE(struct2.f31 == "");
    REQUIRE(struct2.f32 == "Initial string!");
    REQUIRE(struct2.f33 == 0);
    REQUIRE(struct2.f34 == 0);
    REQUIRE(struct2.f35 > 1514764800000000000);
    REQUIRE(struct2.f36 == FBE::uuid_t());
    REQUIRE(struct2.f37 != FBE::uuid_t());
    REQUIRE(struct2.f38 == FBE::uuid_t("123e4567-e89b-12d3-a456-426655440000"));

    REQUIRE(!struct2.f100.has_value());
    REQUIRE(struct2.f101.has_value());
    REQUIRE(struct2.f101.value() == true);
    REQUIRE(!struct2.f102.has_value());
    REQUIRE(!struct2.f103.has_value());
    REQUIRE(struct2.f104.has_value());
    REQUIRE(struct2.f104.value() == 0xFF);
    REQUIRE(!struct2.f105.has_value());
    REQUIRE(!struct2.f106.has_value());
    REQUIRE(struct2.f107.has_value());
    REQUIRE(struct2.f107.value() == '!');
    REQUIRE(!struct2.f108.has_value());
    REQUIRE(!struct2.f109.has_value());
    REQUIRE(struct2.f110.has_value());
    REQUIRE(struct2.f110.value() == 0x0444);
    REQUIRE(!struct2.f111.has_value());
    REQUIRE(!struct2.f112.has_value());
    REQUIRE(struct2.f113.has_value());
    REQUIRE(struct2.f113.value() == 127);
    REQUIRE(!struct2.f114.has_value());
    REQUIRE(!struct2.f115.has_value());
    REQUIRE(struct2.f116.has_value());
    REQUIRE(struct2.f116.value() == 0xFF);
    REQUIRE(!struct2.f117.has_value());
    REQUIRE(!struct2.f118.has_value());
    REQUIRE(struct2.f119.has_value());
    REQUIRE(struct2.f119.value() == 32767);
    REQUIRE(!struct2.f120.has_value());
    REQUIRE(!struct2.f121.has_value());
    REQUIRE(struct2.f122.has_value());
    REQUIRE(struct2.f122.value() == 0xFFFF);
    REQUIRE(!struct2.f123.has_value());
    REQUIRE(!struct2.f124.has_value());
    REQUIRE(struct2.f125.has_value());
    REQUIRE(struct2.f125.value() == 2147483647);
    REQUIRE(!struct2.f126.has_value());
    REQUIRE(!struct2.f127.has_value());
    REQUIRE(struct2.f128.has_value());
    REQUIRE(struct2.f128.value() == 0xFFFFFFFF);
    REQUIRE(!struct2.f129.has_value());
    REQUIRE(!struct2.f130.has_value());
    REQUIRE(struct2.f131.has_value());
    REQUIRE(struct2.f131.value() == 9223372036854775807ll);
    REQUIRE(!struct2.f132.has_value());
    REQUIRE(!struct2.f133.has_value());
    REQUIRE(struct2.f131.has_value());
    REQUIRE(struct2.f134.value() == 0xFFFFFFFFFFFFFFFFull);
    REQUIRE(!struct2.f135.has_value());
    REQUIRE(!struct2.f136.has_value());
    REQUIRE(struct2.f137.has_value());
    REQUIRE(std::abs(struct2.f137.value() - 123.456f) < 0.0001);
    REQUIRE(!struct2.f138.has_value());
    REQUIRE(!struct2.f139.has_value());
    REQUIRE(struct2.f140.has_value());
    REQUIRE(std::abs(struct2.f140.value() - -123.567e+123) < 1e+123);
    REQUIRE(!struct2.f141.has_value());
    REQUIRE(!struct2.f142.has_value());
    REQUIRE(struct2.f143.has_value());
    REQUIRE(struct2.f143.value() == 123456.123456);
    REQUIRE(!struct2.f144.has_value());
    REQUIRE(!struct2.f145.has_value());
    REQUIRE(struct2.f146.has_value());
    REQUIRE(struct2.f146.value() == "Initial string!");
    REQUIRE(!struct2.f147.has_value());
    REQUIRE(!struct2.f148.has_value());
    REQUIRE(struct2.f149.has_value());
    REQUIRE(struct2.f149.value() > 1514764800000000000);
    REQUIRE(!struct2.f150.has_value());
    REQUIRE(!struct2.f151.has_value());
    REQUIRE(struct2.f152.has_value());
    REQUIRE(struct2.f152.value() == FBE::uuid_t("123e4567-e89b-12d3-a456-426655440000"));
    REQUIRE(!struct2.f153.has_value());
    REQUIRE(!struct2.f154.has_value());
    REQUIRE(!struct2.f155.has_value());
    REQUIRE(!struct2.f156.has_value());
    REQUIRE(!struct2.f157.has_value());
    REQUIRE(!struct2.f158.has_value());
    REQUIRE(!struct2.f159.has_value());
    REQUIRE(!struct2.f160.has_value());
    REQUIRE(!struct2.f161.has_value());
    REQUIRE(!struct2.f162.has_value());
    REQUIRE(!struct2.f163.has_value());
    REQUIRE(!struct2.f164.has_value());
    REQUIRE(!struct2.f165.has_value());

    REQUIRE(struct2.f1000 == test::EnumSimple::ENUM_VALUE_0);
    REQUIRE(!struct2.f1001.has_value());
    REQUIRE(struct2.f1002 == test::EnumTyped::ENUM_VALUE_2);
    REQUIRE(!struct2.f1003.has_value());
    REQUIRE(struct2.f1004 == test::FlagsSimple::FLAG_VALUE_0);
    REQUIRE(!struct2.f1005.has_value());
    REQUIRE(struct2.f1006 == (test::FlagsTyped::FLAG_VALUE_2 | test::FlagsTyped::FLAG_VALUE_4 | test::FlagsTyped::FLAG_VALUE_6));
    REQUIRE(!struct2.f1007.has_value());
    REQUIRE(!struct2.f1009.has_value());
    REQUIRE(!struct2.f1011.has_value());

    REQUIRE(struct2.f1 == struct1.f1);
    REQUIRE(struct2.f2 == struct1.f2);
    REQUIRE(struct2.f3 == struct1.f3);
    REQUIRE(struct2.f4 == struct1.f4);
    REQUIRE(struct2.f5 == struct1.f5);
    REQUIRE(struct2.f6 == struct1.f6);
    REQUIRE(struct2.f7 == struct1.f7);
    REQUIRE(struct2.f8 == struct1.f8);
    REQUIRE(struct2.f9 == struct1.f9);
    REQUIRE(struct2.f10 == struct1.f10);
    REQUIRE(struct2.f11 == struct1.f11);
    REQUIRE(struct2.f12 == struct1.f12);
    REQUIRE(struct2.f13 == struct1.f13);
    REQUIRE(struct2.f14 == struct1.f14);
    REQUIRE(struct2.f15 == struct1.f15);
    REQUIRE(struct2.f16 == struct1.f16);
    REQUIRE(struct2.f17 == struct1.f17);
    REQUIRE(struct2.f18 == struct1.f18);
    REQUIRE(struct2.f19 == struct1.f19);
    REQUIRE(struct2.f20 == struct1.f20);
    REQUIRE(struct2.f21 == struct1.f21);
    REQUIRE(struct2.f22 == struct1.f22);
    REQUIRE(struct2.f23 == struct1.f23);
    REQUIRE(struct2.f24 == struct1.f24);
    REQUIRE(struct2.f25 == struct1.f25);
    REQUIRE(struct2.f26 == struct1.f26);
    REQUIRE(struct2.f27 == struct1.f27);
    REQUIRE(struct2.f28 == struct1.f28);
    REQUIRE(struct2.f29 == struct1.f29);
    REQUIRE(struct2.f30 == struct1.f30);
    REQUIRE(struct2.f31 == struct1.f31);
    REQUIRE(struct2.f32 == struct1.f32);
    REQUIRE(struct2.f33 == struct1.f33);
    REQUIRE(struct2.f34 == struct1.f34);
    REQUIRE(struct2.f35 == struct1.f35);
    REQUIRE(struct2.f36 == struct1.f36);
    REQUIRE(struct2.f37 == struct1.f37);
    REQUIRE(struct2.f38 == struct1.f38);
    REQUIRE(struct2.f39 == struct1.f39);
    REQUIRE(struct2.f40 == struct1.f40);

    REQUIRE(struct2.f100 == struct1.f100);
    REQUIRE(struct2.f101 == struct1.f101);
    REQUIRE(struct2.f102 == struct1.f102);
    REQUIRE(struct2.f103 == struct1.f103);
    REQUIRE(struct2.f104 == struct1.f104);
    REQUIRE(struct2.f105 == struct1.f105);
    REQUIRE(struct2.f106 == struct1.f106);
    REQUIRE(struct2.f107 == struct1.f107);
    REQUIRE(struct2.f108 == struct1.f108);
    REQUIRE(struct2.f109 == struct1.f109);
    REQUIRE(struct2.f110 == struct1.f110);
    REQUIRE(struct2.f111 == struct1.f111);
    REQUIRE(struct2.f112 == struct1.f112);
    REQUIRE(struct2.f113 == struct1.f113);
    REQUIRE(struct2.f114 == struct1.f114);
    REQUIRE(struct2.f115 == struct1.f115);
    REQUIRE(struct2.f116 == struct1.f116);
    REQUIRE(struct2.f117 == struct1.f117);
    REQUIRE(struct2.f118 == struct1.f118);
    REQUIRE(struct2.f119 == struct1.f119);
    REQUIRE(struct2.f120 == struct1.f120);
    REQUIRE(struct2.f121 == struct1.f121);
    REQUIRE(struct2.f122 == struct1.f122);
    REQUIRE(struct2.f123 == struct1.f123);
    REQUIRE(struct2.f124 == struct1.f124);
    REQUIRE(struct2.f125 == struct1.f125);
    REQUIRE(struct2.f126 == struct1.f126);
    REQUIRE(struct2.f127 == struct1.f127);
    REQUIRE(struct2.f128 == struct1.f128);
    REQUIRE(struct2.f129 == struct1.f129);
    REQUIRE(struct2.f130 == struct1.f130);
    REQUIRE(struct2.f131 == struct1.f131);
    REQUIRE(struct2.f132 == struct1.f132);
    REQUIRE(struct2.f133 == struct1.f133);
    REQUIRE(struct2.f134 == struct1.f134);
    REQUIRE(struct2.f135 == struct1.f135);
    REQUIRE(struct2.f136 == struct1.f136);
    REQUIRE(struct2.f137 == struct1.f137);
    REQUIRE(struct2.f138 == struct1.f138);
    REQUIRE(struct2.f139 == struct1.f139);
    REQUIRE(struct2.f140 == struct1.f140);
    REQUIRE(struct2.f141 == struct1.f141);
    REQUIRE(struct2.f142 == struct1.f142);
    REQUIRE(struct2.f143 == struct1.f143);
    REQUIRE(struct2.f144 == struct1.f144);
    REQUIRE(struct2.f145 == struct1.f145);
    REQUIRE(struct2.f146 == struct1.f146);
    REQUIRE(struct2.f147 == struct1.f147);
    REQUIRE(struct2.f148 == struct1.f148);
    REQUIRE(struct2.f149 == struct1.f149);
    REQUIRE(struct2.f150 == struct1.f150);
    REQUIRE(struct2.f151 == struct1.f151);
    REQUIRE(struct2.f152 == struct1.f152);
    REQUIRE(struct2.f153 == struct1.f153);
    REQUIRE(struct2.f154 == struct1.f154);
    REQUIRE(struct2.f155 == struct1.f155);
    REQUIRE(struct2.f156 == struct1.f156);
    REQUIRE(struct2.f157 == struct1.f157);

    REQUIRE(struct2.f1000 == struct1.f1000);
    REQUIRE(struct2.f1001 == struct1.f1001);
    REQUIRE(struct2.f1002 == struct1.f1002);
    REQUIRE(struct2.f1003 == struct1.f1003);
    REQUIRE(struct2.f1004 == struct1.f1004);
    REQUIRE(struct2.f1005 == struct1.f1005);
    REQUIRE(struct2.f1006 == struct1.f1006);
    REQUIRE(struct2.f1007 == struct1.f1007);
}

TEST_CASE("Serialization (Final): struct bytes", "[FBE]")
{
    const char* f1 = "ABC";
    const char* f2 = "test";

    // Create a new struct
    test::StructBytes struct1;
    struct1.f1.assign((const uint8_t*)f1, (const uint8_t*)f1 + strlen(f1));
    struct1.f2.emplace();
    struct1.f2.value().assign((const uint8_t*)f2, (const uint8_t*)f2 + strlen(f2));

    // Serialize the struct to the FBE stream
    FBE::test::StructBytesFinalModel writer;
    REQUIRE(writer.fbe_type() == 120);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 25);

    // Deserialize the struct from the FBE stream
    test::StructBytes struct2;
    FBE::test::StructBytesFinalModel reader;
    REQUIRE(reader.fbe_type() == 120);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 3);
    REQUIRE(memcmp(f1, struct2.f1.data(), struct2.f1.size()) == 0);
    REQUIRE(struct2.f2.has_value());
    REQUIRE(struct2.f2.value().size() == 4);
    REQUIRE(memcmp(f2, struct2.f2.value().data(), struct2.f2.value().size()) == 0);
    REQUIRE(!struct2.f3.has_value());
}

TEST_CASE("Serialization (Final): struct array", "[FBE]")
{
    // Create a new struct
    test::StructArray struct1;
    struct1.f1[0] = (uint8_t)48;
    struct1.f1[1] = (uint8_t)65;
    struct1.f2[0] = (uint8_t)97;
    struct1.f2[1] = std::nullopt;
    struct1.f3[0] = std::vector<uint8_t>(3, 48);
    struct1.f3[1] = std::vector<uint8_t>(3, 65);
    struct1.f4[0] = std::vector<uint8_t>(3, 97);
    struct1.f4[1] = std::nullopt;
    struct1.f5[0] = test::EnumSimple::ENUM_VALUE_1;
    struct1.f5[1] = test::EnumSimple::ENUM_VALUE_2;
    struct1.f6[0] = test::EnumSimple::ENUM_VALUE_1;
    struct1.f6[1] = std::nullopt;
    struct1.f7[0] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2;
    struct1.f7[1] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3;
    struct1.f8[0] = test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2;
    struct1.f8[1] = std::nullopt;
    struct1.f9[0] = test::StructSimple();
    struct1.f9[1] = test::StructSimple();
    struct1.f10[0] = test::StructSimple();
    struct1.f10[1] = std::nullopt;

    // Serialize the struct to the FBE stream
    FBE::test::StructArrayFinalModel writer;
    REQUIRE(writer.fbe_type() == 125);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 954);

    // Deserialize the struct from the FBE stream
    test::StructArray struct2;
    FBE::test::StructArrayFinalModel reader;
    REQUIRE(reader.fbe_type() == 125);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1[0] == 48);
    REQUIRE(struct2.f1[1] == 65);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2[0].value() == 97);
    REQUIRE(struct2.f2[1] == std::nullopt);
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3[0].size() == 3);
    REQUIRE(struct2.f3[0][0] == 48);
    REQUIRE(struct2.f3[0][1] == 48);
    REQUIRE(struct2.f3[0][2] == 48);
    REQUIRE(struct2.f3[1].size() == 3);
    REQUIRE(struct2.f3[1][0] == 65);
    REQUIRE(struct2.f3[1][1] == 65);
    REQUIRE(struct2.f3[1][2] == 65);
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4[0].has_value());
    REQUIRE(struct2.f4[0].value().size() == 3);
    REQUIRE(struct2.f4[0].value()[0] == 97);
    REQUIRE(struct2.f4[0].value()[1] == 97);
    REQUIRE(struct2.f4[0].value()[2] == 97);
    REQUIRE(struct2.f4[1] == std::nullopt);
    REQUIRE(struct2.f5.size() == 2);
    REQUIRE(struct2.f5[0] == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f5[1] == test::EnumSimple::ENUM_VALUE_2);
    REQUIRE(struct2.f6.size() == 2);
    REQUIRE(struct2.f6[0].value() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f6[1] == std::nullopt);
    REQUIRE(struct2.f7.size() == 2);
    REQUIRE(struct2.f7[0] == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f7[1] == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3));
    REQUIRE(struct2.f8.size() == 2);
    REQUIRE(struct2.f8[0].value() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f8[1] == std::nullopt);
    REQUIRE(struct2.f9.size() == 2);
    REQUIRE(struct2.f9[0].f2 == true);
    REQUIRE(struct2.f9[0].f12 == 255);
    REQUIRE(struct2.f9[0].f32 == "Initial string!");
    REQUIRE(struct2.f9[1].f2 == true);
    REQUIRE(struct2.f9[1].f12 == 255);
    REQUIRE(struct2.f9[1].f32 == "Initial string!");
    REQUIRE(struct2.f10.size() == 2);
    REQUIRE(struct2.f10[0].has_value());
    REQUIRE(struct2.f10[0].value().f2 == true);
    REQUIRE(struct2.f10[0].value().f12 == 255);
    REQUIRE(struct2.f10[0].value().f32 == "Initial string!");
    REQUIRE(struct2.f10[1] == std::nullopt);
}

TEST_CASE("Serialization (Final): struct vector", "[FBE]")
{
    // Create a new struct
    test::StructVector struct1;
    struct1.f1.emplace_back((uint8_t)48);
    struct1.f1.emplace_back((uint8_t)65);
    struct1.f2.emplace_back((uint8_t)97);
    struct1.f2.emplace_back(std::nullopt);
    struct1.f3.emplace_back(std::vector<uint8_t>(3, 48));
    struct1.f3.emplace_back(std::vector<uint8_t>(3, 65));
    struct1.f4.emplace_back(std::vector<uint8_t>(3, 97));
    struct1.f4.emplace_back(std::nullopt);
    struct1.f5.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct1.f5.emplace_back(test::EnumSimple::ENUM_VALUE_2);
    struct1.f6.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct1.f6.emplace_back(std::nullopt);
    struct1.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct1.f8.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f8.emplace_back(std::nullopt);
    struct1.f9.emplace_back(test::StructSimple());
    struct1.f9.emplace_back(test::StructSimple());
    struct1.f10.emplace_back(test::StructSimple());
    struct1.f10.emplace_back(std::nullopt);

    // Serialize the struct to the FBE stream
    FBE::test::StructVectorFinalModel writer;
    REQUIRE(writer.fbe_type() == 130);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 994);

    // Deserialize the struct from the FBE stream
    test::StructVector struct2;
    FBE::test::StructVectorFinalModel reader;
    REQUIRE(reader.fbe_type() == 130);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1[0] == 48);
    REQUIRE(struct2.f1[1] == 65);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2[0].value() == 97);
    REQUIRE(struct2.f2[1] == std::nullopt);
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3[0].size() == 3);
    REQUIRE(struct2.f3[0][0] == 48);
    REQUIRE(struct2.f3[0][1] == 48);
    REQUIRE(struct2.f3[0][2] == 48);
    REQUIRE(struct2.f3[1].size() == 3);
    REQUIRE(struct2.f3[1][0] == 65);
    REQUIRE(struct2.f3[1][1] == 65);
    REQUIRE(struct2.f3[1][2] == 65);
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4[0].has_value());
    REQUIRE(struct2.f4[0].value().size() == 3);
    REQUIRE(struct2.f4[0].value()[0] == 97);
    REQUIRE(struct2.f4[0].value()[1] == 97);
    REQUIRE(struct2.f4[0].value()[2] == 97);
    REQUIRE(struct2.f4[1] == std::nullopt);
    REQUIRE(struct2.f5.size() == 2);
    REQUIRE(struct2.f5[0] == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f5[1] == test::EnumSimple::ENUM_VALUE_2);
    REQUIRE(struct2.f6.size() == 2);
    REQUIRE(struct2.f6[0].value() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f6[1] == std::nullopt);
    REQUIRE(struct2.f7.size() == 2);
    REQUIRE(struct2.f7[0] == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f7[1] == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3));
    REQUIRE(struct2.f8.size() == 2);
    REQUIRE(struct2.f8[0].value() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f8[1] == std::nullopt);
    REQUIRE(struct2.f9.size() == 2);
    REQUIRE(struct2.f9[0].f2 == true);
    REQUIRE(struct2.f9[0].f12 == 255);
    REQUIRE(struct2.f9[0].f32 == "Initial string!");
    REQUIRE(struct2.f9[1].f2 == true);
    REQUIRE(struct2.f9[1].f12 == 255);
    REQUIRE(struct2.f9[1].f32 == "Initial string!");
    REQUIRE(struct2.f10.size() == 2);
    REQUIRE(struct2.f10[0].has_value());
    REQUIRE(struct2.f10[0].value().f2 == true);
    REQUIRE(struct2.f10[0].value().f12 == 255);
    REQUIRE(struct2.f10[0].value().f32 == "Initial string!");
    REQUIRE(struct2.f10[1] == std::nullopt);
}

TEST_CASE("Serialization (Final): struct list", "[FBE]")
{
    // Create a new struct
    test::StructList struct1;
    struct1.f1.emplace_back((uint8_t)48);
    struct1.f1.emplace_back((uint8_t)65);
    struct1.f2.emplace_back((uint8_t)97);
    struct1.f2.emplace_back(std::nullopt);
    struct1.f3.emplace_back(std::vector<uint8_t>(3, 48));
    struct1.f3.emplace_back(std::vector<uint8_t>(3, 65));
    struct1.f4.emplace_back(std::vector<uint8_t>(3, 97));
    struct1.f4.emplace_back(std::nullopt);
    struct1.f5.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct1.f5.emplace_back(test::EnumSimple::ENUM_VALUE_2);
    struct1.f6.emplace_back(test::EnumSimple::ENUM_VALUE_1);
    struct1.f6.emplace_back(std::nullopt);
    struct1.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f7.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct1.f8.emplace_back(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f8.emplace_back(std::nullopt);
    struct1.f9.emplace_back(test::StructSimple());
    struct1.f9.emplace_back(test::StructSimple());
    struct1.f10.emplace_back(test::StructSimple());
    struct1.f10.emplace_back(std::nullopt);

    // Serialize the struct to the FBE stream
    FBE::test::StructListFinalModel writer;
    REQUIRE(writer.fbe_type() == 131);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 994);

    // Deserialize the struct from the FBE stream
    test::StructList struct2;
    FBE::test::StructListFinalModel reader;
    REQUIRE(reader.fbe_type() == 131);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1.front() == 48);
    REQUIRE(struct2.f1.back() == 65);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2.front().value() == 97);
    REQUIRE(struct2.f2.back() == std::nullopt);
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3.front().size() == 3);
    REQUIRE(struct2.f3.front()[0] == 48);
    REQUIRE(struct2.f3.front()[1] == 48);
    REQUIRE(struct2.f3.front()[2] == 48);
    REQUIRE(struct2.f3.back().size() == 3);
    REQUIRE(struct2.f3.back()[0] == 65);
    REQUIRE(struct2.f3.back()[1] == 65);
    REQUIRE(struct2.f3.back()[2] == 65);
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4.front().has_value());
    REQUIRE(struct2.f4.front().value().size() == 3);
    REQUIRE(struct2.f4.front().value()[0] == 97);
    REQUIRE(struct2.f4.front().value()[1] == 97);
    REQUIRE(struct2.f4.front().value()[2] == 97);
    REQUIRE(struct2.f4.back() == std::nullopt);
    REQUIRE(struct2.f5.size() == 2);
    REQUIRE(struct2.f5.front() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f5.back() == test::EnumSimple::ENUM_VALUE_2);
    REQUIRE(struct2.f6.size() == 2);
    REQUIRE(struct2.f6.front().value() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f6.back() == std::nullopt);
    REQUIRE(struct2.f7.size() == 2);
    REQUIRE(struct2.f7.front() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f7.back() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3));
    REQUIRE(struct2.f8.size() == 2);
    REQUIRE(struct2.f8.front().value() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f8.back() == std::nullopt);
    REQUIRE(struct2.f9.size() == 2);
    REQUIRE(struct2.f9.front().f2 == true);
    REQUIRE(struct2.f9.front().f12 == 255);
    REQUIRE(struct2.f9.front().f32 == "Initial string!");
    REQUIRE(struct2.f9.back().f2 == true);
    REQUIRE(struct2.f9.back().f12 == 255);
    REQUIRE(struct2.f9.back().f32 == "Initial string!");
    REQUIRE(struct2.f10.size() == 2);
    REQUIRE(struct2.f10.front().has_value());
    REQUIRE(struct2.f10.front().value().f2 == true);
    REQUIRE(struct2.f10.front().value().f12 == 255);
    REQUIRE(struct2.f10.front().value().f32 == "Initial string!");
    REQUIRE(struct2.f10.back() == std::nullopt);
}

TEST_CASE("Serialization (Final): struct set", "[FBE]")
{
    // Create a new struct
    test::StructSet struct1;
    struct1.f1.emplace((uint8_t)48);
    struct1.f1.emplace((uint8_t)65);
    struct1.f1.emplace((uint8_t)97);
    struct1.f2.emplace(test::EnumSimple::ENUM_VALUE_1);
    struct1.f2.emplace(test::EnumSimple::ENUM_VALUE_2);
    struct1.f3.emplace(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f3.emplace(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    test::StructSimple s1;
    s1.id = 48;
    struct1.f4.emplace(s1);
    test::StructSimple s2;
    s2.id = 65;
    struct1.f4.emplace(s2);

    // Serialize the struct to the FBE stream
    FBE::test::StructSetFinalModel writer;
    REQUIRE(writer.fbe_type() == 132);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 635);

    // Deserialize the struct from the FBE stream
    test::StructSet struct2;
    FBE::test::StructSetFinalModel reader;
    REQUIRE(reader.fbe_type() == 132);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 3);
    REQUIRE(struct2.f1.find((uint8_t)48) != struct2.f1.end());
    REQUIRE(struct2.f1.find((uint8_t)65) != struct2.f1.end());
    REQUIRE(struct2.f1.find((uint8_t)97) != struct2.f1.end());
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2.find(test::EnumSimple::ENUM_VALUE_1) != struct2.f2.end());
    REQUIRE(struct2.f2.find(test::EnumSimple::ENUM_VALUE_2) != struct2.f2.end());
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3.find(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2) != struct2.f3.end());
    REQUIRE(struct2.f3.find(test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3) != struct2.f3.end());
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4.find(s1) != struct2.f4.end());
    REQUIRE(struct2.f4.find(s2) != struct2.f4.end());
}

TEST_CASE("Serialization (Final): struct map", "[FBE]")
{
    // Create a new struct
    test::StructMap struct1;
    struct1.f1.emplace(10, (uint8_t)48);
    struct1.f1.emplace(20, (uint8_t)65);
    struct1.f2.emplace(10, (uint8_t)97);
    struct1.f2.emplace(20, std::nullopt);
    struct1.f3.emplace(10, std::vector<uint8_t>(3, 48));
    struct1.f3.emplace(20, std::vector<uint8_t>(3, 65));
    struct1.f4.emplace(10, std::vector<uint8_t>(3, 97));
    struct1.f4.emplace(20, std::nullopt);
    struct1.f5.emplace(10, test::EnumSimple::ENUM_VALUE_1);
    struct1.f5.emplace(20, test::EnumSimple::ENUM_VALUE_2);
    struct1.f6.emplace(10, test::EnumSimple::ENUM_VALUE_1);
    struct1.f6.emplace(20, std::nullopt);
    struct1.f7.emplace(10, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f7.emplace(20, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct1.f8.emplace(10, test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f8.emplace(20, std::nullopt);
    test::StructSimple s1;
    s1.id = 48;
    struct1.f9.emplace(10, s1);
    test::StructSimple s2;
    s2.id = 65;
    struct1.f9.emplace(20, s2);
    struct1.f10.emplace(10, s1);
    struct1.f10.emplace(20, std::nullopt);

    // Serialize the struct to the FBE stream
    FBE::test::StructMapFinalModel writer;
    REQUIRE(writer.fbe_type() == 140);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 1074);

    // Deserialize the struct from the FBE stream
    test::StructMap struct2;
    FBE::test::StructMapFinalModel reader;
    REQUIRE(reader.fbe_type() == 140);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1.find(10)->second == 48);
    REQUIRE(struct2.f1.find(20)->second == 65);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2.find(10)->second.value() == 97);
    REQUIRE(struct2.f2.find(20)->second == std::nullopt);
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3.find(10)->second.size() == 3);
    REQUIRE(struct2.f3.find(20)->second.size() == 3);
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4.find(10)->second.value().size() == 3);
    REQUIRE(struct2.f4.find(20)->second == std::nullopt);
    REQUIRE(struct2.f5.size() == 2);
    REQUIRE(struct2.f5.find(10)->second == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f5.find(20)->second == test::EnumSimple::ENUM_VALUE_2);
    REQUIRE(struct2.f6.size() == 2);
    REQUIRE(struct2.f6.find(10)->second.value() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f6.find(20)->second == std::nullopt);
    REQUIRE(struct2.f7.size() == 2);
    REQUIRE(struct2.f7.find(10)->second == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f7.find(20)->second == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3));
    REQUIRE(struct2.f8.size() == 2);
    REQUIRE(struct2.f8.find(10)->second.value() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f8.find(20)->second == std::nullopt);
    REQUIRE(struct2.f9.size() == 2);
    REQUIRE(struct2.f9.find(10)->second.id == 48);
    REQUIRE(struct2.f9.find(20)->second.id == 65);
    REQUIRE(struct2.f10.size() == 2);
    REQUIRE(struct2.f10.find(10)->second.value().id == 48);
    REQUIRE(struct2.f10.find(20)->second == std::nullopt);
}

TEST_CASE("Serialization (Final): struct hash", "[FBE]")
{
    // Create a new struct
    test::StructHash struct1;
    struct1.f1.emplace("10", (uint8_t)48);
    struct1.f1.emplace("20", (uint8_t)65);
    struct1.f2.emplace("10", (uint8_t)97);
    struct1.f2.emplace("20", std::nullopt);
    struct1.f3.emplace("10", std::vector<uint8_t>(3, 48));
    struct1.f3.emplace("20", std::vector<uint8_t>(3, 65));
    struct1.f4.emplace("10", std::vector<uint8_t>(3, 97));
    struct1.f4.emplace("20", std::nullopt);
    struct1.f5.emplace("10", test::EnumSimple::ENUM_VALUE_1);
    struct1.f5.emplace("20", test::EnumSimple::ENUM_VALUE_2);
    struct1.f6.emplace("10", test::EnumSimple::ENUM_VALUE_1);
    struct1.f6.emplace("20", std::nullopt);
    struct1.f7.emplace("10", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f7.emplace("20", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3);
    struct1.f8.emplace("10", test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2);
    struct1.f8.emplace("20", std::nullopt);
    test::StructSimple s1;
    s1.id = 48;
    struct1.f9.emplace("10", s1);
    test::StructSimple s2;
    s2.id = 65;
    struct1.f9.emplace("20", s2);
    struct1.f10.emplace("10", s1);
    struct1.f10.emplace("20", std::nullopt);

    // Serialize the struct to the FBE stream
    FBE::test::StructHashFinalModel writer;
    REQUIRE(writer.fbe_type() == 141);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 1114);

    // Deserialize the struct from the FBE stream
    test::StructHash struct2;
    FBE::test::StructHashFinalModel reader;
    REQUIRE(reader.fbe_type() == 141);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1.find("10")->second == 48);
    REQUIRE(struct2.f1.find("20")->second == 65);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2.find("10")->second.value() == 97);
    REQUIRE(struct2.f2.find("20")->second == std::nullopt);
    REQUIRE(struct2.f3.size() == 2);
    REQUIRE(struct2.f3.find("10")->second.size() == 3);
    REQUIRE(struct2.f3.find("20")->second.size() == 3);
    REQUIRE(struct2.f4.size() == 2);
    REQUIRE(struct2.f4.find("10")->second.value().size() == 3);
    REQUIRE(struct2.f4.find("20")->second == std::nullopt);
    REQUIRE(struct2.f5.size() == 2);
    REQUIRE(struct2.f5.find("10")->second == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f5.find("20")->second == test::EnumSimple::ENUM_VALUE_2);
    REQUIRE(struct2.f6.size() == 2);
    REQUIRE(struct2.f6.find("10")->second.value() == test::EnumSimple::ENUM_VALUE_1);
    REQUIRE(struct2.f6.find("20")->second == std::nullopt);
    REQUIRE(struct2.f7.size() == 2);
    REQUIRE(struct2.f7.find("10")->second == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f7.find("20")->second == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2 | test::FlagsSimple::FLAG_VALUE_3));
    REQUIRE(struct2.f8.size() == 2);
    REQUIRE(struct2.f8.find("10")->second.value() == (test::FlagsSimple::FLAG_VALUE_1 | test::FlagsSimple::FLAG_VALUE_2));
    REQUIRE(struct2.f8.find("20")->second == std::nullopt);
    REQUIRE(struct2.f9.size() == 2);
    REQUIRE(struct2.f9.find("10")->second.id == 48);
    REQUIRE(struct2.f9.find("20")->second.id == 65);
    REQUIRE(struct2.f10.size() == 2);
    REQUIRE(struct2.f10.find("10")->second.value().id == 48);
    REQUIRE(struct2.f10.find("20")->second == std::nullopt);
}

TEST_CASE("Serialization (Final): struct hash extended", "[FBE]")
{
    // Create a new struct
    test::StructHashEx struct1;
    test::StructSimple s1;
    s1.id = 48;
    struct1.f1.emplace(s1, test::StructNested());
    test::StructSimple s2;
    s2.id = 65;
    struct1.f1.emplace(s2, test::StructNested());
    struct1.f2.emplace(s1, test::StructNested());
    struct1.f2.emplace(s2, std::nullopt);

    // Serialize the struct to the FBE stream
    FBE::test::StructHashExFinalModel writer;
    REQUIRE(writer.fbe_type() == 142);
    size_t serialized = writer.serialize(struct1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 4979);

    // Deserialize the struct from the FBE stream
    test::StructHashEx struct2;
    FBE::test::StructHashExFinalModel reader;
    REQUIRE(reader.fbe_type() == 142);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(struct2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(struct2.f1.size() == 2);
    REQUIRE(struct2.f1.find(s1)->second.f1002 == test::EnumTyped::ENUM_VALUE_2);
    REQUIRE(struct2.f1.find(s2)->second.f1002 == test::EnumTyped::ENUM_VALUE_2);
    REQUIRE(struct2.f2.size() == 2);
    REQUIRE(struct2.f2.find(s1)->second.value().f1002 == test::EnumTyped::ENUM_VALUE_2);
    REQUIRE(struct2.f2.find(s2)->second == std::nullopt);
}
