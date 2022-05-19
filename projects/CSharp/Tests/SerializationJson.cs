// ReSharper disable CompareOfFloatsByEqualityOperator
// ReSharper disable PossibleInvalidOperationException
// ReSharper disable RedundantBoolCompare

#pragma warning disable xUnit2017

using System;
using Xunit;

using com.chronoxor.proto;
using com.chronoxor.test;

namespace Tests
{
    public class TestSerializationJson
    {
        [Fact(DisplayName = "Serialization (JSON): domain")]
        public void SerializationJsonDomain()
        {
            // Define a source JSON string
            var json = @"{""id"":1,""name"":""Test"",""state"":6,""wallet"":{""currency"":""USD"",""amount"":1000.0},""asset"":{""currency"":""EUR"",""amount"":100.0},""orders"":[{""id"":1,""symbol"":""EURUSD"",""side"":0,""type"":0,""price"":1.23456,""volume"":1000.0},{""id"":2,""symbol"":""EURUSD"",""side"":1,""type"":1,""price"":1.0,""volume"":100.0},{""id"":3,""symbol"":""EURUSD"",""side"":0,""type"":2,""price"":1.5,""volume"":10.0}]}";

            // Create a new account from the source JSON string
            var account1 = Account.FromJson(json);

            // Serialize the account to the JSON string
            json = account1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the account from the JSON string
            var account2 = Account.FromJson(json);

            Assert.True(account2.id == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state.HasFlags(State.good));
            Assert.True(account2.wallet.currency == "USD");
            Assert.True(account2.wallet.amount == 1000.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.currency == "EUR");
            Assert.True(account2.asset.Value.amount == 100.0);
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

        [Fact(DisplayName = "Serialization (JSON): struct simple")]
        public void SerializationJsonStructSimple()
        {
            // Define a source JSON string
            var json = @"{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145597933463000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""e7854072-f0a5-11e8-8f69-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}";

            // Create a new struct from the source JSON string
            var struct1 = StructSimple.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructSimple.FromJson(json);

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

        [Fact(DisplayName = "Serialization (JSON): struct optional")]
        public void SerializationJsonStructOptional()
        {
            // Define a source JSON string
            var json = @"{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145860677797000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""8420d1c6-f0a6-11e8-80fc-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]},""f100"":null,""f101"":true,""f102"":null,""f103"":null,""f104"":255,""f105"":null,""f106"":null,""f107"":33,""f108"":null,""f109"":null,""f110"":1092,""f111"":null,""f112"":null,""f113"":127,""f114"":null,""f115"":null,""f116"":255,""f117"":null,""f118"":null,""f119"":32767,""f120"":null,""f121"":null,""f122"":65535,""f123"":null,""f124"":null,""f125"":2147483647,""f126"":null,""f127"":null,""f128"":4294967295,""f129"":null,""f130"":null,""f131"":9223372036854775807,""f132"":null,""f133"":null,""f134"":18446744073709551615,""f135"":null,""f136"":null,""f137"":123.456,""f138"":null,""f139"":null,""f140"":-1.23456e+125,""f141"":null,""f142"":null,""f143"":""123456.123456"",""f144"":null,""f145"":null,""f146"":""Initial string!"",""f147"":null,""f148"":null,""f149"":1543145860678429000,""f150"":null,""f151"":null,""f152"":""123e4567-e89b-12d3-a456-426655440000"",""f153"":null,""f154"":null,""f155"":null,""f156"":null,""f157"":null,""f158"":null,""f159"":null,""f160"":null,""f161"":null,""f162"":null,""f163"":null,""f164"":null,""f165"":null}";

            // Create a new struct from the source JSON string
            var struct1 = StructOptional.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructOptional.FromJson(json);

            Assert.True(struct2.parent.f1 == false);
            Assert.True(struct2.parent.f2 == true);
            Assert.True(struct2.parent.f3 == 0);
            Assert.True(struct2.parent.f4 == 0xFF);
            Assert.True(struct2.parent.f5 == '\0');
            Assert.True(struct2.parent.f6 == '!');
            Assert.True(struct2.parent.f7 == 0);
            Assert.True(struct2.parent.f8 == 0x0444);
            Assert.True(struct2.parent.f9 == 0);
            Assert.True(struct2.parent.f10 == 127);
            Assert.True(struct2.parent.f11 == 0);
            Assert.True(struct2.parent.f12 == 0xFF);
            Assert.True(struct2.parent.f13 == 0);
            Assert.True(struct2.parent.f14 == 32767);
            Assert.True(struct2.parent.f15 == 0);
            Assert.True(struct2.parent.f16 == 0xFFFF);
            Assert.True(struct2.parent.f17 == 0);
            Assert.True(struct2.parent.f18 == 2147483647);
            Assert.True(struct2.parent.f19 == 0);
            Assert.True(struct2.parent.f20 == 0xFFFFFFFF);
            Assert.True(struct2.parent.f21 == 0);
            Assert.True(struct2.parent.f22 == 9223372036854775807L);
            Assert.True(struct2.parent.f23 == 0);
            Assert.True(struct2.parent.f24 == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.parent.f25 == 0.0f);
            Assert.True(Math.Abs(struct2.parent.f26 - 123.456f) < 0.0001);
            Assert.True(struct2.parent.f27 == 0.0);
            Assert.True(Math.Abs(struct2.parent.f28 - -123.567e+123) < 1e+123);
            Assert.True(struct2.parent.f29 == 0.0M);
            Assert.True(struct2.parent.f30 == 123456.123456M);
            Assert.True(struct2.parent.f31 == "");
            Assert.True(struct2.parent.f32 == "Initial string!");
            Assert.True(struct2.parent.f33 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.f34 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.f35 > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.f36.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) == 0);
            Assert.True(struct2.parent.f37.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) != 0);
            Assert.True(struct2.parent.f38.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);

            Assert.True(!struct2.f100.HasValue);
            Assert.True(struct2.f101.HasValue);
            Assert.True(struct2.f101.Value == true);
            Assert.True(!struct2.f102.HasValue);
            Assert.True(!struct2.f103.HasValue);
            Assert.True(struct2.f104.HasValue);
            Assert.True(struct2.f104.Value == 0xFF);
            Assert.True(!struct2.f105.HasValue);
            Assert.True(!struct2.f106.HasValue);
            Assert.True(struct2.f107.HasValue);
            Assert.True(struct2.f107.Value == '!');
            Assert.True(!struct2.f108.HasValue);
            Assert.True(!struct2.f109.HasValue);
            Assert.True(struct2.f110.HasValue);
            Assert.True(struct2.f110.Value == 0x0444);
            Assert.True(!struct2.f111.HasValue);
            Assert.True(!struct2.f112.HasValue);
            Assert.True(struct2.f113.HasValue);
            Assert.True(struct2.f113.Value == 127);
            Assert.True(!struct2.f114.HasValue);
            Assert.True(!struct2.f115.HasValue);
            Assert.True(struct2.f116.HasValue);
            Assert.True(struct2.f116.Value == 0xFF);
            Assert.True(!struct2.f117.HasValue);
            Assert.True(!struct2.f118.HasValue);
            Assert.True(struct2.f119.HasValue);
            Assert.True(struct2.f119.Value == 32767);
            Assert.True(!struct2.f120.HasValue);
            Assert.True(!struct2.f121.HasValue);
            Assert.True(struct2.f122.HasValue);
            Assert.True(struct2.f122.Value == 0xFFFF);
            Assert.True(!struct2.f123.HasValue);
            Assert.True(!struct2.f124.HasValue);
            Assert.True(struct2.f125.HasValue);
            Assert.True(struct2.f125.Value == 2147483647);
            Assert.True(!struct2.f126.HasValue);
            Assert.True(!struct2.f127.HasValue);
            Assert.True(struct2.f128.HasValue);
            Assert.True(struct2.f128.Value == 0xFFFFFFFF);
            Assert.True(!struct2.f129.HasValue);
            Assert.True(!struct2.f130.HasValue);
            Assert.True(struct2.f131.HasValue);
            Assert.True(struct2.f131.Value == 9223372036854775807L);
            Assert.True(!struct2.f132.HasValue);
            Assert.True(!struct2.f133.HasValue);
            Assert.True(struct2.f131.HasValue);
            Assert.True(struct2.f134.Value == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(!struct2.f135.HasValue);
            Assert.True(!struct2.f136.HasValue);
            Assert.True(struct2.f137.HasValue);
            Assert.True(Math.Abs(struct2.f137.Value - 123.456f) < 0.0001);
            Assert.True(!struct2.f138.HasValue);
            Assert.True(!struct2.f139.HasValue);
            Assert.True(struct2.f140.HasValue);
            Assert.True(Math.Abs(struct2.f140.Value - -123.567e+123) < 1e+123);
            Assert.True(!struct2.f141.HasValue);
            Assert.True(!struct2.f142.HasValue);
            Assert.True(struct2.f143.HasValue);
            Assert.True(struct2.f143.Value == 123456.123456M);
            Assert.True(!struct2.f144.HasValue);
            Assert.True(struct2.f145 == null);
            Assert.True(struct2.f146 != null);
            Assert.True(struct2.f146 == "Initial string!");
            Assert.True(struct2.f147 == null);
            Assert.True(!struct2.f148.HasValue);
            Assert.True(struct2.f149.HasValue);
            Assert.True(struct2.f149.Value > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(!struct2.f150.HasValue);
            Assert.True(!struct2.f151.HasValue);
            Assert.True(struct2.f152.HasValue);
            Assert.True(struct2.f152.Value.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);
            Assert.True(!struct2.f153.HasValue);
            Assert.True(!struct2.f154.HasValue);
            Assert.True(!struct2.f155.HasValue);
            Assert.True(!struct2.f156.HasValue);
            Assert.True(!struct2.f157.HasValue);
            Assert.True(!struct2.f158.HasValue);
            Assert.True(!struct2.f159.HasValue);
            Assert.True(!struct2.f160.HasValue);
            Assert.True(!struct2.f161.HasValue);
            Assert.True(!struct2.f162.HasValue);
            Assert.True(!struct2.f163.HasValue);
            Assert.True(!struct2.f164.HasValue);
            Assert.True(!struct2.f165.HasValue);

            Assert.True(struct2.parent.f1 == struct1.parent.f1);
            Assert.True(struct2.parent.f2 == struct1.parent.f2);
            Assert.True(struct2.parent.f3 == struct1.parent.f3);
            Assert.True(struct2.parent.f4 == struct1.parent.f4);
            Assert.True(struct2.parent.f5 == struct1.parent.f5);
            Assert.True(struct2.parent.f6 == struct1.parent.f6);
            Assert.True(struct2.parent.f7 == struct1.parent.f7);
            Assert.True(struct2.parent.f8 == struct1.parent.f8);
            Assert.True(struct2.parent.f9 == struct1.parent.f9);
            Assert.True(struct2.parent.f10 == struct1.parent.f10);
            Assert.True(struct2.parent.f11 == struct1.parent.f11);
            Assert.True(struct2.parent.f12 == struct1.parent.f12);
            Assert.True(struct2.parent.f13 == struct1.parent.f13);
            Assert.True(struct2.parent.f14 == struct1.parent.f14);
            Assert.True(struct2.parent.f15 == struct1.parent.f15);
            Assert.True(struct2.parent.f16 == struct1.parent.f16);
            Assert.True(struct2.parent.f17 == struct1.parent.f17);
            Assert.True(struct2.parent.f18 == struct1.parent.f18);
            Assert.True(struct2.parent.f19 == struct1.parent.f19);
            Assert.True(struct2.parent.f20 == struct1.parent.f20);
            Assert.True(struct2.parent.f21 == struct1.parent.f21);
            Assert.True(struct2.parent.f22 == struct1.parent.f22);
            Assert.True(struct2.parent.f23 == struct1.parent.f23);
            Assert.True(struct2.parent.f24 == struct1.parent.f24);
            Assert.True(struct2.parent.f25 == struct1.parent.f25);
            Assert.True(struct2.parent.f26 == struct1.parent.f26);
            Assert.True(struct2.parent.f27 == struct1.parent.f27);
            Assert.True(struct2.parent.f28 == struct1.parent.f28);
            Assert.True(struct2.parent.f29 == struct1.parent.f29);
            Assert.True(struct2.parent.f30 == struct1.parent.f30);
            Assert.True(struct2.parent.f31 == struct1.parent.f31);
            Assert.True(struct2.parent.f32 == struct1.parent.f32);
            Assert.True(struct2.parent.f33 == struct1.parent.f33);
            Assert.True(struct2.parent.f34 == struct1.parent.f34);
            Assert.True(struct2.parent.f35 == struct1.parent.f35);
            Assert.True(struct2.parent.f36 == struct1.parent.f36);
            Assert.True(struct2.parent.f37 == struct1.parent.f37);
            Assert.True(struct2.parent.f38 == struct1.parent.f38);
            Assert.True(struct2.parent.f39 == struct1.parent.f39);
            Assert.True(struct2.parent.f40 == struct1.parent.f40);

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

        [Fact(DisplayName = "Serialization (JSON): struct nested")]
        public void SerializationJsonStructNested()
        {
            // Define a source JSON string
            var json = @"{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145901646321000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""9c8c268e-f0a6-11e8-a777-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]},""f100"":null,""f101"":true,""f102"":null,""f103"":null,""f104"":255,""f105"":null,""f106"":null,""f107"":33,""f108"":null,""f109"":null,""f110"":1092,""f111"":null,""f112"":null,""f113"":127,""f114"":null,""f115"":null,""f116"":255,""f117"":null,""f118"":null,""f119"":32767,""f120"":null,""f121"":null,""f122"":65535,""f123"":null,""f124"":null,""f125"":2147483647,""f126"":null,""f127"":null,""f128"":4294967295,""f129"":null,""f130"":null,""f131"":9223372036854775807,""f132"":null,""f133"":null,""f134"":18446744073709551615,""f135"":null,""f136"":null,""f137"":123.456,""f138"":null,""f139"":null,""f140"":-1.23456e+125,""f141"":null,""f142"":null,""f143"":""123456.123456"",""f144"":null,""f145"":null,""f146"":""Initial string!"",""f147"":null,""f148"":null,""f149"":1543145901647155000,""f150"":null,""f151"":null,""f152"":""123e4567-e89b-12d3-a456-426655440000"",""f153"":null,""f154"":null,""f155"":null,""f156"":null,""f157"":null,""f158"":null,""f159"":null,""f160"":null,""f161"":null,""f162"":null,""f163"":null,""f164"":null,""f165"":null,""f1000"":0,""f1001"":null,""f1002"":50,""f1003"":null,""f1004"":0,""f1005"":null,""f1006"":42,""f1007"":null,""f1008"":{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145901647367000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""9c8c54c4-f0a6-11e8-a777-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},""f1009"":null,""f1010"":{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145901648310000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""9c8c6b76-f0a6-11e8-a777-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]},""f100"":null,""f101"":true,""f102"":null,""f103"":null,""f104"":255,""f105"":null,""f106"":null,""f107"":33,""f108"":null,""f109"":null,""f110"":1092,""f111"":null,""f112"":null,""f113"":127,""f114"":null,""f115"":null,""f116"":255,""f117"":null,""f118"":null,""f119"":32767,""f120"":null,""f121"":null,""f122"":65535,""f123"":null,""f124"":null,""f125"":2147483647,""f126"":null,""f127"":null,""f128"":4294967295,""f129"":null,""f130"":null,""f131"":9223372036854775807,""f132"":null,""f133"":null,""f134"":18446744073709551615,""f135"":null,""f136"":null,""f137"":123.456,""f138"":null,""f139"":null,""f140"":-1.23456e+125,""f141"":null,""f142"":null,""f143"":""123456.123456"",""f144"":null,""f145"":null,""f146"":""Initial string!"",""f147"":null,""f148"":null,""f149"":1543145901648871000,""f150"":null,""f151"":null,""f152"":""123e4567-e89b-12d3-a456-426655440000"",""f153"":null,""f154"":null,""f155"":null,""f156"":null,""f157"":null,""f158"":null,""f159"":null,""f160"":null,""f161"":null,""f162"":null,""f163"":null,""f164"":null,""f165"":null},""f1011"":null}";

            // Create a new struct from the source JSON string
            var struct1 = StructNested.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructNested.FromJson(json);

            Assert.True(struct2.parent.parent.f1 == false);
            Assert.True(struct2.parent.parent.f2 == true);
            Assert.True(struct2.parent.parent.f3 == 0);
            Assert.True(struct2.parent.parent.f4 == 0xFF);
            Assert.True(struct2.parent.parent.f5 == '\0');
            Assert.True(struct2.parent.parent.f6 == '!');
            Assert.True(struct2.parent.parent.f7 == 0);
            Assert.True(struct2.parent.parent.f8 == 0x0444);
            Assert.True(struct2.parent.parent.f9 == 0);
            Assert.True(struct2.parent.parent.f10 == 127);
            Assert.True(struct2.parent.parent.f11 == 0);
            Assert.True(struct2.parent.parent.f12 == 0xFF);
            Assert.True(struct2.parent.parent.f13 == 0);
            Assert.True(struct2.parent.parent.f14 == 32767);
            Assert.True(struct2.parent.parent.f15 == 0);
            Assert.True(struct2.parent.parent.f16 == 0xFFFF);
            Assert.True(struct2.parent.parent.f17 == 0);
            Assert.True(struct2.parent.parent.f18 == 2147483647);
            Assert.True(struct2.parent.parent.f19 == 0);
            Assert.True(struct2.parent.parent.f20 == 0xFFFFFFFF);
            Assert.True(struct2.parent.parent.f21 == 0);
            Assert.True(struct2.parent.parent.f22 == 9223372036854775807L);
            Assert.True(struct2.parent.parent.f23 == 0);
            Assert.True(struct2.parent.parent.f24 == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(struct2.parent.parent.f25 == 0.0f);
            Assert.True(Math.Abs(struct2.parent.parent.f26 - 123.456f) < 0.0001);
            Assert.True(struct2.parent.parent.f27 == 0.0);
            Assert.True(Math.Abs(struct2.parent.parent.f28 - -123.567e+123) < 1e+123);
            Assert.True(struct2.parent.parent.f29 == 0.0M);
            Assert.True(struct2.parent.parent.f30 == 123456.123456M);
            Assert.True(struct2.parent.parent.f31 == "");
            Assert.True(struct2.parent.parent.f32 == "Initial string!");
            Assert.True(struct2.parent.parent.f33 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.parent.f34 == new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.parent.f35 > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(struct2.parent.parent.f36.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) == 0);
            Assert.True(struct2.parent.parent.f37.CompareTo(new Guid(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) != 0);
            Assert.True(struct2.parent.parent.f38.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);

            Assert.True(!struct2.parent.f100.HasValue);
            Assert.True(struct2.parent.f101.HasValue);
            Assert.True(struct2.parent.f101.Value == true);
            Assert.True(!struct2.parent.f102.HasValue);
            Assert.True(!struct2.parent.f103.HasValue);
            Assert.True(struct2.parent.f104.HasValue);
            Assert.True(struct2.parent.f104.Value == 0xFF);
            Assert.True(!struct2.parent.f105.HasValue);
            Assert.True(!struct2.parent.f106.HasValue);
            Assert.True(struct2.parent.f107.HasValue);
            Assert.True(struct2.parent.f107.Value == '!');
            Assert.True(!struct2.parent.f108.HasValue);
            Assert.True(!struct2.parent.f109.HasValue);
            Assert.True(struct2.parent.f110.HasValue);
            Assert.True(struct2.parent.f110.Value == 0x0444);
            Assert.True(!struct2.parent.f111.HasValue);
            Assert.True(!struct2.parent.f112.HasValue);
            Assert.True(struct2.parent.f113.HasValue);
            Assert.True(struct2.parent.f113.Value == 127);
            Assert.True(!struct2.parent.f114.HasValue);
            Assert.True(!struct2.parent.f115.HasValue);
            Assert.True(struct2.parent.f116.HasValue);
            Assert.True(struct2.parent.f116.Value == 0xFF);
            Assert.True(!struct2.parent.f117.HasValue);
            Assert.True(!struct2.parent.f118.HasValue);
            Assert.True(struct2.parent.f119.HasValue);
            Assert.True(struct2.parent.f119.Value == 32767);
            Assert.True(!struct2.parent.f120.HasValue);
            Assert.True(!struct2.parent.f121.HasValue);
            Assert.True(struct2.parent.f122.HasValue);
            Assert.True(struct2.parent.f122.Value == 0xFFFF);
            Assert.True(!struct2.parent.f123.HasValue);
            Assert.True(!struct2.parent.f124.HasValue);
            Assert.True(struct2.parent.f125.HasValue);
            Assert.True(struct2.parent.f125.Value == 2147483647);
            Assert.True(!struct2.parent.f126.HasValue);
            Assert.True(!struct2.parent.f127.HasValue);
            Assert.True(struct2.parent.f128.HasValue);
            Assert.True(struct2.parent.f128.Value == 0xFFFFFFFF);
            Assert.True(!struct2.parent.f129.HasValue);
            Assert.True(!struct2.parent.f130.HasValue);
            Assert.True(struct2.parent.f131.HasValue);
            Assert.True(struct2.parent.f131.Value == 9223372036854775807L);
            Assert.True(!struct2.parent.f132.HasValue);
            Assert.True(!struct2.parent.f133.HasValue);
            Assert.True(struct2.parent.f131.HasValue);
            Assert.True(struct2.parent.f134.Value == 0xFFFFFFFFFFFFFFFFUL);
            Assert.True(!struct2.parent.f135.HasValue);
            Assert.True(!struct2.parent.f136.HasValue);
            Assert.True(struct2.parent.f137.HasValue);
            Assert.True(Math.Abs(struct2.parent.f137.Value - 123.456f) < 0.0001);
            Assert.True(!struct2.parent.f138.HasValue);
            Assert.True(!struct2.parent.f139.HasValue);
            Assert.True(struct2.parent.f140.HasValue);
            Assert.True(Math.Abs(struct2.parent.f140.Value - -123.567e+123) < 1e+123);
            Assert.True(!struct2.parent.f141.HasValue);
            Assert.True(!struct2.parent.f142.HasValue);
            Assert.True(struct2.parent.f143.HasValue);
            Assert.True(struct2.parent.f143.Value == 123456.123456M);
            Assert.True(!struct2.parent.f144.HasValue);
            Assert.True(struct2.parent.f145 == null);
            Assert.True(struct2.parent.f146 != null);
            Assert.True(struct2.parent.f146 == "Initial string!");
            Assert.True(struct2.parent.f147 == null);
            Assert.True(!struct2.parent.f148.HasValue);
            Assert.True(struct2.parent.f149.HasValue);
            Assert.True(struct2.parent.f149.Value > new DateTime(2018, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc));
            Assert.True(!struct2.parent.f150.HasValue);
            Assert.True(!struct2.parent.f151.HasValue);
            Assert.True(struct2.parent.f152.HasValue);
            Assert.True(struct2.parent.f152.Value.CompareTo(new Guid("123e4567-e89b-12d3-a456-426655440000")) == 0);
            Assert.True(!struct2.parent.f153.HasValue);
            Assert.True(!struct2.parent.f154.HasValue);
            Assert.True(!struct2.parent.f155.HasValue);
            Assert.True(!struct2.parent.f156.HasValue);
            Assert.True(!struct2.parent.f157.HasValue);
            Assert.True(!struct2.parent.f158.HasValue);
            Assert.True(!struct2.parent.f159.HasValue);
            Assert.True(!struct2.parent.f160.HasValue);
            Assert.True(!struct2.parent.f161.HasValue);
            Assert.True(!struct2.parent.f162.HasValue);
            Assert.True(!struct2.parent.f163.HasValue);
            Assert.True(!struct2.parent.f164.HasValue);
            Assert.True(!struct2.parent.f165.HasValue);

            Assert.True(struct2.f1000 == EnumSimple.ENUM_VALUE_0);
            Assert.True(!struct2.f1001.HasValue);
            Assert.True(struct2.f1002 == EnumTyped.ENUM_VALUE_2);
            Assert.True(!struct2.f1003.HasValue);
            Assert.True(struct2.f1004 == FlagsSimple.FLAG_VALUE_0);
            Assert.True(!struct2.f1005.HasValue);
            Assert.True(struct2.f1006 == (FlagsTyped.FLAG_VALUE_2 | FlagsTyped.FLAG_VALUE_4 | FlagsTyped.FLAG_VALUE_6));
            Assert.True(!struct2.f1007.HasValue);
            Assert.True(!struct2.f1009.HasValue);
            Assert.True(!struct2.f1011.HasValue);

            Assert.True(struct2.parent.parent.f1 == struct1.parent.parent.f1);
            Assert.True(struct2.parent.parent.f2 == struct1.parent.parent.f2);
            Assert.True(struct2.parent.parent.f3 == struct1.parent.parent.f3);
            Assert.True(struct2.parent.parent.f4 == struct1.parent.parent.f4);
            Assert.True(struct2.parent.parent.f5 == struct1.parent.parent.f5);
            Assert.True(struct2.parent.parent.f6 == struct1.parent.parent.f6);
            Assert.True(struct2.parent.parent.f7 == struct1.parent.parent.f7);
            Assert.True(struct2.parent.parent.f8 == struct1.parent.parent.f8);
            Assert.True(struct2.parent.parent.f9 == struct1.parent.parent.f9);
            Assert.True(struct2.parent.parent.f10 == struct1.parent.parent.f10);
            Assert.True(struct2.parent.parent.f11 == struct1.parent.parent.f11);
            Assert.True(struct2.parent.parent.f12 == struct1.parent.parent.f12);
            Assert.True(struct2.parent.parent.f13 == struct1.parent.parent.f13);
            Assert.True(struct2.parent.parent.f14 == struct1.parent.parent.f14);
            Assert.True(struct2.parent.parent.f15 == struct1.parent.parent.f15);
            Assert.True(struct2.parent.parent.f16 == struct1.parent.parent.f16);
            Assert.True(struct2.parent.parent.f17 == struct1.parent.parent.f17);
            Assert.True(struct2.parent.parent.f18 == struct1.parent.parent.f18);
            Assert.True(struct2.parent.parent.f19 == struct1.parent.parent.f19);
            Assert.True(struct2.parent.parent.f20 == struct1.parent.parent.f20);
            Assert.True(struct2.parent.parent.f21 == struct1.parent.parent.f21);
            Assert.True(struct2.parent.parent.f22 == struct1.parent.parent.f22);
            Assert.True(struct2.parent.parent.f23 == struct1.parent.parent.f23);
            Assert.True(struct2.parent.parent.f24 == struct1.parent.parent.f24);
            Assert.True(struct2.parent.parent.f25 == struct1.parent.parent.f25);
            Assert.True(struct2.parent.parent.f26 == struct1.parent.parent.f26);
            Assert.True(struct2.parent.parent.f27 == struct1.parent.parent.f27);
            Assert.True(struct2.parent.parent.f28 == struct1.parent.parent.f28);
            Assert.True(struct2.parent.parent.f29 == struct1.parent.parent.f29);
            Assert.True(struct2.parent.parent.f30 == struct1.parent.parent.f30);
            Assert.True(struct2.parent.parent.f31 == struct1.parent.parent.f31);
            Assert.True(struct2.parent.parent.f32 == struct1.parent.parent.f32);
            Assert.True(struct2.parent.parent.f33 == struct1.parent.parent.f33);
            Assert.True(struct2.parent.parent.f34 == struct1.parent.parent.f34);
            Assert.True(struct2.parent.parent.f35 == struct1.parent.parent.f35);
            Assert.True(struct2.parent.parent.f36 == struct1.parent.parent.f36);
            Assert.True(struct2.parent.parent.f37 == struct1.parent.parent.f37);
            Assert.True(struct2.parent.parent.f38 == struct1.parent.parent.f38);
            Assert.True(struct2.parent.parent.f39 == struct1.parent.parent.f39);
            Assert.True(struct2.parent.parent.f40 == struct1.parent.parent.f40);

            Assert.True(struct2.parent.f100 == struct1.parent.f100);
            Assert.True(struct2.parent.f101 == struct1.parent.f101);
            Assert.True(struct2.parent.f102 == struct1.parent.f102);
            Assert.True(struct2.parent.f103 == struct1.parent.f103);
            Assert.True(struct2.parent.f104 == struct1.parent.f104);
            Assert.True(struct2.parent.f105 == struct1.parent.f105);
            Assert.True(struct2.parent.f106 == struct1.parent.f106);
            Assert.True(struct2.parent.f107 == struct1.parent.f107);
            Assert.True(struct2.parent.f108 == struct1.parent.f108);
            Assert.True(struct2.parent.f109 == struct1.parent.f109);
            Assert.True(struct2.parent.f110 == struct1.parent.f110);
            Assert.True(struct2.parent.f111 == struct1.parent.f111);
            Assert.True(struct2.parent.f112 == struct1.parent.f112);
            Assert.True(struct2.parent.f113 == struct1.parent.f113);
            Assert.True(struct2.parent.f114 == struct1.parent.f114);
            Assert.True(struct2.parent.f115 == struct1.parent.f115);
            Assert.True(struct2.parent.f116 == struct1.parent.f116);
            Assert.True(struct2.parent.f117 == struct1.parent.f117);
            Assert.True(struct2.parent.f118 == struct1.parent.f118);
            Assert.True(struct2.parent.f119 == struct1.parent.f119);
            Assert.True(struct2.parent.f120 == struct1.parent.f120);
            Assert.True(struct2.parent.f121 == struct1.parent.f121);
            Assert.True(struct2.parent.f122 == struct1.parent.f122);
            Assert.True(struct2.parent.f123 == struct1.parent.f123);
            Assert.True(struct2.parent.f124 == struct1.parent.f124);
            Assert.True(struct2.parent.f125 == struct1.parent.f125);
            Assert.True(struct2.parent.f126 == struct1.parent.f126);
            Assert.True(struct2.parent.f127 == struct1.parent.f127);
            Assert.True(struct2.parent.f128 == struct1.parent.f128);
            Assert.True(struct2.parent.f129 == struct1.parent.f129);
            Assert.True(struct2.parent.f130 == struct1.parent.f130);
            Assert.True(struct2.parent.f131 == struct1.parent.f131);
            Assert.True(struct2.parent.f132 == struct1.parent.f132);
            Assert.True(struct2.parent.f133 == struct1.parent.f133);
            Assert.True(struct2.parent.f134 == struct1.parent.f134);
            Assert.True(struct2.parent.f135 == struct1.parent.f135);
            Assert.True(struct2.parent.f136 == struct1.parent.f136);
            Assert.True(struct2.parent.f137 == struct1.parent.f137);
            Assert.True(struct2.parent.f138 == struct1.parent.f138);
            Assert.True(struct2.parent.f139 == struct1.parent.f139);
            Assert.True(struct2.parent.f140 == struct1.parent.f140);
            Assert.True(struct2.parent.f141 == struct1.parent.f141);
            Assert.True(struct2.parent.f142 == struct1.parent.f142);
            Assert.True(struct2.parent.f143 == struct1.parent.f143);
            Assert.True(struct2.parent.f144 == struct1.parent.f144);
            Assert.True(struct2.parent.f145 == struct1.parent.f145);
            Assert.True(struct2.parent.f146 == struct1.parent.f146);
            Assert.True(struct2.parent.f147 == struct1.parent.f147);
            Assert.True(struct2.parent.f148 == struct1.parent.f148);
            Assert.True(struct2.parent.f149 == struct1.parent.f149);
            Assert.True(struct2.parent.f150 == struct1.parent.f150);
            Assert.True(struct2.parent.f151 == struct1.parent.f151);
            Assert.True(struct2.parent.f152 == struct1.parent.f152);
            Assert.True(struct2.parent.f153 == struct1.parent.f153);
            Assert.True(struct2.parent.f154 == struct1.parent.f154);
            Assert.True(struct2.parent.f155 == struct1.parent.f155);
            Assert.True(struct2.parent.f156 == struct1.parent.f156);
            Assert.True(struct2.parent.f157 == struct1.parent.f157);

            Assert.True(struct2.f1000 == struct1.f1000);
            Assert.True(struct2.f1001 == struct1.f1001);
            Assert.True(struct2.f1002 == struct1.f1002);
            Assert.True(struct2.f1003 == struct1.f1003);
            Assert.True(struct2.f1004 == struct1.f1004);
            Assert.True(struct2.f1005 == struct1.f1005);
            Assert.True(struct2.f1006 == struct1.f1006);
            Assert.True(struct2.f1007 == struct1.f1007);
        }

        [Fact(DisplayName = "Serialization (JSON): struct bytes")]
        public void SerializationJsonStructBytes()
        {
            // Define a source JSON string
            var json = @"{""f1"":""QUJD"",""f2"":""dGVzdA=="",""f3"":null}";

            // Create a new struct from the source JSON string
            var struct1 = StructBytes.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructBytes.FromJson(json);

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

        [Fact(DisplayName = "Serialization (JSON): struct array")]
        public void SerializationJsonStructArray()
        {
            // Define a source JSON string
            var json = @"{""f1"":[48,65],""f2"":[97,null],""f3"":[""MDAw"",""QUFB""],""f4"":[""YWFh"",null],""f5"":[1,2],""f6"":[1,null],""f7"":[3,7],""f8"":[3,null],""f9"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145986060361000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""cedcad98-f0a6-11e8-9f47-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145986060910000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""cedcc274-f0a6-11e8-9f47-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}],""f10"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543145986061436000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""cedcd714-f0a6-11e8-9f47-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},null]}";

            // Create a new struct from the source JSON string
            var struct1 = StructArray.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructArray.FromJson(json);

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
            Assert.True(struct2.f10[0].HasValue);
            Assert.True(struct2.f10[0].Value.f2 == true);
            Assert.True(struct2.f10[0].Value.f12 == 255);
            Assert.True(struct2.f10[0].Value.f32 == "Initial string!");
            Assert.True(struct2.f10[1] == null);
        }

        [Fact(DisplayName = "Serialization (JSON): struct vector")]
        public void SerializationJsonStructVector()
        {
            // Define a source JSON string
            var json = @"{""f1"":[48,65],""f2"":[97,null],""f3"":[""MDAw"",""QUFB""],""f4"":[""YWFh"",null],""f5"":[1,2],""f6"":[1,null],""f7"":[3,7],""f8"":[3,null],""f9"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146157127964000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""34d38702-f0a7-11e8-b30e-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146157128572000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""34d39c88-f0a7-11e8-b30e-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}],""f10"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146157129063000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""34d3b038-f0a7-11e8-b30e-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},null]}";

            // Create a new struct from the source JSON string
            var struct1 = StructVector.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructVector.FromJson(json);

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
            Assert.True(struct2.f10[0].HasValue);
            Assert.True(struct2.f10[0].Value.f2 == true);
            Assert.True(struct2.f10[0].Value.f12 == 255);
            Assert.True(struct2.f10[0].Value.f32 == "Initial string!");
            Assert.True(struct2.f10[1] == null);
        }

        [Fact(DisplayName = "Serialization (JSON): struct list")]
        public void SerializationJsonStructList()
        {
            // Define a source JSON string
            var json = @"{""f1"":[48,65],""f2"":[97,null],""f3"":[""MDAw"",""QUFB""],""f4"":[""YWFh"",null],""f5"":[1,2],""f6"":[1,null],""f7"":[3,7],""f8"":[3,null],""f9"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146220253760000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""5a73e7fe-f0a7-11e8-89e6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146220255725000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""5a741990-f0a7-11e8-89e6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}],""f10"":[{""id"":0,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146220256802000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""5a74e4b0-f0a7-11e8-89e6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},null]}";

            // Create a new struct from the source JSON string
            var struct1 = StructList.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructList.FromJson(json);

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
            Assert.True(struct2.f10.First.Value.HasValue);
            Assert.True(struct2.f10.First.Value.Value.f2 == true);
            Assert.True(struct2.f10.First.Value.Value.f12 == 255);
            Assert.True(struct2.f10.First.Value.Value.f32 == "Initial string!");
            Assert.True(struct2.f10.Last.Value == null);
        }

        [Fact(DisplayName = "Serialization (JSON): struct set")]
        public void SerializationJsonStructSet()
        {
            // Define a source JSON string
            var json = @"{""f1"":[48,65,97],""f2"":[1,2],""f3"":[3,7],""f4"":[{""id"":48,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146299848353000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""89e4edd0-f0a7-11e8-9dde-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},{""id"":65,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146299848966000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""89e503f6-f0a7-11e8-9dde-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}]}";

            // Create a new struct from the source JSON string
            var struct1 = StructSet.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructSet.FromJson(json);

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
            var s1 = StructSimple.Default;
            s1.id = 48;
            Assert.True(struct2.f4.Contains(s1));
            var s2 = StructSimple.Default;
            s2.id = 65;
            Assert.True(struct2.f4.Contains(s2));
        }

        [Fact(DisplayName = "Serialization (JSON): struct map")]
        public void SerializationJsonStructMap()
        {
            // Define a source JSON string
            var json = @"{""f1"":{""10"":48,""20"":65},""f2"":{""10"":97,""20"":null},""f3"":{""10"":""MDAw"",""20"":""QUFB""},""f4"":{""10"":""YWFh"",""20"":null},""f5"":{""10"":1,""20"":2},""f6"":{""10"":1,""20"":null},""f7"":{""10"":3,""20"":7},""f8"":{""10"":3,""20"":null},""f9"":{""10"":{""id"":48,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146345803483000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""a549215e-f0a7-11e8-90f6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},""20"":{""id"":65,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146345804184000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""a54942ce-f0a7-11e8-90f6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}},""f10"":{""10"":{""id"":48,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146345803483000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""a549215e-f0a7-11e8-90f6-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},""20"":null}}";

            // Create a new struct from the source JSON string
            var struct1 = StructMap.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructMap.FromJson(json);

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
            Assert.True(struct2.f10[10].Value.id == 48);
            Assert.True(struct2.f10[20] == null);
        }

        [Fact(DisplayName = "Serialization (JSON): struct hash")]
        public void SerializationJsonStructHash()
        {
            // Define a source JSON string
            var json = @"{""f1"":{""10"":48,""20"":65},""f2"":{""10"":97,""20"":null},""f3"":{""10"":""MDAw"",""20"":""QUFB""},""f4"":{""10"":""YWFh"",""20"":null},""f5"":{""10"":1,""20"":2},""f6"":{""10"":1,""20"":null},""f7"":{""10"":3,""20"":7},""f8"":{""10"":3,""20"":null},""f9"":{""10"":{""id"":48,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146381450913000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""ba8885d2-f0a7-11e8-81fa-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},""20"":{""id"":65,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146381452825000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""ba88ced4-f0a7-11e8-81fa-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}}},""f10"":{""10"":{""id"":48,""f1"":false,""f2"":true,""f3"":0,""f4"":255,""f5"":0,""f6"":33,""f7"":0,""f8"":1092,""f9"":0,""f10"":127,""f11"":0,""f12"":255,""f13"":0,""f14"":32767,""f15"":0,""f16"":65535,""f17"":0,""f18"":2147483647,""f19"":0,""f20"":4294967295,""f21"":0,""f22"":9223372036854775807,""f23"":0,""f24"":18446744073709551615,""f25"":0.0,""f26"":123.456,""f27"":0.0,""f28"":-1.23456e+125,""f29"":""0.0"",""f30"":""123456.123456"",""f31"":"""",""f32"":""Initial string!"",""f33"":0,""f34"":0,""f35"":1543146381450913000,""f36"":""00000000-0000-0000-0000-000000000000"",""f37"":""ba8885d2-f0a7-11e8-81fa-ac220bcdd8e0"",""f38"":""123e4567-e89b-12d3-a456-426655440000"",""f39"":0,""f40"":0,""f41"":{""id"":0,""symbol"":"""",""side"":0,""type"":0,""price"":0.0,""volume"":0.0},""f42"":{""currency"":"""",""amount"":0.0},""f43"":0,""f44"":{""id"":0,""name"":"""",""state"":11,""wallet"":{""currency"":"""",""amount"":0.0},""asset"":null,""orders"":[]}},""20"":null}}";

            // Create a new struct from the source JSON string
            var struct1 = StructHash.FromJson(json);

            // Serialize the struct to the JSON string
            json = struct1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize the struct from the JSON string
            var struct2 = StructHash.FromJson(json);

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
            Assert.True(struct2.f10["10"].Value.id == 48);
            Assert.True(struct2.f10["20"] == null);
        }
    }
}
