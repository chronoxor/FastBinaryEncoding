// ReSharper disable CompareOfFloatsByEqualityOperator
// ReSharper disable PossibleInvalidOperationException
// ReSharper disable RedundantBoolCompare

#pragma warning disable xUnit2017

using System;
using System.IO;
using Xunit;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;
using com.chronoxor.test;
using com.chronoxor.test.FBE;

namespace Tests
{
    public class TestSerializationFinal
    {
        [Fact(DisplayName = "Serialization (Final): domain")]
        public void SerializationDomain()
        {
            // Create a new account with some orders
            var account1 = Account.Default;
            account1.id = 1;
            account1.name = "Test";
            account1.state = State.good;
            account1.wallet.currency = "USD";
            account1.wallet.amount = 1000.0;
            account1.asset = new Balance("EUR", 100.0);
            account1.orders.Add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
            account1.orders.Add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
            account1.orders.Add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

            // Serialize the account to the FBE stream
            var writer = new AccountFinalModel();
            long serialized = writer.Serialize(account1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 152);

            // Deserialize the account from the FBE stream
            var reader = new AccountFinalModel();
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var account2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(account2.id == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state.HasFlags(State.good));
            Assert.True(account2.wallet.currency == "USD");
            Assert.True(account2.wallet.amount == 1000.0);
            Assert.True(account2.asset != null);
            Assert.True(account2.asset?.currency == "EUR");
            Assert.True(account2.asset?.amount == 100.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].id == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == OrderSide.buy);
            Assert.True(account2.orders[0].type == OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[1].id == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == OrderSide.sell);
            Assert.True(account2.orders[1].type == OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[2].id == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side == OrderSide.buy);
            Assert.True(account2.orders[2].type == OrderType.stop);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
        }

        [Fact(DisplayName = "Serialization (Final): struct simple")]
        public void SerializationStructSimple()
        {
            // Create a new struct
            var struct1 = StructSimple.Default;

            // Serialize the struct to the FBE stream
            var writer = new StructSimpleFinalModel();
            Assert.True(writer.FBEType == 110);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 304);

            // Deserialize the struct from the FBE stream
            var reader = new StructSimpleFinalModel();
            Assert.True(reader.FBEType == 110);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1 == false);
            Assert.True(struct2.f2 == true);
            Assert.True(struct2.f3 == 0);
            Assert.True(struct2.f4 == 0xFF);
            Assert.True(struct2.f5 == '\0');
            Assert.True(struct2.f6 == '!');
            Assert.True(struct2.f7 == 0);
            Assert.True(struct2.f8 == 0x0444);
            Assert.True(struct2.f9 == 0);
            Assert.True(struct2.f10 == 127);
            Assert.True(struct2.f11 == 0);
            Assert.True(struct2.f12 == 0xFF);
            Assert.True(struct2.f13 == 0);
            Assert.True(struct2.f14 == 32767);
            Assert.True(struct2.f15 == 0);
            Assert.True(struct2.f16 == 0xFFFF);
            Assert.True(struct2.f17 == 0);
            Assert.True(struct2.f18 == 2147483647);
            Assert.True(struct2.f19 == 0);
            Assert.True(struct2.f20 == 0xFFFFFFFF);
            Assert.True(struct2.f21 == 0);
            Assert.True(struct2.f22 == 9223372036854775807L);
            Assert.True(struct2.f23 == 0);
            Assert.True(struct2.f24 == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.f25 == 0.0f);
            Assert.True(Math.Abs(struct2.f26 - 123.456f) < 0.0001);
            Assert.True(struct2.f26 == 123.456f);
            Assert.True(struct2.f27 == 0.0);
            Assert.True(Math.Abs(struct2.f28 - -123.567e+123) < 1e+123);
            Assert.True(struct2.f29 == 0.0M);
            Assert.True(struct2.f30 == 123456.123456M);
            Assert.True(struct2.f31 == "");
            Assert.True(struct2.f32 == "Initial string!");
            Assert.True(struct2.f33 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f34 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f35 > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f36.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) == 0);
            Assert.True(struct2.f37.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) != 0);
            Assert.True(struct2.f38.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);

            Assert.True(struct2.f1 == struct1.f1);
            Assert.True(struct2.f2 == struct1.f2);
            Assert.True(struct2.f3 == struct1.f3);
            Assert.True(struct2.f4 == struct1.f4);
            Assert.True(struct2.f5 == struct1.f5);
            Assert.True(struct2.f6 == struct1.f6);
            Assert.True(struct2.f7 == struct1.f7);
            Assert.True(struct2.f8 == struct1.f8);
            Assert.True(struct2.f9 == struct1.f9);
            Assert.True(struct2.f10 == struct1.f10);
            Assert.True(struct2.f11 == struct1.f11);
            Assert.True(struct2.f12 == struct1.f12);
            Assert.True(struct2.f13 == struct1.f13);
            Assert.True(struct2.f14 == struct1.f14);
            Assert.True(struct2.f15 == struct1.f15);
            Assert.True(struct2.f16 == struct1.f16);
            Assert.True(struct2.f17 == struct1.f17);
            Assert.True(struct2.f18 == struct1.f18);
            Assert.True(struct2.f19 == struct1.f19);
            Assert.True(struct2.f20 == struct1.f20);
            Assert.True(struct2.f21 == struct1.f21);
            Assert.True(struct2.f22 == struct1.f22);
            Assert.True(struct2.f23 == struct1.f23);
            Assert.True(struct2.f24 == struct1.f24);
            Assert.True(struct2.f25 == struct1.f25);
            Assert.True(struct2.f26 == struct1.f26);
            Assert.True(struct2.f27 == struct1.f27);
            Assert.True(struct2.f28 == struct1.f28);
            Assert.True(struct2.f29 == struct1.f29);
            Assert.True(struct2.f30 == struct1.f30);
            Assert.True(struct2.f31 == struct1.f31);
            Assert.True(struct2.f32 == struct1.f32);
            Assert.True(struct2.f33 == struct1.f33);
            Assert.True(struct2.f34 == struct1.f34);
            Assert.True(struct2.f35 == struct1.f35);
            Assert.True(struct2.f36 == struct1.f36);
            Assert.True(struct2.f37 == struct1.f37);
            Assert.True(struct2.f38 == struct1.f38);
            Assert.True(struct2.f39 == struct1.f39);
            Assert.True(struct2.f40 == struct1.f40);
        }

        [Fact(DisplayName = "Serialization (Final): struct optional")]
        public void SerializationStructOptional()
        {
            // Create a new struct
            var struct1 = StructOptional.Default;

            // Serialize the struct to the FBE stream
            var writer = new StructOptionalFinalModel();
            Assert.True(writer.FBEType == 111);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 478);

            // Deserialize the struct from the FBE stream
            var reader = new StructOptionalFinalModel();
            Assert.True(reader.FBEType == 111);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1 == false);
            Assert.True(struct2.f2 == true);
            Assert.True(struct2.f3 == 0);
            Assert.True(struct2.f4 == 0xFF);
            Assert.True(struct2.f5 == '\0');
            Assert.True(struct2.f6 == '!');
            Assert.True(struct2.f7 == 0);
            Assert.True(struct2.f8 == 0x0444);
            Assert.True(struct2.f9 == 0);
            Assert.True(struct2.f10 == 127);
            Assert.True(struct2.f11 == 0);
            Assert.True(struct2.f12 == 0xFF);
            Assert.True(struct2.f13 == 0);
            Assert.True(struct2.f14 == 32767);
            Assert.True(struct2.f15 == 0);
            Assert.True(struct2.f16 == 0xFFFF);
            Assert.True(struct2.f17 == 0);
            Assert.True(struct2.f18 == 2147483647);
            Assert.True(struct2.f19 == 0);
            Assert.True(struct2.f20 == 0xFFFFFFFF);
            Assert.True(struct2.f21 == 0);
            Assert.True(struct2.f22 == 9223372036854775807L);
            Assert.True(struct2.f23 == 0);
            Assert.True(struct2.f24 == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.f25 == 0.0f);
            Assert.True(Math.Abs(struct2.f26 - 123.456f) < 0.0001);
            Assert.True(struct2.f27 == 0.0);
            Assert.True(Math.Abs(struct2.f28 - -123.567e+123) < 1e+123);
            Assert.True(struct2.f29 == 0.0M);
            Assert.True(struct2.f30 == 123456.123456M);
            Assert.True(struct2.f31 == "");
            Assert.True(struct2.f32 == "Initial string!");
            Assert.True(struct2.f33 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f34 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f35 > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f36.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) == 0);
            Assert.True(struct2.f37.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) != 0);
            Assert.True(struct2.f38.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);

            Assert.True(struct2.f100 == null);
            Assert.True(struct2.f101 != null);
            Assert.True(struct2.f101.Value == true);
            Assert.True(struct2.f102 == null);
            Assert.True(struct2.f103 == null);
            Assert.True(struct2.f104 != null);
            Assert.True(struct2.f104.Value == 0xFF);
            Assert.True(struct2.f105 == null);
            Assert.True(struct2.f106 == null);
            Assert.True(struct2.f107 != null);
            Assert.True(struct2.f107.Value == '!');
            Assert.True(struct2.f108 == null);
            Assert.True(struct2.f109 == null);
            Assert.True(struct2.f110 != null);
            Assert.True(struct2.f110.Value == 0x0444);
            Assert.True(struct2.f111 == null);
            Assert.True(struct2.f112 == null);
            Assert.True(struct2.f113 != null);
            Assert.True(struct2.f113.Value == 127);
            Assert.True(struct2.f114 == null);
            Assert.True(struct2.f115 == null);
            Assert.True(struct2.f116 != null);
            Assert.True(struct2.f116.Value == 0xFF);
            Assert.True(struct2.f117 == null);
            Assert.True(struct2.f118 == null);
            Assert.True(struct2.f119 != null);
            Assert.True(struct2.f119.Value == 32767);
            Assert.True(struct2.f120 == null);
            Assert.True(struct2.f121 == null);
            Assert.True(struct2.f122 != null);
            Assert.True(struct2.f122.Value == 0xFFFF);
            Assert.True(struct2.f123 == null);
            Assert.True(struct2.f124 == null);
            Assert.True(struct2.f125 != null);
            Assert.True(struct2.f125.Value == 2147483647);
            Assert.True(struct2.f126 == null);
            Assert.True(struct2.f127 == null);
            Assert.True(struct2.f128 != null);
            Assert.True(struct2.f128.Value == 0xFFFFFFFF);
            Assert.True(struct2.f129 == null);
            Assert.True(struct2.f130 == null);
            Assert.True(struct2.f131 != null);
            Assert.True(struct2.f131.Value == 9223372036854775807L);
            Assert.True(struct2.f132 == null);
            Assert.True(struct2.f133 == null);
            Assert.True(struct2.f131 != null);
            Assert.True(struct2.f134.Value == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.f135 == null);
            Assert.True(struct2.f136 == null);
            Assert.True(struct2.f137 != null);
            Assert.True(Math.Abs(struct2.f137.Value - 123.456f) < 0.0001);
            Assert.True(struct2.f138 == null);
            Assert.True(struct2.f139 == null);
            Assert.True(struct2.f140 != null);
            Assert.True(Math.Abs(struct2.f140.Value - -123.567e+123) < 1e+123);
            Assert.True(struct2.f141 == null);
            Assert.True(struct2.f142 == null);
            Assert.True(struct2.f143 != null);
            Assert.True(struct2.f143.Value == 123456.123456M);
            Assert.True(struct2.f144 == null);
            Assert.True(struct2.f145 == null);
            Assert.True(struct2.f146 != null);
            Assert.True(struct2.f146 == "Initial string!");
            Assert.True(struct2.f147 == null);
            Assert.True(struct2.f148 == null);
            Assert.True(struct2.f149 != null);
            Assert.True(struct2.f149.Value > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f150 == null);
            Assert.True(struct2.f151 == null);
            Assert.True(struct2.f152 != null);
            Assert.True(struct2.f152.Value.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);
            Assert.True(struct2.f153 == null);
            Assert.True(struct2.f154 == null);
            Assert.True(struct2.f155 == null);
            Assert.True(struct2.f156 == null);
            Assert.True(struct2.f157 == null);
            Assert.True(struct2.f158 == null);
            Assert.True(struct2.f159 == null);
            Assert.True(struct2.f160 == null);
            Assert.True(struct2.f161 == null);
            Assert.True(struct2.f162 == null);
            Assert.True(struct2.f163 == null);
            Assert.True(struct2.f164 == null);
            Assert.True(struct2.f165 == null);

            Assert.True(struct2.f1 == struct1.f1);
            Assert.True(struct2.f2 == struct1.f2);
            Assert.True(struct2.f3 == struct1.f3);
            Assert.True(struct2.f4 == struct1.f4);
            Assert.True(struct2.f5 == struct1.f5);
            Assert.True(struct2.f6 == struct1.f6);
            Assert.True(struct2.f7 == struct1.f7);
            Assert.True(struct2.f8 == struct1.f8);
            Assert.True(struct2.f9 == struct1.f9);
            Assert.True(struct2.f10 == struct1.f10);
            Assert.True(struct2.f11 == struct1.f11);
            Assert.True(struct2.f12 == struct1.f12);
            Assert.True(struct2.f13 == struct1.f13);
            Assert.True(struct2.f14 == struct1.f14);
            Assert.True(struct2.f15 == struct1.f15);
            Assert.True(struct2.f16 == struct1.f16);
            Assert.True(struct2.f17 == struct1.f17);
            Assert.True(struct2.f18 == struct1.f18);
            Assert.True(struct2.f19 == struct1.f19);
            Assert.True(struct2.f20 == struct1.f20);
            Assert.True(struct2.f21 == struct1.f21);
            Assert.True(struct2.f22 == struct1.f22);
            Assert.True(struct2.f23 == struct1.f23);
            Assert.True(struct2.f24 == struct1.f24);
            Assert.True(struct2.f25 == struct1.f25);
            Assert.True(struct2.f26 == struct1.f26);
            Assert.True(struct2.f27 == struct1.f27);
            Assert.True(struct2.f28 == struct1.f28);
            Assert.True(struct2.f29 == struct1.f29);
            Assert.True(struct2.f30 == struct1.f30);
            Assert.True(struct2.f31 == struct1.f31);
            Assert.True(struct2.f32 == struct1.f32);
            Assert.True(struct2.f33 == struct1.f33);
            Assert.True(struct2.f34 == struct1.f34);
            Assert.True(struct2.f35 == struct1.f35);
            Assert.True(struct2.f36 == struct1.f36);
            Assert.True(struct2.f37 == struct1.f37);
            Assert.True(struct2.f38 == struct1.f38);
            Assert.True(struct2.f39 == struct1.f39);
            Assert.True(struct2.f40 == struct1.f40);

            Assert.True(struct2.f100 == struct1.f100);
            Assert.True(struct2.f101 == struct1.f101);
            Assert.True(struct2.f102 == struct1.f102);
            Assert.True(struct2.f103 == struct1.f103);
            Assert.True(struct2.f104 == struct1.f104);
            Assert.True(struct2.f105 == struct1.f105);
            Assert.True(struct2.f106 == struct1.f106);
            Assert.True(struct2.f107 == struct1.f107);
            Assert.True(struct2.f108 == struct1.f108);
            Assert.True(struct2.f109 == struct1.f109);
            Assert.True(struct2.f110 == struct1.f110);
            Assert.True(struct2.f111 == struct1.f111);
            Assert.True(struct2.f112 == struct1.f112);
            Assert.True(struct2.f113 == struct1.f113);
            Assert.True(struct2.f114 == struct1.f114);
            Assert.True(struct2.f115 == struct1.f115);
            Assert.True(struct2.f116 == struct1.f116);
            Assert.True(struct2.f117 == struct1.f117);
            Assert.True(struct2.f118 == struct1.f118);
            Assert.True(struct2.f119 == struct1.f119);
            Assert.True(struct2.f120 == struct1.f120);
            Assert.True(struct2.f121 == struct1.f121);
            Assert.True(struct2.f122 == struct1.f122);
            Assert.True(struct2.f123 == struct1.f123);
            Assert.True(struct2.f124 == struct1.f124);
            Assert.True(struct2.f125 == struct1.f125);
            Assert.True(struct2.f126 == struct1.f126);
            Assert.True(struct2.f127 == struct1.f127);
            Assert.True(struct2.f128 == struct1.f128);
            Assert.True(struct2.f129 == struct1.f129);
            Assert.True(struct2.f130 == struct1.f130);
            Assert.True(struct2.f131 == struct1.f131);
            Assert.True(struct2.f132 == struct1.f132);
            Assert.True(struct2.f133 == struct1.f133);
            Assert.True(struct2.f134 == struct1.f134);
            Assert.True(struct2.f135 == struct1.f135);
            Assert.True(struct2.f136 == struct1.f136);
            Assert.True(struct2.f137 == struct1.f137);
            Assert.True(struct2.f138 == struct1.f138);
            Assert.True(struct2.f139 == struct1.f139);
            Assert.True(struct2.f140 == struct1.f140);
            Assert.True(struct2.f141 == struct1.f141);
            Assert.True(struct2.f142 == struct1.f142);
            Assert.True(struct2.f143 == struct1.f143);
            Assert.True(struct2.f144 == struct1.f144);
            Assert.True(struct2.f145 == struct1.f145);
            Assert.True(struct2.f146 == struct1.f146);
            Assert.True(struct2.f147 == struct1.f147);
            Assert.True(struct2.f148 == struct1.f148);
            Assert.True(struct2.f149 == struct1.f149);
            Assert.True(struct2.f150 == struct1.f150);
            Assert.True(struct2.f151 == struct1.f151);
            Assert.True(struct2.f152 == struct1.f152);
            Assert.True(struct2.f153 == struct1.f153);
            Assert.True(struct2.f154 == struct1.f154);
            Assert.True(struct2.f155 == struct1.f155);
            Assert.True(struct2.f156 == struct1.f156);
            Assert.True(struct2.f157 == struct1.f157);
        }

        [Fact(DisplayName = "Serialization (Final): struct nested")]
        public void SerializationStructNested()
        {
            // Create a new struct
            var struct1 = StructNested.Default;

            // Serialize the struct to the FBE stream
            var writer = new StructNestedFinalModel();
            Assert.True(writer.FBEType == 112);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 1267);

            // Deserialize the struct from the FBE stream
            var reader = new StructNestedFinalModel();
            Assert.True(reader.FBEType == 112);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1 == false);
            Assert.True(struct2.f2 == true);
            Assert.True(struct2.f3 == 0);
            Assert.True(struct2.f4 == 0xFF);
            Assert.True(struct2.f5 == '\0');
            Assert.True(struct2.f6 == '!');
            Assert.True(struct2.f7 == 0);
            Assert.True(struct2.f8 == 0x0444);
            Assert.True(struct2.f9 == 0);
            Assert.True(struct2.f10 == 127);
            Assert.True(struct2.f11 == 0);
            Assert.True(struct2.f12 == 0xFF);
            Assert.True(struct2.f13 == 0);
            Assert.True(struct2.f14 == 32767);
            Assert.True(struct2.f15 == 0);
            Assert.True(struct2.f16 == 0xFFFF);
            Assert.True(struct2.f17 == 0);
            Assert.True(struct2.f18 == 2147483647);
            Assert.True(struct2.f19 == 0);
            Assert.True(struct2.f20 == 0xFFFFFFFF);
            Assert.True(struct2.f21 == 0);
            Assert.True(struct2.f22 == 9223372036854775807L);
            Assert.True(struct2.f23 == 0);
            Assert.True(struct2.f24 == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.f25 == 0.0f);
            Assert.True(Math.Abs(struct2.f26 - 123.456f) < 0.0001);
            Assert.True(struct2.f27 == 0.0);
            Assert.True(Math.Abs(struct2.f28 - -123.567e+123) < 1e+123);
            Assert.True(struct2.f29 == 0.0M);
            Assert.True(struct2.f30 == 123456.123456M);
            Assert.True(struct2.f31 == "");
            Assert.True(struct2.f32 == "Initial string!");
            Assert.True(struct2.f33 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f34 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f35 > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f36.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) == 0);
            Assert.True(struct2.f37.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) != 0);
            Assert.True(struct2.f38.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);

            Assert.True(struct2.f100 == null);
            Assert.True(struct2.f101 != null);
            Assert.True(struct2.f101.Value == true);
            Assert.True(struct2.f102 == null);
            Assert.True(struct2.f103 == null);
            Assert.True(struct2.f104 != null);
            Assert.True(struct2.f104.Value == 0xFF);
            Assert.True(struct2.f105 == null);
            Assert.True(struct2.f106 == null);
            Assert.True(struct2.f107 != null);
            Assert.True(struct2.f107.Value == '!');
            Assert.True(struct2.f108 == null);
            Assert.True(struct2.f109 == null);
            Assert.True(struct2.f110 != null);
            Assert.True(struct2.f110.Value == 0x0444);
            Assert.True(struct2.f111 == null);
            Assert.True(struct2.f112 == null);
            Assert.True(struct2.f113 != null);
            Assert.True(struct2.f113.Value == 127);
            Assert.True(struct2.f114 == null);
            Assert.True(struct2.f115 == null);
            Assert.True(struct2.f116 != null);
            Assert.True(struct2.f116.Value == 0xFF);
            Assert.True(struct2.f117 == null);
            Assert.True(struct2.f118 == null);
            Assert.True(struct2.f119 != null);
            Assert.True(struct2.f119.Value == 32767);
            Assert.True(struct2.f120 == null);
            Assert.True(struct2.f121 == null);
            Assert.True(struct2.f122 != null);
            Assert.True(struct2.f122.Value == 0xFFFF);
            Assert.True(struct2.f123 == null);
            Assert.True(struct2.f124 == null);
            Assert.True(struct2.f125 != null);
            Assert.True(struct2.f125.Value == 2147483647);
            Assert.True(struct2.f126 == null);
            Assert.True(struct2.f127 == null);
            Assert.True(struct2.f128 != null);
            Assert.True(struct2.f128.Value == 0xFFFFFFFF);
            Assert.True(struct2.f129 == null);
            Assert.True(struct2.f130 == null);
            Assert.True(struct2.f131 != null);
            Assert.True(struct2.f131.Value == 9223372036854775807L);
            Assert.True(struct2.f132 == null);
            Assert.True(struct2.f133 == null);
            Assert.True(struct2.f131 != null);
            Assert.True(struct2.f134.Value == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.f135 == null);
            Assert.True(struct2.f136 == null);
            Assert.True(struct2.f137 != null);
            Assert.True(Math.Abs(struct2.f137.Value - 123.456f) < 0.0001);
            Assert.True(struct2.f138 == null);
            Assert.True(struct2.f139 == null);
            Assert.True(struct2.f140 != null);
            Assert.True(Math.Abs(struct2.f140.Value - -123.567e+123) < 1e+123);
            Assert.True(struct2.f141 == null);
            Assert.True(struct2.f142 == null);
            Assert.True(struct2.f143 != null);
            Assert.True(struct2.f143.Value == 123456.123456M);
            Assert.True(struct2.f144 == null);
            Assert.True(struct2.f145 == null);
            Assert.True(struct2.f146 != null);
            Assert.True(struct2.f146 == "Initial string!");
            Assert.True(struct2.f147 == null);
            Assert.True(struct2.f148 == null);
            Assert.True(struct2.f149 != null);
            Assert.True(struct2.f149.Value > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.f150 == null);
            Assert.True(struct2.f151 == null);
            Assert.True(struct2.f152 != null);
            Assert.True(struct2.f152.Value.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);
            Assert.True(struct2.f153 == null);
            Assert.True(struct2.f154 == null);
            Assert.True(struct2.f155 == null);
            Assert.True(struct2.f156 == null);
            Assert.True(struct2.f157 == null);
            Assert.True(struct2.f158 == null);
            Assert.True(struct2.f159 == null);
            Assert.True(struct2.f160 == null);
            Assert.True(struct2.f161 == null);
            Assert.True(struct2.f162 == null);
            Assert.True(struct2.f163 == null);
            Assert.True(struct2.f164 == null);
            Assert.True(struct2.f165 == null);

            Assert.True(struct2.f1000 == EnumSimple.ENUM_VALUE_0);
            Assert.True(struct2.f1001 == null);
            Assert.True(struct2.f1002 == EnumTyped.ENUM_VALUE_2);
            Assert.True(struct2.f1003 == null);
            Assert.True(struct2.f1004 == FlagsSimple.FLAG_VALUE_0);
            Assert.True(struct2.f1005 == null);
            Assert.True(struct2.f1006 == (FlagsTyped.FLAG_VALUE_2 | FlagsTyped.FLAG_VALUE_4 | FlagsTyped.FLAG_VALUE_6));
            Assert.True(struct2.f1007 == null);
            Assert.True(struct2.f1009 == null);
            Assert.True(struct2.f1011 == null);

            Assert.True(struct2.f1 == struct1.f1);
            Assert.True(struct2.f2 == struct1.f2);
            Assert.True(struct2.f3 == struct1.f3);
            Assert.True(struct2.f4 == struct1.f4);
            Assert.True(struct2.f5 == struct1.f5);
            Assert.True(struct2.f6 == struct1.f6);
            Assert.True(struct2.f7 == struct1.f7);
            Assert.True(struct2.f8 == struct1.f8);
            Assert.True(struct2.f9 == struct1.f9);
            Assert.True(struct2.f10 == struct1.f10);
            Assert.True(struct2.f11 == struct1.f11);
            Assert.True(struct2.f12 == struct1.f12);
            Assert.True(struct2.f13 == struct1.f13);
            Assert.True(struct2.f14 == struct1.f14);
            Assert.True(struct2.f15 == struct1.f15);
            Assert.True(struct2.f16 == struct1.f16);
            Assert.True(struct2.f17 == struct1.f17);
            Assert.True(struct2.f18 == struct1.f18);
            Assert.True(struct2.f19 == struct1.f19);
            Assert.True(struct2.f20 == struct1.f20);
            Assert.True(struct2.f21 == struct1.f21);
            Assert.True(struct2.f22 == struct1.f22);
            Assert.True(struct2.f23 == struct1.f23);
            Assert.True(struct2.f24 == struct1.f24);
            Assert.True(struct2.f25 == struct1.f25);
            Assert.True(struct2.f26 == struct1.f26);
            Assert.True(struct2.f27 == struct1.f27);
            Assert.True(struct2.f28 == struct1.f28);
            Assert.True(struct2.f29 == struct1.f29);
            Assert.True(struct2.f30 == struct1.f30);
            Assert.True(struct2.f31 == struct1.f31);
            Assert.True(struct2.f32 == struct1.f32);
            Assert.True(struct2.f33 == struct1.f33);
            Assert.True(struct2.f34 == struct1.f34);
            Assert.True(struct2.f35 == struct1.f35);
            Assert.True(struct2.f36 == struct1.f36);
            Assert.True(struct2.f37 == struct1.f37);
            Assert.True(struct2.f38 == struct1.f38);
            Assert.True(struct2.f39 == struct1.f39);
            Assert.True(struct2.f40 == struct1.f40);

            Assert.True(struct2.f100 == struct1.f100);
            Assert.True(struct2.f101 == struct1.f101);
            Assert.True(struct2.f102 == struct1.f102);
            Assert.True(struct2.f103 == struct1.f103);
            Assert.True(struct2.f104 == struct1.f104);
            Assert.True(struct2.f105 == struct1.f105);
            Assert.True(struct2.f106 == struct1.f106);
            Assert.True(struct2.f107 == struct1.f107);
            Assert.True(struct2.f108 == struct1.f108);
            Assert.True(struct2.f109 == struct1.f109);
            Assert.True(struct2.f110 == struct1.f110);
            Assert.True(struct2.f111 == struct1.f111);
            Assert.True(struct2.f112 == struct1.f112);
            Assert.True(struct2.f113 == struct1.f113);
            Assert.True(struct2.f114 == struct1.f114);
            Assert.True(struct2.f115 == struct1.f115);
            Assert.True(struct2.f116 == struct1.f116);
            Assert.True(struct2.f117 == struct1.f117);
            Assert.True(struct2.f118 == struct1.f118);
            Assert.True(struct2.f119 == struct1.f119);
            Assert.True(struct2.f120 == struct1.f120);
            Assert.True(struct2.f121 == struct1.f121);
            Assert.True(struct2.f122 == struct1.f122);
            Assert.True(struct2.f123 == struct1.f123);
            Assert.True(struct2.f124 == struct1.f124);
            Assert.True(struct2.f125 == struct1.f125);
            Assert.True(struct2.f126 == struct1.f126);
            Assert.True(struct2.f127 == struct1.f127);
            Assert.True(struct2.f128 == struct1.f128);
            Assert.True(struct2.f129 == struct1.f129);
            Assert.True(struct2.f130 == struct1.f130);
            Assert.True(struct2.f131 == struct1.f131);
            Assert.True(struct2.f132 == struct1.f132);
            Assert.True(struct2.f133 == struct1.f133);
            Assert.True(struct2.f134 == struct1.f134);
            Assert.True(struct2.f135 == struct1.f135);
            Assert.True(struct2.f136 == struct1.f136);
            Assert.True(struct2.f137 == struct1.f137);
            Assert.True(struct2.f138 == struct1.f138);
            Assert.True(struct2.f139 == struct1.f139);
            Assert.True(struct2.f140 == struct1.f140);
            Assert.True(struct2.f141 == struct1.f141);
            Assert.True(struct2.f142 == struct1.f142);
            Assert.True(struct2.f143 == struct1.f143);
            Assert.True(struct2.f144 == struct1.f144);
            Assert.True(struct2.f145 == struct1.f145);
            Assert.True(struct2.f146 == struct1.f146);
            Assert.True(struct2.f147 == struct1.f147);
            Assert.True(struct2.f148 == struct1.f148);
            Assert.True(struct2.f149 == struct1.f149);
            Assert.True(struct2.f150 == struct1.f150);
            Assert.True(struct2.f151 == struct1.f151);
            Assert.True(struct2.f152 == struct1.f152);
            Assert.True(struct2.f153 == struct1.f153);
            Assert.True(struct2.f154 == struct1.f154);
            Assert.True(struct2.f155 == struct1.f155);
            Assert.True(struct2.f156 == struct1.f156);
            Assert.True(struct2.f157 == struct1.f157);

            Assert.True(struct2.f1000 == struct1.f1000);
            Assert.True(struct2.f1001 == struct1.f1001);
            Assert.True(struct2.f1002 == struct1.f1002);
            Assert.True(struct2.f1003 == struct1.f1003);
            Assert.True(struct2.f1004 == struct1.f1004);
            Assert.True(struct2.f1005 == struct1.f1005);
            Assert.True(struct2.f1006 == struct1.f1006);
            Assert.True(struct2.f1007 == struct1.f1007);
        }

        [Fact(DisplayName = "Serialization (Final): struct bytes")]
        public void SerializationStructBytes()
        {
            // Create a new struct
            var struct1 = StructBytes.Default;
            struct1.f1 = new MemoryStream(new [] { (byte)'A', (byte)'B', (byte)'C' }, 0, 3, true, true);
            struct1.f2 = new MemoryStream(new[] { (byte)'t', (byte)'e', (byte)'s', (byte)'t' }, 0, 4, true, true);

            // Serialize the struct to the FBE stream
            var writer = new StructBytesFinalModel();
            Assert.True(writer.FBEType == 120);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 25);

            // Deserialize the struct from the FBE stream
            var reader = new StructBytesFinalModel();
            Assert.True(reader.FBEType == 120);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Length == 3);
            Assert.True(struct2.f1.GetBuffer()[0] == (byte)'A');
            Assert.True(struct2.f1.GetBuffer()[1] == (byte)'B');
            Assert.True(struct2.f1.GetBuffer()[2] == (byte)'C');
            Assert.True(struct2.f2 != null);
            Assert.True(struct2.f2.Length == 4);
            Assert.True(struct2.f2.GetBuffer()[0] == (byte)'t');
            Assert.True(struct2.f2.GetBuffer()[1] == (byte)'e');
            Assert.True(struct2.f2.GetBuffer()[2] == (byte)'s');
            Assert.True(struct2.f2.GetBuffer()[3] == (byte)'t');
            Assert.True(struct2.f3 == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct array")]
        public void SerializationStructArray()
        {
            // Create a new struct
            var struct1 = StructArray.Default;
            struct1.f1[0] = 48;
            struct1.f1[1] = 65;
            struct1.f2[0] = 97;
            struct1.f2[1] = null;
            struct1.f3[0] = new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true);
            struct1.f3[1] = new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true);
            struct1.f4[0] = new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true);
            struct1.f4[1] = null;
            struct1.f5[0] = EnumSimple.ENUM_VALUE_1;
            struct1.f5[1] = EnumSimple.ENUM_VALUE_2;
            struct1.f6[0] = EnumSimple.ENUM_VALUE_1;
            struct1.f6[1] = null;
            struct1.f7[0] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2;
            struct1.f7[1] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3;
            struct1.f8[0] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2;
            struct1.f8[1] = null;
            struct1.f9[0] = StructSimple.Default;
            struct1.f9[1] = StructSimple.Default;
            struct1.f10[0] = StructSimple.Default;
            struct1.f10[1] = null;

            // Serialize the struct to the FBE stream
            var writer = new StructArrayFinalModel();
            Assert.True(writer.FBEType == 125);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 954);

            // Deserialize the struct from the FBE stream
            var reader = new StructArrayFinalModel();
            Assert.True(reader.FBEType == 125);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Length == 2);
            Assert.True(struct2.f1[0] == 48);
            Assert.True(struct2.f1[1] == 65);
            Assert.True(struct2.f2.Length == 2);
            Assert.True(struct2.f2[0] == 97);
            Assert.True(struct2.f2[1] == null);
            Assert.True(struct2.f3.Length == 2);
            Assert.True(struct2.f3[0].Length == 3);
            Assert.True(struct2.f3[0].GetBuffer()[0] == 48);
            Assert.True(struct2.f3[0].GetBuffer()[1] == 48);
            Assert.True(struct2.f3[0].GetBuffer()[2] == 48);
            Assert.True(struct2.f3[1].Length == 3);
            Assert.True(struct2.f3[1].GetBuffer()[0] == 65);
            Assert.True(struct2.f3[1].GetBuffer()[1] == 65);
            Assert.True(struct2.f3[1].GetBuffer()[2] == 65);
            Assert.True(struct2.f4.Length == 2);
            Assert.True(struct2.f4[0] != null);
            Assert.True(struct2.f4[0].Length == 3);
            Assert.True(struct2.f4[0].GetBuffer()[0] == 97);
            Assert.True(struct2.f4[0].GetBuffer()[1] == 97);
            Assert.True(struct2.f4[0].GetBuffer()[2] == 97);
            Assert.True(struct2.f4[1] == null);
            Assert.True(struct2.f5.Length == 2);
            Assert.True(struct2.f5[0] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f5[1] == EnumSimple.ENUM_VALUE_2);
            Assert.True(struct2.f6.Length == 2);
            Assert.True(struct2.f6[0] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f6[1] == null);
            Assert.True(struct2.f7.Length == 2);
            Assert.True(struct2.f7[0] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f7[1] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f8.Length == 2);
            Assert.True(struct2.f8[0] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f8[1] == null);
            Assert.True(struct2.f9.Length == 2);
            Assert.True(struct2.f9[0].f2 == true);
            Assert.True(struct2.f9[0].f12 == 255);
            Assert.True(struct2.f9[0].f32 == "Initial string!");
            Assert.True(struct2.f9[1].f2 == true);
            Assert.True(struct2.f9[1].f12 == 255);
            Assert.True(struct2.f9[1].f32 == "Initial string!");
            Assert.True(struct2.f10.Length == 2);
            Assert.True(struct2.f10[0] != null);
            Assert.True(struct2.f10[0]?.f2 == true);
            Assert.True(struct2.f10[0]?.f12 == 255);
            Assert.True(struct2.f10[0]?.f32 == "Initial string!");
            Assert.True(struct2.f10[1] == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct vector")]
        public void SerializationStructVector()
        {
            // Create a new struct
            var struct1 = StructVector.Default;
            struct1.f1.Add(48);
            struct1.f1.Add(65);
            struct1.f2.Add(97);
            struct1.f2.Add(null);
            struct1.f3.Add(new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            struct1.f3.Add(new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            struct1.f4.Add(new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            struct1.f4.Add(null);
            struct1.f5.Add(EnumSimple.ENUM_VALUE_1);
            struct1.f5.Add(EnumSimple.ENUM_VALUE_2);
            struct1.f6.Add(EnumSimple.ENUM_VALUE_1);
            struct1.f6.Add(null);
            struct1.f7.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f7.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            struct1.f8.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f8.Add(null);
            struct1.f9.Add(StructSimple.Default);
            struct1.f9.Add(StructSimple.Default);
            struct1.f10.Add(StructSimple.Default);
            struct1.f10.Add(null);

            // Serialize the struct to the FBE stream
            var writer = new StructVectorFinalModel();
            Assert.True(writer.FBEType == 130);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 994);

            // Deserialize the struct from the FBE stream
            var reader = new StructVectorFinalModel();
            Assert.True(reader.FBEType == 130);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 2);
            Assert.True(struct2.f1[0] == 48);
            Assert.True(struct2.f1[1] == 65);
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2[0] == 97);
            Assert.True(struct2.f2[1] == null);
            Assert.True(struct2.f3.Count == 2);
            Assert.True(struct2.f3[0].Length == 3);
            Assert.True(struct2.f3[0].GetBuffer()[0] == 48);
            Assert.True(struct2.f3[0].GetBuffer()[1] == 48);
            Assert.True(struct2.f3[0].GetBuffer()[2] == 48);
            Assert.True(struct2.f3[1].Length == 3);
            Assert.True(struct2.f3[1].GetBuffer()[0] == 65);
            Assert.True(struct2.f3[1].GetBuffer()[1] == 65);
            Assert.True(struct2.f3[1].GetBuffer()[2] == 65);
            Assert.True(struct2.f4.Count == 2);
            Assert.True(struct2.f4[0] != null);
            Assert.True(struct2.f4[0].Length == 3);
            Assert.True(struct2.f4[0].GetBuffer()[0] == 97);
            Assert.True(struct2.f4[0].GetBuffer()[1] == 97);
            Assert.True(struct2.f4[0].GetBuffer()[2] == 97);
            Assert.True(struct2.f4[1] == null);
            Assert.True(struct2.f5.Count == 2);
            Assert.True(struct2.f5[0] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f5[1] == EnumSimple.ENUM_VALUE_2);
            Assert.True(struct2.f6.Count == 2);
            Assert.True(struct2.f6[0] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f6[1] == null);
            Assert.True(struct2.f7.Count == 2);
            Assert.True(struct2.f7[0] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f7[1] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f8.Count == 2);
            Assert.True(struct2.f8[0] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f8[1] == null);
            Assert.True(struct2.f9.Count == 2);
            Assert.True(struct2.f9[0].f2 == true);
            Assert.True(struct2.f9[0].f12 == 255);
            Assert.True(struct2.f9[0].f32 == "Initial string!");
            Assert.True(struct2.f9[1].f2 == true);
            Assert.True(struct2.f9[1].f12 == 255);
            Assert.True(struct2.f9[1].f32 == "Initial string!");
            Assert.True(struct2.f10.Count == 2);
            Assert.True(struct2.f10[0] != null);
            Assert.True(struct2.f10[0]?.f2 == true);
            Assert.True(struct2.f10[0]?.f12 == 255);
            Assert.True(struct2.f10[0]?.f32 == "Initial string!");
            Assert.True(struct2.f10[1] == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct list")]
        public void SerializationStructList()
        {
            // Create a new struct
            var struct1 = StructList.Default;
            struct1.f1.AddLast(48);
            struct1.f1.AddLast(65);
            struct1.f2.AddLast(97);
            struct1.f2.AddLast((byte?)null);
            struct1.f3.AddLast(new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            struct1.f3.AddLast(new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            struct1.f4.AddLast(new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            struct1.f4.AddLast((MemoryStream)null);
            struct1.f5.AddLast(EnumSimple.ENUM_VALUE_1);
            struct1.f5.AddLast(EnumSimple.ENUM_VALUE_2);
            struct1.f6.AddLast(EnumSimple.ENUM_VALUE_1);
            struct1.f6.AddLast((EnumSimple)null);
            struct1.f7.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f7.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            struct1.f8.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f8.AddLast((FlagsSimple)null);
            struct1.f9.AddLast(StructSimple.Default);
            struct1.f9.AddLast(StructSimple.Default);
            struct1.f10.AddLast(StructSimple.Default);
            struct1.f10.AddLast((StructSimple)null);

            // Serialize the struct to the FBE stream
            var writer = new StructListFinalModel();
            Assert.True(writer.FBEType == 131);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 994);

            // Deserialize the struct from the FBE stream
            var reader = new StructListFinalModel();
            Assert.True(reader.FBEType == 131);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 2);
            Assert.True(struct2.f1.First.Value == 48);
            Assert.True(struct2.f1.Last.Value == 65);
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2.First.Value == 97);
            Assert.True(struct2.f2.Last.Value == null);
            Assert.True(struct2.f3.Count == 2);
            Assert.True(struct2.f3.First.Value.Length == 3);
            Assert.True(struct2.f3.First.Value.GetBuffer()[0] == 48);
            Assert.True(struct2.f3.First.Value.GetBuffer()[1] == 48);
            Assert.True(struct2.f3.First.Value.GetBuffer()[2] == 48);
            Assert.True(struct2.f3.Last.Value.Length == 3);
            Assert.True(struct2.f3.Last.Value.GetBuffer()[0] == 65);
            Assert.True(struct2.f3.Last.Value.GetBuffer()[1] == 65);
            Assert.True(struct2.f3.Last.Value.GetBuffer()[2] == 65);
            Assert.True(struct2.f4.Count == 2);
            Assert.True(struct2.f4.First.Value != null);
            Assert.True(struct2.f4.First.Value.Length == 3);
            Assert.True(struct2.f4.First.Value.GetBuffer()[0] == 97);
            Assert.True(struct2.f4.First.Value.GetBuffer()[1] == 97);
            Assert.True(struct2.f4.First.Value.GetBuffer()[2] == 97);
            Assert.True(struct2.f4.Last.Value == null);
            Assert.True(struct2.f5.Count == 2);
            Assert.True(struct2.f5.First.Value == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f5.Last.Value == EnumSimple.ENUM_VALUE_2);
            Assert.True(struct2.f6.Count == 2);
            Assert.True(struct2.f6.First.Value == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f6.Last.Value == null);
            Assert.True(struct2.f7.Count == 2);
            Assert.True(struct2.f7.First.Value == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f7.Last.Value == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f8.Count == 2);
            Assert.True(struct2.f8.First.Value == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f8.Last.Value == null);
            Assert.True(struct2.f9.Count == 2);
            Assert.True(struct2.f9.First.Value.f2 == true);
            Assert.True(struct2.f9.First.Value.f12 == 255);
            Assert.True(struct2.f9.First.Value.f32 == "Initial string!");
            Assert.True(struct2.f9.Last.Value.f2 == true);
            Assert.True(struct2.f9.Last.Value.f12 == 255);
            Assert.True(struct2.f9.Last.Value.f32 == "Initial string!");
            Assert.True(struct2.f10.Count == 2);
            Assert.True(struct2.f10.First.Value != null);
            Assert.True(struct2.f10.First.Value?.f2 == true);
            Assert.True(struct2.f10.First.Value?.f12 == 255);
            Assert.True(struct2.f10.First.Value?.f32 == "Initial string!");
            Assert.True(struct2.f10.Last.Value == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct set")]
        public void SerializationStructSet()
        {
            // Create a new struct
            var struct1 = StructSet.Default;
            struct1.f1.Add(48);
            struct1.f1.Add(65);
            struct1.f1.Add(97);
            struct1.f2.Add(EnumSimple.ENUM_VALUE_1);
            struct1.f2.Add(EnumSimple.ENUM_VALUE_2);
            struct1.f3.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f3.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            var s1 = StructSimple.Default;
            s1.id = 48;
            struct1.f4.Add(s1);
            var s2 = StructSimple.Default;
            s2.id = 65;
            struct1.f4.Add(s2);

            // Serialize the struct to the FBE stream
            var writer = new StructSetFinalModel();
            Assert.True(writer.FBEType == 132);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 635);

            // Deserialize the struct from the FBE stream
            var reader = new StructSetFinalModel();
            Assert.True(reader.FBEType == 132);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 3);
            Assert.True(struct2.f1.Contains(48));
            Assert.True(struct2.f1.Contains(65));
            Assert.True(struct2.f1.Contains(97));
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2.Contains(EnumSimple.ENUM_VALUE_1));
            Assert.True(struct2.f2.Contains(EnumSimple.ENUM_VALUE_2));
            Assert.True(struct2.f3.Count == 2);
            Assert.True(struct2.f3.Contains(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f3.Contains(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f4.Count == 2);
            Assert.True(struct2.f4.Contains(s1));
            Assert.True(struct2.f4.Contains(s2));
        }

        [Fact(DisplayName = "Serialization (Final): struct map")]
        public void SerializationStructMap()
        {
            // Create a new struct
            var struct1 = StructMap.Default;
            struct1.f1.Add(10, 48);
            struct1.f1.Add(20, 65);
            struct1.f2.Add(10, 97);
            struct1.f2.Add(20, null);
            struct1.f3.Add(10, new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            struct1.f3.Add(20, new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            struct1.f4.Add(10, new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            struct1.f4.Add(20, null);
            struct1.f5.Add(10, EnumSimple.ENUM_VALUE_1);
            struct1.f5.Add(20, EnumSimple.ENUM_VALUE_2);
            struct1.f6.Add(10, EnumSimple.ENUM_VALUE_1);
            struct1.f6.Add(20, null);
            struct1.f7.Add(10, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f7.Add(20, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            struct1.f8.Add(10, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f8.Add(20, null);
            var s1 = StructSimple.Default;
            s1.id = 48;
            struct1.f9.Add(10, s1);
            var s2 = StructSimple.Default;
            s2.id = 65;
            struct1.f9.Add(20, s2);
            struct1.f10.Add(10, s1);
            struct1.f10.Add(20, null);

            // Serialize the struct to the FBE stream
            var writer = new StructMapFinalModel();
            Assert.True(writer.FBEType == 140);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 1074);

            // Deserialize the struct from the FBE stream
            var reader = new StructMapFinalModel();
            Assert.True(reader.FBEType == 140);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 2);
            Assert.True(struct2.f1[10] == 48);
            Assert.True(struct2.f1[20] == 65);
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2[10] == 97);
            Assert.True(struct2.f2[20] == null);
            Assert.True(struct2.f3.Count == 2);
            Assert.True(struct2.f3[10].Length == 3);
            Assert.True(struct2.f3[20].Length == 3);
            Assert.True(struct2.f4.Count == 2);
            Assert.True(struct2.f4[10].Length == 3);
            Assert.True(struct2.f4[20] == null);
            Assert.True(struct2.f5.Count == 2);
            Assert.True(struct2.f5[10] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f5[20] == EnumSimple.ENUM_VALUE_2);
            Assert.True(struct2.f6.Count == 2);
            Assert.True(struct2.f6[10] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f6[20] == null);
            Assert.True(struct2.f7.Count == 2);
            Assert.True(struct2.f7[10] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f7[20] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f8.Count == 2);
            Assert.True(struct2.f8[10] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f8[20] == null);
            Assert.True(struct2.f9.Count == 2);
            Assert.True(struct2.f9[10].id == 48);
            Assert.True(struct2.f9[20].id == 65);
            Assert.True(struct2.f10.Count == 2);
            Assert.True(struct2.f10[10]?.id == 48);
            Assert.True(struct2.f10[20] == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct hash")]
        public void SerializationStructHash()
        {
            // Create a new struct
            var struct1 = StructHash.Default;
            struct1.f1.Add("10", 48);
            struct1.f1.Add("20", 65);
            struct1.f2.Add("10", 97);
            struct1.f2.Add("20", null);
            struct1.f3.Add("10", new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            struct1.f3.Add("20", new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            struct1.f4.Add("10", new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            struct1.f4.Add("20", null);
            struct1.f5.Add("10", EnumSimple.ENUM_VALUE_1);
            struct1.f5.Add("20", EnumSimple.ENUM_VALUE_2);
            struct1.f6.Add("10", EnumSimple.ENUM_VALUE_1);
            struct1.f6.Add("20", null);
            struct1.f7.Add("10", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f7.Add("20", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            struct1.f8.Add("10", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            struct1.f8.Add("20", null);
            var s1 = StructSimple.Default;
            s1.id = 48;
            struct1.f9.Add("10", s1);
            var s2 = StructSimple.Default;
            s2.id = 65;
            struct1.f9.Add("20", s2);
            struct1.f10.Add("10", s1);
            struct1.f10.Add("20", null);

            // Serialize the struct to the FBE stream
            var writer = new StructHashFinalModel();
            Assert.True(writer.FBEType == 141);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 1114);

            // Deserialize the struct from the FBE stream
            var reader = new StructHashFinalModel();
            Assert.True(reader.FBEType == 141);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 2);
            Assert.True(struct2.f1["10"] == 48);
            Assert.True(struct2.f1["20"] == 65);
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2["10"] == 97);
            Assert.True(struct2.f2["20"] == null);
            Assert.True(struct2.f3.Count == 2);
            Assert.True(struct2.f3["10"].Length == 3);
            Assert.True(struct2.f3["20"].Length == 3);
            Assert.True(struct2.f4.Count == 2);
            Assert.True(struct2.f4["10"].Length == 3);
            Assert.True(struct2.f4["20"] == null);
            Assert.True(struct2.f5.Count == 2);
            Assert.True(struct2.f5["10"] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f5["20"] == EnumSimple.ENUM_VALUE_2);
            Assert.True(struct2.f6.Count == 2);
            Assert.True(struct2.f6["10"] == EnumSimple.ENUM_VALUE_1);
            Assert.True(struct2.f6["20"] == null);
            Assert.True(struct2.f7.Count == 2);
            Assert.True(struct2.f7["10"] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f7["20"] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3));
            Assert.True(struct2.f8.Count == 2);
            Assert.True(struct2.f8["10"] == (FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2));
            Assert.True(struct2.f8["20"] == null);
            Assert.True(struct2.f9.Count == 2);
            Assert.True(struct2.f9["10"].id == 48);
            Assert.True(struct2.f9["20"].id == 65);
            Assert.True(struct2.f10.Count == 2);
            Assert.True(struct2.f10["10"]?.id == 48);
            Assert.True(struct2.f10["20"] == null);
        }

        [Fact(DisplayName = "Serialization (Final): struct hash extended")]
        public void SerializationStructHashExtended()
        {
            // Create a new struct
            var struct1 = StructHashEx.Default;
            var s1 = StructSimple.Default;
            s1.id = 48;
            struct1.f1.Add(s1, StructNested.Default);
            var s2 = StructSimple.Default;
            s2.id = 65;
            struct1.f1.Add(s2, StructNested.Default);
            struct1.f2.Add(s1, StructNested.Default);
            struct1.f2.Add(s2, null);

            // Serialize the struct to the FBE stream
            var writer = new StructHashExFinalModel();
            Assert.True(writer.FBEType == 142);
            long serialized = writer.Serialize(struct1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 4979);

            // Deserialize the struct from the FBE stream
            var reader = new StructHashExFinalModel();
            Assert.True(reader.FBEType == 142);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var struct2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(struct2.f1.Count == 2);
            Assert.True(struct2.f1[s1].f1002 == EnumTyped.ENUM_VALUE_2);
            Assert.True(struct2.f1[s2].f1002 == EnumTyped.ENUM_VALUE_2);
            Assert.True(struct2.f2.Count == 2);
            Assert.True(struct2.f2[s1]?.f1002 == EnumTyped.ENUM_VALUE_2);
            Assert.True(struct2.f2[s2] == null);
        }
    }
}
