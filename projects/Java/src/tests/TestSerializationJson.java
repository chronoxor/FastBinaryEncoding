package tests;

import java.io.Console;
import java.math.*;
import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.proto.*;
import com.chronoxor.test.*;

public class TestSerializationJson
{
    @Test()
    public void serializationJsonDomain()
    {
        // Define a source JSON string
        var json = "{\"id\":1,\"name\":\"Test\",\"state\":6,\"wallet\":{\"currency\":\"USD\",\"amount\":1000.0},\"asset\":{\"currency\":\"EUR\",\"amount\":100.0},\"orders\":[{\"id\":1,\"symbol\":\"EURUSD\",\"side\":0,\"type\":0,\"price\":1.23456,\"volume\":1000.0},{\"id\":2,\"symbol\":\"EURUSD\",\"side\":1,\"type\":1,\"price\":1.0,\"volume\":100.0},{\"id\":3,\"symbol\":\"EURUSD\",\"side\":0,\"type\":2,\"price\":1.5,\"volume\":10.0}]}";

        // Create a new account from the source JSON string
        var account1 = Account.fromJson(json);

        // Serialize the account to the JSON string
        json = account1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the account from the JSON string
        var account2 = Account.fromJson(json);

        Assert.assertEquals(account2.id, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertTrue(account2.state.hasFlags(State.good));
        Assert.assertEquals(account2.wallet.currency, "USD");
        Assert.assertEquals(account2.wallet.amount, 1000.0);
        Assert.assertNotEquals(account2.asset, null);
        Assert.assertEquals(account2.asset.currency, "EUR");
        Assert.assertEquals(account2.asset.amount, 100.0);
        Assert.assertEquals(account2.orders.size(), 3);
        Assert.assertEquals(account2.orders.get(0).id, 1);
        Assert.assertEquals(account2.orders.get(0).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(0).side, OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(1).id, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(2).id, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(2).side, OrderSide.buy);
        Assert.assertEquals(account2.orders.get(2).type, OrderType.stop);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
    }

    @Test()
    public void serializationJsonStructSimple()
    {
        // Define a source JSON string
        var json = "{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145597933463000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"e7854072-f0a5-11e8-8f69-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}";

        // Create a new struct from the source JSON string
        var struct1 = StructSimple.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructSimple.fromJson(json);

        Assert.assertEquals(struct2.f1, false);
        Assert.assertEquals(struct2.f2, true);
        Assert.assertEquals(struct2.f3, 0);
        Assert.assertEquals(struct2.f4, (byte)0xFF);
        Assert.assertEquals(struct2.f5, '\0');
        Assert.assertEquals(struct2.f6, '!');
        Assert.assertEquals(struct2.f7, 0);
        Assert.assertEquals(struct2.f8, 0x0444);
        Assert.assertEquals(struct2.f9, 0);
        Assert.assertEquals(struct2.f10, 127);
        Assert.assertEquals(struct2.f11, 0);
        Assert.assertEquals(struct2.f12, (byte)0xFF);
        Assert.assertEquals(struct2.f13, 0);
        Assert.assertEquals(struct2.f14, 32767);
        Assert.assertEquals(struct2.f15, 0);
        Assert.assertEquals(struct2.f16, (short)0xFFFF);
        Assert.assertEquals(struct2.f17, 0);
        Assert.assertEquals(struct2.f18, 2147483647);
        Assert.assertEquals(struct2.f19, 0);
        Assert.assertEquals(struct2.f20, 0xFFFFFFFF);
        Assert.assertEquals(struct2.f21, 0);
        Assert.assertEquals(struct2.f22, 9223372036854775807L);
        Assert.assertEquals(struct2.f23, 0);
        Assert.assertEquals(struct2.f24, 0xFFFFFFFFFFFFFFFFL);
        Assert.assertEquals(struct2.f25, 0.0f);
        Assert.assertTrue(Math.abs(struct2.f26 - 123.456f) < 0.0001);
        Assert.assertEquals(struct2.f27, 0.0);
        Assert.assertTrue(Math.abs(struct2.f28 - -123.567e+123) < 1e+123);
        Assert.assertEquals(struct2.f29, BigDecimal.valueOf(0));
        Assert.assertEquals(struct2.f30, BigDecimal.valueOf(123456.123456));
        Assert.assertEquals(struct2.f31, "");
        Assert.assertEquals(struct2.f32, "Initial string!");
        Assert.assertTrue(struct2.f33.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f34.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f35.getEpochSecond() > new GregorianCalendar(2018, 1, 1).toInstant().getEpochSecond());
        Assert.assertTrue(struct2.f36.compareTo(new UUID(0, 0)) == 0);
        Assert.assertTrue(struct2.f37.compareTo(new UUID(0, 0)) != 0);
        Assert.assertTrue(struct2.f38.compareTo(UUID.fromString("123e4567-e89b-12d3-a456-426655440000")) == 0);

        Assert.assertEquals(struct2.f1, struct1.f1);
        Assert.assertEquals(struct2.f2, struct1.f2);
        Assert.assertEquals(struct2.f3, struct1.f3);
        Assert.assertEquals(struct2.f4, struct1.f4);
        Assert.assertEquals(struct2.f5, struct1.f5);
        Assert.assertEquals(struct2.f6, struct1.f6);
        Assert.assertEquals(struct2.f7, struct1.f7);
        Assert.assertEquals(struct2.f8, struct1.f8);
        Assert.assertEquals(struct2.f9, struct1.f9);
        Assert.assertEquals(struct2.f10, struct1.f10);
        Assert.assertEquals(struct2.f11, struct1.f11);
        Assert.assertEquals(struct2.f12, struct1.f12);
        Assert.assertEquals(struct2.f13, struct1.f13);
        Assert.assertEquals(struct2.f14, struct1.f14);
        Assert.assertEquals(struct2.f15, struct1.f15);
        Assert.assertEquals(struct2.f16, struct1.f16);
        Assert.assertEquals(struct2.f17, struct1.f17);
        Assert.assertEquals(struct2.f18, struct1.f18);
        Assert.assertEquals(struct2.f19, struct1.f19);
        Assert.assertEquals(struct2.f20, struct1.f20);
        Assert.assertEquals(struct2.f21, struct1.f21);
        Assert.assertEquals(struct2.f22, struct1.f22);
        Assert.assertEquals(struct2.f23, struct1.f23);
        Assert.assertEquals(struct2.f24, struct1.f24);
        Assert.assertEquals(struct2.f25, struct1.f25);
        Assert.assertEquals(struct2.f26, struct1.f26);
        Assert.assertEquals(struct2.f27, struct1.f27);
        Assert.assertEquals(struct2.f28, struct1.f28);
        Assert.assertEquals(struct2.f29, struct1.f29);
        Assert.assertEquals(struct2.f30, struct1.f30);
        Assert.assertEquals(struct2.f31, struct1.f31);
        Assert.assertEquals(struct2.f32, struct1.f32);
        Assert.assertEquals(struct2.f33, struct1.f33);
        Assert.assertEquals(struct2.f34, struct1.f34);
        Assert.assertEquals(struct2.f35, struct1.f35);
        Assert.assertEquals(struct2.f36, struct1.f36);
        Assert.assertEquals(struct2.f37, struct1.f37);
        Assert.assertEquals(struct2.f38, struct1.f38);
        Assert.assertEquals(struct2.f39, struct1.f39);
        Assert.assertEquals(struct2.f40, struct1.f40);
    }

    @Test()
    public void serializationJsonStructOptional()
    {
        // Define a source JSON string
        var json = "{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145860677797000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"8420d1c6-f0a6-11e8-80fc-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]},\"f100\":null,\"f101\":true,\"f102\":null,\"f103\":null,\"f104\":-1,\"f105\":null,\"f106\":null,\"f107\":33,\"f108\":null,\"f109\":null,\"f110\":1092,\"f111\":null,\"f112\":null,\"f113\":127,\"f114\":null,\"f115\":null,\"f116\":-1,\"f117\":null,\"f118\":null,\"f119\":32767,\"f120\":null,\"f121\":null,\"f122\":-1,\"f123\":null,\"f124\":null,\"f125\":2147483647,\"f126\":null,\"f127\":null,\"f128\":-1,\"f129\":null,\"f130\":null,\"f131\":9223372036854775807,\"f132\":null,\"f133\":null,\"f134\":-1,\"f135\":null,\"f136\":null,\"f137\":123.456,\"f138\":null,\"f139\":null,\"f140\":-1.23456e+125,\"f141\":null,\"f142\":null,\"f143\":\"123456.123456\",\"f144\":null,\"f145\":null,\"f146\":\"Initial string!\",\"f147\":null,\"f148\":null,\"f149\":1543145860678429000,\"f150\":null,\"f151\":null,\"f152\":\"123e4567-e89b-12d3-a456-426655440000\",\"f153\":null,\"f154\":null,\"f155\":null,\"f156\":null,\"f157\":null,\"f158\":null,\"f159\":null,\"f160\":null,\"f161\":null,\"f162\":null,\"f163\":null,\"f164\":null,\"f165\":null}";

        // Create a new struct from the source JSON string
        var struct1 = StructOptional.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructOptional.fromJson(json);

        Assert.assertEquals(struct2.f2, true);
        Assert.assertEquals(struct2.f1, false);
        Assert.assertEquals(struct2.f3, 0);
        Assert.assertEquals(struct2.f4, (byte)0xFF);
        Assert.assertEquals(struct2.f5, '\0');
        Assert.assertEquals(struct2.f6, '!');
        Assert.assertEquals(struct2.f7, 0);
        Assert.assertEquals(struct2.f8, 0x0444);
        Assert.assertEquals(struct2.f9, 0);
        Assert.assertEquals(struct2.f10, 127);
        Assert.assertEquals(struct2.f11, 0);
        Assert.assertEquals(struct2.f12, (byte)0xFF);
        Assert.assertEquals(struct2.f13, 0);
        Assert.assertEquals(struct2.f14, 32767);
        Assert.assertEquals(struct2.f15, 0);
        Assert.assertEquals(struct2.f16, (short)0xFFFF);
        Assert.assertEquals(struct2.f17, 0);
        Assert.assertEquals(struct2.f18, 2147483647);
        Assert.assertEquals(struct2.f19, 0);
        Assert.assertEquals(struct2.f20, 0xFFFFFFFF);
        Assert.assertEquals(struct2.f21, 0);
        Assert.assertEquals(struct2.f22, 9223372036854775807L);
        Assert.assertEquals(struct2.f23, 0);
        Assert.assertEquals(struct2.f24, 0xFFFFFFFFFFFFFFFFL);
        Assert.assertEquals(struct2.f25, 0.0f);
        Assert.assertTrue(Math.abs(struct2.f26 - 123.456f) < 0.0001);
        Assert.assertEquals(struct2.f27, 0.0);
        Assert.assertTrue(Math.abs(struct2.f28 - -123.567e+123) < 1e+123);
        Assert.assertEquals(struct2.f29, BigDecimal.valueOf(0));
        Assert.assertEquals(struct2.f30, BigDecimal.valueOf(123456.123456));
        Assert.assertEquals(struct2.f31, "");
        Assert.assertEquals(struct2.f32, "Initial string!");
        Assert.assertTrue(struct2.f33.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f34.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f35.getEpochSecond() > new GregorianCalendar(2018, 1, 1).toInstant().getEpochSecond());
        Assert.assertTrue(struct2.f36.compareTo(new UUID(0, 0)) == 0);
        Assert.assertTrue(struct2.f37.compareTo(new UUID(0, 0)) != 0);
        Assert.assertTrue(struct2.f38.compareTo(UUID.fromString("123e4567-e89b-12d3-a456-426655440000")) == 0);

        Assert.assertEquals(struct2.f100, null);
        Assert.assertNotEquals(struct2.f101, null);
        Assert.assertEquals(struct2.f101.booleanValue(), true);
        Assert.assertEquals(struct2.f102, null);
        Assert.assertEquals(struct2.f103, null);
        Assert.assertNotEquals(struct2.f104, null);
        Assert.assertEquals(struct2.f104.byteValue(), (byte)0xFF);
        Assert.assertEquals(struct2.f105, null);
        Assert.assertEquals(struct2.f106, null);
        Assert.assertNotEquals(struct2.f107, null);
        Assert.assertEquals(struct2.f107.charValue(), '!');
        Assert.assertEquals(struct2.f108, null);
        Assert.assertEquals(struct2.f109, null);
        Assert.assertNotEquals(struct2.f110, null);
        Assert.assertEquals(struct2.f110.charValue(), 0x0444);
        Assert.assertEquals(struct2.f111, null);
        Assert.assertEquals(struct2.f112, null);
        Assert.assertNotEquals(struct2.f113, null);
        Assert.assertEquals(struct2.f113.byteValue(), 127);
        Assert.assertEquals(struct2.f114, null);
        Assert.assertEquals(struct2.f115, null);
        Assert.assertNotEquals(struct2.f116, null);
        Assert.assertEquals(struct2.f116.byteValue(), (byte)0xFF);
        Assert.assertEquals(struct2.f117, null);
        Assert.assertEquals(struct2.f118, null);
        Assert.assertNotEquals(struct2.f119, null);
        Assert.assertEquals(struct2.f119.shortValue(), 32767);
        Assert.assertEquals(struct2.f120, null);
        Assert.assertEquals(struct2.f121, null);
        Assert.assertNotEquals(struct2.f122, null);
        Assert.assertEquals(struct2.f122.shortValue(), (short)0xFFFF);
        Assert.assertEquals(struct2.f123, null);
        Assert.assertEquals(struct2.f124, null);
        Assert.assertNotEquals(struct2.f125, null);
        Assert.assertEquals(struct2.f125.intValue(), 2147483647);
        Assert.assertEquals(struct2.f126, null);
        Assert.assertEquals(struct2.f127, null);
        Assert.assertNotEquals(struct2.f128, null);
        Assert.assertEquals(struct2.f128.intValue(), 0xFFFFFFFF);
        Assert.assertEquals(struct2.f129, null);
        Assert.assertEquals(struct2.f130, null);
        Assert.assertNotEquals(struct2.f131, null);
        Assert.assertEquals(struct2.f131.longValue(), 9223372036854775807L);
        Assert.assertEquals(struct2.f132, null);
        Assert.assertEquals(struct2.f133, null);
        Assert.assertNotEquals(struct2.f131, null);
        Assert.assertEquals(struct2.f134.longValue(), 0xFFFFFFFFFFFFFFFFL);
        Assert.assertEquals(struct2.f135, null);
        Assert.assertEquals(struct2.f136, null);
        Assert.assertNotEquals(struct2.f137, null);
        Assert.assertTrue(Math.abs(struct2.f137.floatValue() - 123.456f) < 0.0001);
        Assert.assertEquals(struct2.f138, null);
        Assert.assertEquals(struct2.f139, null);
        Assert.assertNotEquals(struct2.f140, null);
        Assert.assertTrue(Math.abs(struct2.f140.doubleValue() - -123.567e+123) < 1e+123);
        Assert.assertEquals(struct2.f141, null);
        Assert.assertEquals(struct2.f142, null);
        Assert.assertNotEquals(struct2.f143, null);
        Assert.assertEquals(struct2.f143, BigDecimal.valueOf(123456.123456));
        Assert.assertEquals(struct2.f144, null);
        Assert.assertEquals(struct2.f145, null);
        Assert.assertNotEquals(struct2.f146, null);
        Assert.assertEquals(struct2.f146, "Initial string!");
        Assert.assertEquals(struct2.f147, null);
        Assert.assertEquals(struct2.f148, null);
        Assert.assertNotEquals(struct2.f149, null);
        Assert.assertTrue(struct2.f149.getEpochSecond() > new GregorianCalendar(2018, 1, 1).toInstant().getEpochSecond());
        Assert.assertEquals(struct2.f150, null);
        Assert.assertEquals(struct2.f151, null);
        Assert.assertNotEquals(struct2.f152, null);
        Assert.assertTrue(struct2.f152.compareTo(UUID.fromString("123e4567-e89b-12d3-a456-426655440000")) == 0);
        Assert.assertEquals(struct2.f153, null);
        Assert.assertEquals(struct2.f154, null);
        Assert.assertEquals(struct2.f155, null);
        Assert.assertEquals(struct2.f156, null);
        Assert.assertEquals(struct2.f157, null);
        Assert.assertEquals(struct2.f158, null);
        Assert.assertEquals(struct2.f159, null);
        Assert.assertEquals(struct2.f160, null);
        Assert.assertEquals(struct2.f161, null);
        Assert.assertEquals(struct2.f162, null);
        Assert.assertEquals(struct2.f163, null);
        Assert.assertEquals(struct2.f164, null);
        Assert.assertEquals(struct2.f165, null);

        Assert.assertEquals(struct2.f1, struct1.f1);
        Assert.assertEquals(struct2.f2, struct1.f2);
        Assert.assertEquals(struct2.f3, struct1.f3);
        Assert.assertEquals(struct2.f4, struct1.f4);
        Assert.assertEquals(struct2.f5, struct1.f5);
        Assert.assertEquals(struct2.f6, struct1.f6);
        Assert.assertEquals(struct2.f7, struct1.f7);
        Assert.assertEquals(struct2.f8, struct1.f8);
        Assert.assertEquals(struct2.f9, struct1.f9);
        Assert.assertEquals(struct2.f10, struct1.f10);
        Assert.assertEquals(struct2.f11, struct1.f11);
        Assert.assertEquals(struct2.f12, struct1.f12);
        Assert.assertEquals(struct2.f13, struct1.f13);
        Assert.assertEquals(struct2.f14, struct1.f14);
        Assert.assertEquals(struct2.f15, struct1.f15);
        Assert.assertEquals(struct2.f16, struct1.f16);
        Assert.assertEquals(struct2.f17, struct1.f17);
        Assert.assertEquals(struct2.f18, struct1.f18);
        Assert.assertEquals(struct2.f19, struct1.f19);
        Assert.assertEquals(struct2.f20, struct1.f20);
        Assert.assertEquals(struct2.f21, struct1.f21);
        Assert.assertEquals(struct2.f22, struct1.f22);
        Assert.assertEquals(struct2.f23, struct1.f23);
        Assert.assertEquals(struct2.f24, struct1.f24);
        Assert.assertEquals(struct2.f25, struct1.f25);
        Assert.assertEquals(struct2.f26, struct1.f26);
        Assert.assertEquals(struct2.f27, struct1.f27);
        Assert.assertEquals(struct2.f28, struct1.f28);
        Assert.assertEquals(struct2.f29, struct1.f29);
        Assert.assertEquals(struct2.f30, struct1.f30);
        Assert.assertEquals(struct2.f31, struct1.f31);
        Assert.assertEquals(struct2.f32, struct1.f32);
        Assert.assertEquals(struct2.f33, struct1.f33);
        Assert.assertEquals(struct2.f34, struct1.f34);
        Assert.assertEquals(struct2.f35, struct1.f35);
        Assert.assertEquals(struct2.f36, struct1.f36);
        Assert.assertEquals(struct2.f37, struct1.f37);
        Assert.assertEquals(struct2.f38, struct1.f38);
        Assert.assertEquals(struct2.f39, struct1.f39);
        Assert.assertEquals(struct2.f40, struct1.f40);

        Assert.assertEquals(struct2.f100, struct1.f100);
        Assert.assertEquals(struct2.f101, struct1.f101);
        Assert.assertEquals(struct2.f102, struct1.f102);
        Assert.assertEquals(struct2.f103, struct1.f103);
        Assert.assertEquals(struct2.f104, struct1.f104);
        Assert.assertEquals(struct2.f105, struct1.f105);
        Assert.assertEquals(struct2.f106, struct1.f106);
        Assert.assertEquals(struct2.f107, struct1.f107);
        Assert.assertEquals(struct2.f108, struct1.f108);
        Assert.assertEquals(struct2.f109, struct1.f109);
        Assert.assertEquals(struct2.f110, struct1.f110);
        Assert.assertEquals(struct2.f111, struct1.f111);
        Assert.assertEquals(struct2.f112, struct1.f112);
        Assert.assertEquals(struct2.f113, struct1.f113);
        Assert.assertEquals(struct2.f114, struct1.f114);
        Assert.assertEquals(struct2.f115, struct1.f115);
        Assert.assertEquals(struct2.f116, struct1.f116);
        Assert.assertEquals(struct2.f117, struct1.f117);
        Assert.assertEquals(struct2.f118, struct1.f118);
        Assert.assertEquals(struct2.f119, struct1.f119);
        Assert.assertEquals(struct2.f120, struct1.f120);
        Assert.assertEquals(struct2.f121, struct1.f121);
        Assert.assertEquals(struct2.f122, struct1.f122);
        Assert.assertEquals(struct2.f123, struct1.f123);
        Assert.assertEquals(struct2.f124, struct1.f124);
        Assert.assertEquals(struct2.f125, struct1.f125);
        Assert.assertEquals(struct2.f126, struct1.f126);
        Assert.assertEquals(struct2.f127, struct1.f127);
        Assert.assertEquals(struct2.f128, struct1.f128);
        Assert.assertEquals(struct2.f129, struct1.f129);
        Assert.assertEquals(struct2.f130, struct1.f130);
        Assert.assertEquals(struct2.f131, struct1.f131);
        Assert.assertEquals(struct2.f132, struct1.f132);
        Assert.assertEquals(struct2.f133, struct1.f133);
        Assert.assertEquals(struct2.f134, struct1.f134);
        Assert.assertEquals(struct2.f135, struct1.f135);
        Assert.assertEquals(struct2.f136, struct1.f136);
        Assert.assertEquals(struct2.f137, struct1.f137);
        Assert.assertEquals(struct2.f138, struct1.f138);
        Assert.assertEquals(struct2.f139, struct1.f139);
        Assert.assertEquals(struct2.f140, struct1.f140);
        Assert.assertEquals(struct2.f141, struct1.f141);
        Assert.assertEquals(struct2.f142, struct1.f142);
        Assert.assertEquals(struct2.f143, struct1.f143);
        Assert.assertEquals(struct2.f144, struct1.f144);
        Assert.assertEquals(struct2.f145, struct1.f145);
        Assert.assertEquals(struct2.f146, struct1.f146);
        Assert.assertEquals(struct2.f147, struct1.f147);
        Assert.assertEquals(struct2.f148, struct1.f148);
        Assert.assertEquals(struct2.f149, struct1.f149);
        Assert.assertEquals(struct2.f150, struct1.f150);
        Assert.assertEquals(struct2.f151, struct1.f151);
        Assert.assertEquals(struct2.f152, struct1.f152);
        Assert.assertEquals(struct2.f153, struct1.f153);
        Assert.assertEquals(struct2.f154, struct1.f154);
        Assert.assertEquals(struct2.f155, struct1.f155);
        Assert.assertEquals(struct2.f156, struct1.f156);
        Assert.assertEquals(struct2.f157, struct1.f157);
    }

    @Test()
    public void serializationJsonStructNested()
    {
        // Define a source JSON string
        var json = "{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145901646321000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"9c8c268e-f0a6-11e8-a777-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]},\"f100\":null,\"f101\":true,\"f102\":null,\"f103\":null,\"f104\":-1,\"f105\":null,\"f106\":null,\"f107\":33,\"f108\":null,\"f109\":null,\"f110\":1092,\"f111\":null,\"f112\":null,\"f113\":127,\"f114\":null,\"f115\":null,\"f116\":-1,\"f117\":null,\"f118\":null,\"f119\":32767,\"f120\":null,\"f121\":null,\"f122\":-1,\"f123\":null,\"f124\":null,\"f125\":2147483647,\"f126\":null,\"f127\":null,\"f128\":-1,\"f129\":null,\"f130\":null,\"f131\":9223372036854775807,\"f132\":null,\"f133\":null,\"f134\":-1,\"f135\":null,\"f136\":null,\"f137\":123.456,\"f138\":null,\"f139\":null,\"f140\":-1.23456e+125,\"f141\":null,\"f142\":null,\"f143\":\"123456.123456\",\"f144\":null,\"f145\":null,\"f146\":\"Initial string!\",\"f147\":null,\"f148\":null,\"f149\":1543145901647155000,\"f150\":null,\"f151\":null,\"f152\":\"123e4567-e89b-12d3-a456-426655440000\",\"f153\":null,\"f154\":null,\"f155\":null,\"f156\":null,\"f157\":null,\"f158\":null,\"f159\":null,\"f160\":null,\"f161\":null,\"f162\":null,\"f163\":null,\"f164\":null,\"f165\":null,\"f1000\":0,\"f1001\":null,\"f1002\":50,\"f1003\":null,\"f1004\":0,\"f1005\":null,\"f1006\":42,\"f1007\":null,\"f1008\":{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145901647367000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"9c8c54c4-f0a6-11e8-a777-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},\"f1009\":null,\"f1010\":{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145901648310000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"9c8c6b76-f0a6-11e8-a777-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]},\"f100\":null,\"f101\":true,\"f102\":null,\"f103\":null,\"f104\":-1,\"f105\":null,\"f106\":null,\"f107\":33,\"f108\":null,\"f109\":null,\"f110\":1092,\"f111\":null,\"f112\":null,\"f113\":127,\"f114\":null,\"f115\":null,\"f116\":-1,\"f117\":null,\"f118\":null,\"f119\":32767,\"f120\":null,\"f121\":null,\"f122\":-1,\"f123\":null,\"f124\":null,\"f125\":2147483647,\"f126\":null,\"f127\":null,\"f128\":-1,\"f129\":null,\"f130\":null,\"f131\":9223372036854775807,\"f132\":null,\"f133\":null,\"f134\":-1,\"f135\":null,\"f136\":null,\"f137\":123.456,\"f138\":null,\"f139\":null,\"f140\":-1.23456e+125,\"f141\":null,\"f142\":null,\"f143\":\"123456.123456\",\"f144\":null,\"f145\":null,\"f146\":\"Initial string!\",\"f147\":null,\"f148\":null,\"f149\":1543145901648871000,\"f150\":null,\"f151\":null,\"f152\":\"123e4567-e89b-12d3-a456-426655440000\",\"f153\":null,\"f154\":null,\"f155\":null,\"f156\":null,\"f157\":null,\"f158\":null,\"f159\":null,\"f160\":null,\"f161\":null,\"f162\":null,\"f163\":null,\"f164\":null,\"f165\":null},\"f1011\":null}";

        // Create a new struct from the source JSON string
        var struct1 = StructNested.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructNested.fromJson(json);

        Assert.assertEquals(struct2.f1, false);
        Assert.assertEquals(struct2.f2, true);
        Assert.assertEquals(struct2.f3, 0);
        Assert.assertEquals(struct2.f4, (byte)0xFF);
        Assert.assertEquals(struct2.f5, '\0');
        Assert.assertEquals(struct2.f6, '!');
        Assert.assertEquals(struct2.f7, 0);
        Assert.assertEquals(struct2.f8, 0x0444);
        Assert.assertEquals(struct2.f9, 0);
        Assert.assertEquals(struct2.f10, 127);
        Assert.assertEquals(struct2.f11, 0);
        Assert.assertEquals(struct2.f12, (byte)0xFF);
        Assert.assertEquals(struct2.f13, 0);
        Assert.assertEquals(struct2.f14, 32767);
        Assert.assertEquals(struct2.f15, 0);
        Assert.assertEquals(struct2.f16, (short)0xFFFF);
        Assert.assertEquals(struct2.f17, 0);
        Assert.assertEquals(struct2.f18, 2147483647);
        Assert.assertEquals(struct2.f19, 0);
        Assert.assertEquals(struct2.f20, 0xFFFFFFFF);
        Assert.assertEquals(struct2.f21, 0);
        Assert.assertEquals(struct2.f22, 9223372036854775807L);
        Assert.assertEquals(struct2.f23, 0);
        Assert.assertEquals(struct2.f24, 0xFFFFFFFFFFFFFFFFL);
        Assert.assertEquals(struct2.f25, 0.0f);
        Assert.assertTrue(Math.abs(struct2.f26 - 123.456f) < 0.0001);
        Assert.assertEquals(struct2.f27, 0.0);
        Assert.assertTrue(Math.abs(struct2.f28 - -123.567e+123) < 1e+123);
        Assert.assertEquals(struct2.f29, BigDecimal.valueOf(0));
        Assert.assertEquals(struct2.f30, BigDecimal.valueOf(123456.123456));
        Assert.assertEquals(struct2.f31, "");
        Assert.assertEquals(struct2.f32, "Initial string!");
        Assert.assertTrue(struct2.f33.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f34.getEpochSecond() == 0);
        Assert.assertTrue(struct2.f35.getEpochSecond() > new GregorianCalendar(2018, 1, 1).toInstant().getEpochSecond());
        Assert.assertTrue(struct2.f36.compareTo(new UUID(0, 0)) == 0);
        Assert.assertTrue(struct2.f37.compareTo(new UUID(0, 0)) != 0);
        Assert.assertTrue(struct2.f38.compareTo(UUID.fromString("123e4567-e89b-12d3-a456-426655440000")) == 0);

        Assert.assertEquals(struct2.f100, null);
        Assert.assertNotEquals(struct2.f101, null);
        Assert.assertEquals(struct2.f101.booleanValue(), true);
        Assert.assertEquals(struct2.f102, null);
        Assert.assertEquals(struct2.f103, null);
        Assert.assertNotEquals(struct2.f104, null);
        Assert.assertEquals(struct2.f104.byteValue(), (byte)0xFF);
        Assert.assertEquals(struct2.f105, null);
        Assert.assertEquals(struct2.f106, null);
        Assert.assertNotEquals(struct2.f107, null);
        Assert.assertEquals(struct2.f107.charValue(), '!');
        Assert.assertEquals(struct2.f108, null);
        Assert.assertEquals(struct2.f109, null);
        Assert.assertNotEquals(struct2.f110, null);
        Assert.assertEquals(struct2.f110.charValue(), 0x0444);
        Assert.assertEquals(struct2.f111, null);
        Assert.assertEquals(struct2.f112, null);
        Assert.assertNotEquals(struct2.f113, null);
        Assert.assertEquals(struct2.f113.byteValue(), 127);
        Assert.assertEquals(struct2.f114, null);
        Assert.assertEquals(struct2.f115, null);
        Assert.assertNotEquals(struct2.f116, null);
        Assert.assertEquals(struct2.f116.byteValue(), (byte)0xFF);
        Assert.assertEquals(struct2.f117, null);
        Assert.assertEquals(struct2.f118, null);
        Assert.assertNotEquals(struct2.f119, null);
        Assert.assertEquals(struct2.f119.shortValue(), 32767);
        Assert.assertEquals(struct2.f120, null);
        Assert.assertEquals(struct2.f121, null);
        Assert.assertNotEquals(struct2.f122, null);
        Assert.assertEquals(struct2.f122.shortValue(), (short)0xFFFF);
        Assert.assertEquals(struct2.f123, null);
        Assert.assertEquals(struct2.f124, null);
        Assert.assertNotEquals(struct2.f125, null);
        Assert.assertEquals(struct2.f125.intValue(), 2147483647);
        Assert.assertEquals(struct2.f126, null);
        Assert.assertEquals(struct2.f127, null);
        Assert.assertNotEquals(struct2.f128, null);
        Assert.assertEquals(struct2.f128.intValue(), 0xFFFFFFFF);
        Assert.assertEquals(struct2.f129, null);
        Assert.assertEquals(struct2.f130, null);
        Assert.assertNotEquals(struct2.f131, null);
        Assert.assertEquals(struct2.f131.longValue(), 9223372036854775807L);
        Assert.assertEquals(struct2.f132, null);
        Assert.assertEquals(struct2.f133, null);
        Assert.assertNotEquals(struct2.f131, null);
        Assert.assertEquals(struct2.f134.longValue(), 0xFFFFFFFFFFFFFFFFL);
        Assert.assertEquals(struct2.f135, null);
        Assert.assertEquals(struct2.f136, null);
        Assert.assertNotEquals(struct2.f137, null);
        Assert.assertTrue(Math.abs(struct2.f137.floatValue() - 123.456f) < 0.0001);
        Assert.assertEquals(struct2.f138, null);
        Assert.assertEquals(struct2.f139, null);
        Assert.assertNotEquals(struct2.f140, null);
        Assert.assertTrue(Math.abs(struct2.f140.doubleValue() - -123.567e+123) < 1e+123);
        Assert.assertEquals(struct2.f141, null);
        Assert.assertEquals(struct2.f142, null);
        Assert.assertNotEquals(struct2.f143, null);
        Assert.assertEquals(struct2.f143, BigDecimal.valueOf(123456.123456));
        Assert.assertEquals(struct2.f144, null);
        Assert.assertEquals(struct2.f145, null);
        Assert.assertNotEquals(struct2.f146, null);
        Assert.assertEquals(struct2.f146, "Initial string!");
        Assert.assertEquals(struct2.f147, null);
        Assert.assertEquals(struct2.f148, null);
        Assert.assertNotEquals(struct2.f149, null);
        Assert.assertTrue(struct2.f149.getEpochSecond() > new GregorianCalendar(2018, 1, 1).toInstant().getEpochSecond());
        Assert.assertEquals(struct2.f150, null);
        Assert.assertEquals(struct2.f151, null);
        Assert.assertNotEquals(struct2.f152, null);
        Assert.assertTrue(struct2.f152.compareTo(UUID.fromString("123e4567-e89b-12d3-a456-426655440000")) == 0);
        Assert.assertEquals(struct2.f153, null);
        Assert.assertEquals(struct2.f154, null);
        Assert.assertEquals(struct2.f155, null);
        Assert.assertEquals(struct2.f156, null);
        Assert.assertEquals(struct2.f157, null);
        Assert.assertEquals(struct2.f158, null);
        Assert.assertEquals(struct2.f159, null);
        Assert.assertEquals(struct2.f160, null);
        Assert.assertEquals(struct2.f161, null);
        Assert.assertEquals(struct2.f162, null);
        Assert.assertEquals(struct2.f163, null);
        Assert.assertEquals(struct2.f164, null);
        Assert.assertEquals(struct2.f165, null);

        Assert.assertEquals(struct2.f1000, EnumSimple.ENUM_VALUE_0);
        Assert.assertEquals(struct2.f1001, null);
        Assert.assertEquals(struct2.f1002, EnumTyped.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f1003, null);
        Assert.assertEquals(struct2.f1004, FlagsSimple.FLAG_VALUE_0);
        Assert.assertEquals(struct2.f1005, null);
        Assert.assertEquals(struct2.f1006, FlagsTyped.fromSet(EnumSet.of(FlagsTyped.FLAG_VALUE_2.getEnum(), FlagsTyped.FLAG_VALUE_4.getEnum(), FlagsTyped.FLAG_VALUE_6.getEnum())));
        Assert.assertEquals(struct2.f1007, null);
        Assert.assertEquals(struct2.f1009, null);
        Assert.assertEquals(struct2.f1011, null);

        Assert.assertEquals(struct2.f1, struct1.f1);
        Assert.assertEquals(struct2.f2, struct1.f2);
        Assert.assertEquals(struct2.f3, struct1.f3);
        Assert.assertEquals(struct2.f4, struct1.f4);
        Assert.assertEquals(struct2.f5, struct1.f5);
        Assert.assertEquals(struct2.f6, struct1.f6);
        Assert.assertEquals(struct2.f7, struct1.f7);
        Assert.assertEquals(struct2.f8, struct1.f8);
        Assert.assertEquals(struct2.f9, struct1.f9);
        Assert.assertEquals(struct2.f10, struct1.f10);
        Assert.assertEquals(struct2.f11, struct1.f11);
        Assert.assertEquals(struct2.f12, struct1.f12);
        Assert.assertEquals(struct2.f13, struct1.f13);
        Assert.assertEquals(struct2.f14, struct1.f14);
        Assert.assertEquals(struct2.f15, struct1.f15);
        Assert.assertEquals(struct2.f16, struct1.f16);
        Assert.assertEquals(struct2.f17, struct1.f17);
        Assert.assertEquals(struct2.f18, struct1.f18);
        Assert.assertEquals(struct2.f19, struct1.f19);
        Assert.assertEquals(struct2.f20, struct1.f20);
        Assert.assertEquals(struct2.f21, struct1.f21);
        Assert.assertEquals(struct2.f22, struct1.f22);
        Assert.assertEquals(struct2.f23, struct1.f23);
        Assert.assertEquals(struct2.f24, struct1.f24);
        Assert.assertEquals(struct2.f25, struct1.f25);
        Assert.assertEquals(struct2.f26, struct1.f26);
        Assert.assertEquals(struct2.f27, struct1.f27);
        Assert.assertEquals(struct2.f28, struct1.f28);
        Assert.assertEquals(struct2.f29, struct1.f29);
        Assert.assertEquals(struct2.f30, struct1.f30);
        Assert.assertEquals(struct2.f31, struct1.f31);
        Assert.assertEquals(struct2.f32, struct1.f32);
        Assert.assertEquals(struct2.f33, struct1.f33);
        Assert.assertEquals(struct2.f34, struct1.f34);
        Assert.assertEquals(struct2.f35, struct1.f35);
        Assert.assertEquals(struct2.f36, struct1.f36);
        Assert.assertEquals(struct2.f37, struct1.f37);
        Assert.assertEquals(struct2.f38, struct1.f38);
        Assert.assertEquals(struct2.f39, struct1.f39);
        Assert.assertEquals(struct2.f40, struct1.f40);

        Assert.assertEquals(struct2.f100, struct1.f100);
        Assert.assertEquals(struct2.f101, struct1.f101);
        Assert.assertEquals(struct2.f102, struct1.f102);
        Assert.assertEquals(struct2.f103, struct1.f103);
        Assert.assertEquals(struct2.f104, struct1.f104);
        Assert.assertEquals(struct2.f105, struct1.f105);
        Assert.assertEquals(struct2.f106, struct1.f106);
        Assert.assertEquals(struct2.f107, struct1.f107);
        Assert.assertEquals(struct2.f108, struct1.f108);
        Assert.assertEquals(struct2.f109, struct1.f109);
        Assert.assertEquals(struct2.f110, struct1.f110);
        Assert.assertEquals(struct2.f111, struct1.f111);
        Assert.assertEquals(struct2.f112, struct1.f112);
        Assert.assertEquals(struct2.f113, struct1.f113);
        Assert.assertEquals(struct2.f114, struct1.f114);
        Assert.assertEquals(struct2.f115, struct1.f115);
        Assert.assertEquals(struct2.f116, struct1.f116);
        Assert.assertEquals(struct2.f117, struct1.f117);
        Assert.assertEquals(struct2.f118, struct1.f118);
        Assert.assertEquals(struct2.f119, struct1.f119);
        Assert.assertEquals(struct2.f120, struct1.f120);
        Assert.assertEquals(struct2.f121, struct1.f121);
        Assert.assertEquals(struct2.f122, struct1.f122);
        Assert.assertEquals(struct2.f123, struct1.f123);
        Assert.assertEquals(struct2.f124, struct1.f124);
        Assert.assertEquals(struct2.f125, struct1.f125);
        Assert.assertEquals(struct2.f126, struct1.f126);
        Assert.assertEquals(struct2.f127, struct1.f127);
        Assert.assertEquals(struct2.f128, struct1.f128);
        Assert.assertEquals(struct2.f129, struct1.f129);
        Assert.assertEquals(struct2.f130, struct1.f130);
        Assert.assertEquals(struct2.f131, struct1.f131);
        Assert.assertEquals(struct2.f132, struct1.f132);
        Assert.assertEquals(struct2.f133, struct1.f133);
        Assert.assertEquals(struct2.f134, struct1.f134);
        Assert.assertEquals(struct2.f135, struct1.f135);
        Assert.assertEquals(struct2.f136, struct1.f136);
        Assert.assertEquals(struct2.f137, struct1.f137);
        Assert.assertEquals(struct2.f138, struct1.f138);
        Assert.assertEquals(struct2.f139, struct1.f139);
        Assert.assertEquals(struct2.f140, struct1.f140);
        Assert.assertEquals(struct2.f141, struct1.f141);
        Assert.assertEquals(struct2.f142, struct1.f142);
        Assert.assertEquals(struct2.f143, struct1.f143);
        Assert.assertEquals(struct2.f144, struct1.f144);
        Assert.assertEquals(struct2.f145, struct1.f145);
        Assert.assertEquals(struct2.f146, struct1.f146);
        Assert.assertEquals(struct2.f147, struct1.f147);
        Assert.assertEquals(struct2.f148, struct1.f148);
        Assert.assertEquals(struct2.f149, struct1.f149);
        Assert.assertEquals(struct2.f150, struct1.f150);
        Assert.assertEquals(struct2.f151, struct1.f151);
        Assert.assertEquals(struct2.f152, struct1.f152);
        Assert.assertEquals(struct2.f153, struct1.f153);
        Assert.assertEquals(struct2.f154, struct1.f154);
        Assert.assertEquals(struct2.f155, struct1.f155);
        Assert.assertEquals(struct2.f156, struct1.f156);
        Assert.assertEquals(struct2.f157, struct1.f157);

        Assert.assertEquals(struct2.f1000, struct1.f1000);
        Assert.assertEquals(struct2.f1001, struct1.f1001);
        Assert.assertEquals(struct2.f1002, struct1.f1002);
        Assert.assertEquals(struct2.f1003, struct1.f1003);
        Assert.assertEquals(struct2.f1004, struct1.f1004);
        Assert.assertEquals(struct2.f1005, struct1.f1005);
        Assert.assertEquals(struct2.f1006, struct1.f1006);
        Assert.assertEquals(struct2.f1007, struct1.f1007);
    }

    @Test()
    public void serializationJsonStructBytes()
    {
        // Define a source JSON string
        var json = "{\"f1\":\"QUJD\",\"f2\":\"dGVzdA==\",\"f3\":null}";

        // Create a new struct from the source JSON string
        var struct1 = StructBytes.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructBytes.fromJson(json);

        Assert.assertEquals(struct2.f1.array().length, 3);
        Assert.assertEquals(struct2.f1.array()[0], (byte)'A');
        Assert.assertEquals(struct2.f1.array()[1], (byte)'B');
        Assert.assertEquals(struct2.f1.array()[2], (byte)'C');
        Assert.assertNotEquals(struct2.f2, null);
        Assert.assertEquals(struct2.f2.array().length, 4);
        Assert.assertEquals(struct2.f2.array()[0], (byte)'t');
        Assert.assertEquals(struct2.f2.array()[1], (byte)'e');
        Assert.assertEquals(struct2.f2.array()[2], (byte)'s');
        Assert.assertEquals(struct2.f2.array()[3], (byte)'t');
        Assert.assertEquals(struct2.f3, null);
    }

    @Test()
    public void serializationJsonStructArray()
    {
        // Define a source JSON string
        var json = "{\"f1\":[48,65],\"f2\":[97,null],\"f3\":[\"MDAw\",\"QUFB\"],\"f4\":[\"YWFh\",null],\"f5\":[1,2],\"f6\":[1,null],\"f7\":[3,7],\"f8\":[3,null],\"f9\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145986060361000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"cedcad98-f0a6-11e8-9f47-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145986060910000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"cedcc274-f0a6-11e8-9f47-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}],\"f10\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543145986061436000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"cedcd714-f0a6-11e8-9f47-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},null]}";

        // Create a new struct from the source JSON string
        var struct1 = StructArray.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructArray.fromJson(json);

        Assert.assertEquals(struct2.f1.length, 2);
        Assert.assertEquals(struct2.f1[0], 48);
        Assert.assertEquals(struct2.f1[1], 65);
        Assert.assertEquals(struct2.f2.length, 2);
        Assert.assertEquals(struct2.f2[0].byteValue(), 97);
        Assert.assertEquals(struct2.f2[1], null);
        Assert.assertEquals(struct2.f3.length, 2);
        Assert.assertEquals(struct2.f3[0].array().length, 3);
        Assert.assertEquals(struct2.f3[0].array()[0], 48);
        Assert.assertEquals(struct2.f3[0].array()[1], 48);
        Assert.assertEquals(struct2.f3[0].array()[2], 48);
        Assert.assertEquals(struct2.f3[1].array().length, 3);
        Assert.assertEquals(struct2.f3[1].array()[0], 65);
        Assert.assertEquals(struct2.f3[1].array()[1], 65);
        Assert.assertEquals(struct2.f3[1].array()[2], 65);
        Assert.assertEquals(struct2.f4.length, 2);
        Assert.assertNotEquals(struct2.f4[0], null);
        Assert.assertEquals(struct2.f4[0].array().length, 3);
        Assert.assertEquals(struct2.f4[0].array()[0], 97);
        Assert.assertEquals(struct2.f4[0].array()[1], 97);
        Assert.assertEquals(struct2.f4[0].array()[2], 97);
        Assert.assertEquals(struct2.f4[1], null);
        Assert.assertEquals(struct2.f5.length, 2);
        Assert.assertEquals(struct2.f5[0], EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f5[1], EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f6.length, 2);
        Assert.assertEquals(struct2.f6[0], EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f6[1], null);
        Assert.assertEquals(struct2.f7.length, 2);
        Assert.assertEquals(struct2.f7[0], FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f7[1], FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        Assert.assertEquals(struct2.f8.length, 2);
        Assert.assertEquals(struct2.f8[0], FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f8[1], null);
        Assert.assertEquals(struct2.f9.length, 2);
        Assert.assertEquals(struct2.f9[0].f2, true);
        Assert.assertEquals(struct2.f9[0].f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9[0].f32, "Initial string!");
        Assert.assertEquals(struct2.f9[1].f2, true);
        Assert.assertEquals(struct2.f9[1].f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9[1].f32, "Initial string!");
        Assert.assertEquals(struct2.f10.length, 2);
        Assert.assertNotEquals(struct2.f10[0], null);
        Assert.assertEquals(struct2.f10[0].f2, true);
        Assert.assertEquals(struct2.f10[0].f12, (byte)0xFF);
        Assert.assertEquals(struct2.f10[0].f32, "Initial string!");
        Assert.assertEquals(struct2.f10[1], null);
    }

    @Test()
    public void serializationJsonStructVector()
    {
        // Define a source JSON string
        var json = "{\"f1\":[48,65],\"f2\":[97,null],\"f3\":[\"MDAw\",\"QUFB\"],\"f4\":[\"YWFh\",null],\"f5\":[1,2],\"f6\":[1,null],\"f7\":[3,7],\"f8\":[3,null],\"f9\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157127964000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d38702-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157128572000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d39c88-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}],\"f10\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157129063000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d3b038-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},null]}";

        // Create a new struct from the source JSON string
        var struct1 = StructVector.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructVector.fromJson(json);

        Assert.assertEquals(struct2.f1.size(), 2);
        Assert.assertEquals(struct2.f1.get(0).byteValue(), 48);
        Assert.assertEquals(struct2.f1.get(1).byteValue(), 65);
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertEquals(struct2.f2.get(0).byteValue(), 97);
        Assert.assertEquals(struct2.f2.get(1), null);
        Assert.assertEquals(struct2.f3.size(), 2);
        Assert.assertEquals(struct2.f3.get(0).array().length, 3);
        Assert.assertEquals(struct2.f3.get(0).array()[0], 48);
        Assert.assertEquals(struct2.f3.get(0).array()[1], 48);
        Assert.assertEquals(struct2.f3.get(0).array()[2], 48);
        Assert.assertEquals(struct2.f3.get(1).array().length, 3);
        Assert.assertEquals(struct2.f3.get(1).array()[0], 65);
        Assert.assertEquals(struct2.f3.get(1).array()[1], 65);
        Assert.assertEquals(struct2.f3.get(1).array()[2], 65);
        Assert.assertEquals(struct2.f4.size(), 2);
        Assert.assertNotEquals(struct2.f4.get(0), null);
        Assert.assertEquals(struct2.f4.get(0).array().length, 3);
        Assert.assertEquals(struct2.f4.get(0).array()[0], 97);
        Assert.assertEquals(struct2.f4.get(0).array()[1], 97);
        Assert.assertEquals(struct2.f4.get(0).array()[2], 97);
        Assert.assertEquals(struct2.f4.get(1), null);
        Assert.assertEquals(struct2.f5.size(), 2);
        Assert.assertEquals(struct2.f5.get(0), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f5.get(1), EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f6.size(), 2);
        Assert.assertEquals(struct2.f6.get(0), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f6.get(1), null);
        Assert.assertEquals(struct2.f7.size(), 2);
        Assert.assertEquals(struct2.f7.get(0), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f7.get(1), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        Assert.assertEquals(struct2.f8.size(), 2);
        Assert.assertEquals(struct2.f8.get(0), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f8.get(1), null);
        Assert.assertEquals(struct2.f9.size(), 2);
        Assert.assertEquals(struct2.f9.get(0).f2, true);
        Assert.assertEquals(struct2.f9.get(0).f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9.get(0).f32, "Initial string!");
        Assert.assertEquals(struct2.f9.get(1).f2, true);
        Assert.assertEquals(struct2.f9.get(1).f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9.get(1).f32, "Initial string!");
        Assert.assertEquals(struct2.f10.size(), 2);
        Assert.assertNotEquals(struct2.f10.get(0), null);
        Assert.assertEquals(struct2.f10.get(0).f2, true);
        Assert.assertEquals(struct2.f10.get(0).f12, (byte)0xFF);
        Assert.assertEquals(struct2.f10.get(0).f32, "Initial string!");
        Assert.assertEquals(struct2.f10.get(1), null);
    }

    @Test()
    public void serializationJsonStructList()
    {
        // Define a source JSON string
        var json = "{\"f1\":[48,65],\"f2\":[97,null],\"f3\":[\"MDAw\",\"QUFB\"],\"f4\":[\"YWFh\",null],\"f5\":[1,2],\"f6\":[1,null],\"f7\":[3,7],\"f8\":[3,null],\"f9\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157127964000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d38702-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157128572000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d39c88-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}],\"f10\":[{\"id\":0,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146157129063000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"34d3b038-f0a7-11e8-b30e-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},null]}";

        // Create a new struct from the source JSON string
        var struct1 = StructList.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructList.fromJson(json);

        Assert.assertEquals(struct2.f1.size(), 2);
        Assert.assertEquals(struct2.f1.getFirst().byteValue(), 48);
        Assert.assertEquals(struct2.f1.getLast().byteValue(), 65);
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertEquals(struct2.f2.getFirst().byteValue(), 97);
        Assert.assertEquals(struct2.f2.getLast(), null);
        Assert.assertEquals(struct2.f3.size(), 2);
        Assert.assertEquals(struct2.f3.getFirst().array().length, 3);
        Assert.assertEquals(struct2.f3.getFirst().array()[0], 48);
        Assert.assertEquals(struct2.f3.getFirst().array()[1], 48);
        Assert.assertEquals(struct2.f3.getFirst().array()[2], 48);
        Assert.assertEquals(struct2.f3.getLast().array().length, 3);
        Assert.assertEquals(struct2.f3.getLast().array()[0], 65);
        Assert.assertEquals(struct2.f3.getLast().array()[1], 65);
        Assert.assertEquals(struct2.f3.getLast().array()[2], 65);
        Assert.assertEquals(struct2.f4.size(), 2);
        Assert.assertNotEquals(struct2.f4.getFirst(), null);
        Assert.assertEquals(struct2.f4.getFirst().array().length, 3);
        Assert.assertEquals(struct2.f4.getFirst().array()[0], 97);
        Assert.assertEquals(struct2.f4.getFirst().array()[1], 97);
        Assert.assertEquals(struct2.f4.getFirst().array()[2], 97);
        Assert.assertEquals(struct2.f4.getLast(), null);
        Assert.assertEquals(struct2.f5.size(), 2);
        Assert.assertEquals(struct2.f5.getFirst(), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f5.getLast(), EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f6.size(), 2);
        Assert.assertEquals(struct2.f6.getFirst(), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f6.getLast(), null);
        Assert.assertEquals(struct2.f7.size(), 2);
        Assert.assertEquals(struct2.f7.getFirst(), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f7.getLast(), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        Assert.assertEquals(struct2.f8.size(), 2);
        Assert.assertEquals(struct2.f8.getFirst(), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f8.getLast(), null);
        Assert.assertEquals(struct2.f9.size(), 2);
        Assert.assertEquals(struct2.f9.getFirst().f2, true);
        Assert.assertEquals(struct2.f9.getFirst().f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9.getFirst().f32, "Initial string!");
        Assert.assertEquals(struct2.f9.getLast().f2, true);
        Assert.assertEquals(struct2.f9.getLast().f12, (byte)0xFF);
        Assert.assertEquals(struct2.f9.getLast().f32, "Initial string!");
        Assert.assertEquals(struct2.f10.size(), 2);
        Assert.assertNotEquals(struct2.f10.getFirst(), null);
        Assert.assertEquals(struct2.f10.getFirst().f2, true);
        Assert.assertEquals(struct2.f10.getFirst().f12, (byte)0xFF);
        Assert.assertEquals(struct2.f10.getFirst().f32, "Initial string!");
        Assert.assertEquals(struct2.f10.getLast(), null);
    }

    @Test()
    public void serializationJsonStructSet()
    {
        // Define a source JSON string
        var json = "{\"f1\":[48,65,97],\"f2\":[1,2],\"f3\":[3,7],\"f4\":[{\"id\":48,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146299848353000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"89e4edd0-f0a7-11e8-9dde-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},{\"id\":65,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146299848966000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"89e503f6-f0a7-11e8-9dde-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}]}";

        // Create a new struct from the source JSON string
        var struct1 = StructSet.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructSet.fromJson(json);

        Assert.assertEquals(struct2.f1.size(), 3);
        Assert.assertTrue(struct2.f1.contains((byte)48));
        Assert.assertTrue(struct2.f1.contains((byte)65));
        Assert.assertTrue(struct2.f1.contains((byte)97));
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertTrue(struct2.f2.contains(EnumSimple.ENUM_VALUE_1));
        Assert.assertTrue(struct2.f2.contains(EnumSimple.ENUM_VALUE_2));
        Assert.assertEquals(struct2.f3.size(), 2);
        Assert.assertTrue(struct2.f3.contains(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum()))));
        Assert.assertTrue(struct2.f3.contains(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum()))));
        Assert.assertEquals(struct2.f4.size(), 2);
        var s1 = new StructSimple();
        s1.id = 48;
        Assert.assertTrue(struct2.f4.contains(s1));
        var s2 = new StructSimple();
        s2.id = 65;
        Assert.assertTrue(struct2.f4.contains(s2));
    }

    @Test()
    public void serializationJsonStructMap()
    {
        // Define a source JSON string
        var json = "{\"f1\":{\"10\":48,\"20\":65},\"f2\":{\"10\":97,\"20\":null},\"f3\":{\"10\":\"MDAw\",\"20\":\"QUFB\"},\"f4\":{\"10\":\"YWFh\",\"20\":null},\"f5\":{\"10\":1,\"20\":2},\"f6\":{\"10\":1,\"20\":null},\"f7\":{\"10\":3,\"20\":7},\"f8\":{\"10\":3,\"20\":null},\"f9\":{\"10\":{\"id\":48,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345803483000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a549215e-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},\"20\":{\"id\":65,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345804184000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a54942ce-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}},\"f10\":{\"10\":{\"id\":48,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345803483000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a549215e-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},\"20\":null}}";

        // Create a new struct from the source JSON string
        var struct1 = StructMap.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructMap.fromJson(json);

        Assert.assertEquals(struct2.f1.size(), 2);
        Assert.assertEquals(struct2.f1.get(10).byteValue(), 48);
        Assert.assertEquals(struct2.f1.get(20).byteValue(), 65);
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertEquals(struct2.f2.get(10).byteValue(), 97);
        Assert.assertEquals(struct2.f2.get(20), null);
        Assert.assertEquals(struct2.f3.size(), 2);
        Assert.assertEquals(struct2.f3.get(10).array().length, 3);
        Assert.assertEquals(struct2.f3.get(20).array().length, 3);
        Assert.assertEquals(struct2.f4.size(), 2);
        Assert.assertEquals(struct2.f4.get(10).array().length, 3);
        Assert.assertEquals(struct2.f4.get(20), null);
        Assert.assertEquals(struct2.f5.size(), 2);
        Assert.assertEquals(struct2.f5.get(10), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f5.get(20), EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f6.size(), 2);
        Assert.assertEquals(struct2.f6.get(10), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f6.get(20), null);
        Assert.assertEquals(struct2.f7.size(), 2);
        Assert.assertEquals(struct2.f7.get(10), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f7.get(20), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        Assert.assertEquals(struct2.f8.size(), 2);
        Assert.assertEquals(struct2.f8.get(10), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f8.get(20), null);
        Assert.assertEquals(struct2.f9.size(), 2);
        Assert.assertEquals(struct2.f9.get(10).id, 48);
        Assert.assertEquals(struct2.f9.get(20).id, 65);
        Assert.assertEquals(struct2.f10.size(), 2);
        Assert.assertEquals(struct2.f10.get(10).id, 48);
        Assert.assertEquals(struct2.f10.get(20), null);
    }

    @Test()
    public void serializationJsonStructHash()
    {
        // Define a source JSON string
        var json = "{\"f1\":{\"10\":48,\"20\":65},\"f2\":{\"10\":97,\"20\":null},\"f3\":{\"10\":\"MDAw\",\"20\":\"QUFB\"},\"f4\":{\"10\":\"YWFh\",\"20\":null},\"f5\":{\"10\":1,\"20\":2},\"f6\":{\"10\":1,\"20\":null},\"f7\":{\"10\":3,\"20\":7},\"f8\":{\"10\":3,\"20\":null},\"f9\":{\"10\":{\"id\":48,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345803483000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a549215e-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},\"20\":{\"id\":65,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345804184000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a54942ce-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}}},\"f10\":{\"10\":{\"id\":48,\"f1\":false,\"f2\":true,\"f3\":0,\"f4\":-1,\"f5\":0,\"f6\":33,\"f7\":0,\"f8\":1092,\"f9\":0,\"f10\":127,\"f11\":0,\"f12\":-1,\"f13\":0,\"f14\":32767,\"f15\":0,\"f16\":-1,\"f17\":0,\"f18\":2147483647,\"f19\":0,\"f20\":-1,\"f21\":0,\"f22\":9223372036854775807,\"f23\":0,\"f24\":-1,\"f25\":0.0,\"f26\":123.456,\"f27\":0.0,\"f28\":-1.23456e+125,\"f29\":\"0\",\"f30\":\"123456.123456\",\"f31\":\"\",\"f32\":\"Initial string!\",\"f33\":0,\"f34\":0,\"f35\":1543146345803483000,\"f36\":\"00000000-0000-0000-0000-000000000000\",\"f37\":\"a549215e-f0a7-11e8-90f6-ac220bcdd8e0\",\"f38\":\"123e4567-e89b-12d3-a456-426655440000\",\"f39\":0,\"f40\":0,\"f41\":{\"id\":0,\"symbol\":\"\",\"side\":0,\"type\":0,\"price\":0.0,\"volume\":0.0},\"f42\":{\"currency\":\"\",\"amount\":0.0},\"f43\":0,\"f44\":{\"id\":0,\"name\":\"\",\"state\":11,\"wallet\":{\"currency\":\"\",\"amount\":0.0},\"asset\":null,\"orders\":[]}},\"20\":null}}";

        // Create a new struct from the source JSON string
        var struct1 = StructHash.fromJson(json);

        // Serialize the struct to the JSON string
        json = struct1.toJson();

        // Check the serialized JSON size
        Assert.assertTrue(json.length() > 0);

        // Deserialize the struct from the JSON string
        var struct2 = StructHash.fromJson(json);

        Assert.assertEquals(struct2.f1.size(), 2);
        Assert.assertEquals(struct2.f1.get("10").byteValue(), 48);
        Assert.assertEquals(struct2.f1.get("20").byteValue(), 65);
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertEquals(struct2.f2.get("10").byteValue(), 97);
        Assert.assertEquals(struct2.f2.get("20"), null);
        Assert.assertEquals(struct2.f3.size(), 2);
        Assert.assertEquals(struct2.f3.get("10").array().length, 3);
        Assert.assertEquals(struct2.f3.get("20").array().length, 3);
        Assert.assertEquals(struct2.f4.size(), 2);
        Assert.assertEquals(struct2.f4.get("10").array().length, 3);
        Assert.assertEquals(struct2.f4.get("20"), null);
        Assert.assertEquals(struct2.f5.size(), 2);
        Assert.assertEquals(struct2.f5.get("10"), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f5.get("20"), EnumSimple.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f6.size(), 2);
        Assert.assertEquals(struct2.f6.get("10"), EnumSimple.ENUM_VALUE_1);
        Assert.assertEquals(struct2.f6.get("20"), null);
        Assert.assertEquals(struct2.f7.size(), 2);
        Assert.assertEquals(struct2.f7.get("10"), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f7.get("20"), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        Assert.assertEquals(struct2.f8.size(), 2);
        Assert.assertEquals(struct2.f8.get("10"), FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        Assert.assertEquals(struct2.f8.get("20"), null);
        Assert.assertEquals(struct2.f9.size(), 2);
        Assert.assertEquals(struct2.f9.get("10").id, 48);
        Assert.assertEquals(struct2.f9.get("20").id, 65);
        Assert.assertEquals(struct2.f10.size(), 2);
        Assert.assertEquals(struct2.f10.get("10").id, 48);
        Assert.assertEquals(struct2.f10.get("20"), null);
    }
}
