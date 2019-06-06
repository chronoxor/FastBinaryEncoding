package tests;

import java.math.*;
import java.nio.ByteBuffer;
import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;
import com.chronoxor.test.*;
import com.chronoxor.test.fbe.*;

public class TestSerialization
{
    @Test()
    public void serializationDomain()
    {
        // Create a new account with some orders
        var account1 = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        account1.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        account1.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        account1.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        var writer = new AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(account1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 252);

        // Deserialize the account from the FBE stream
        var account2 = new Account();
        var reader = new AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(account2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructSimple()
    {
        // Create a new struct
        var struct1 = new StructSimple();

        // Serialize the struct to the FBE stream
        var writer = new StructSimpleModel();
        Assert.assertEquals(writer.model.fbeType(), 110);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 392);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructSimple();
        var reader = new StructSimpleModel();
        Assert.assertEquals(reader.model.fbeType(), 110);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructOptional()
    {
        // Create a new struct
        var struct1 = new StructOptional();

        // Serialize the struct to the FBE stream
        var writer = new StructOptionalModel();
        Assert.assertEquals(writer.model.fbeType(), 111);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 834);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructOptional();
        var reader = new StructOptionalModel();
        Assert.assertEquals(reader.model.fbeType(), 111);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructNested()
    {
        // Create a new struct
        var struct1 = new StructNested();

        // Serialize the struct to the FBE stream
        var writer = new StructNestedModel();
        Assert.assertEquals(writer.model.fbeType(), 112);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 2099);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructNested();
        var reader = new StructNestedModel();
        Assert.assertEquals(reader.model.fbeType(), 112);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructBytes()
    {
        // Create a new struct
        var struct1 = new StructBytes();
        struct1.f1 = ByteBuffer.wrap("ABC".getBytes());
        struct1.f2 = ByteBuffer.wrap("test".getBytes());

        // Serialize the struct to the FBE stream
        var writer = new StructBytesModel();
        Assert.assertEquals(writer.model.fbeType(), 120);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 49);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructBytes();
        var reader = new StructBytesModel();
        Assert.assertEquals(reader.model.fbeType(), 120);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructArray()
    {
        // Create a new struct
        var struct1 = new StructArray();
        struct1.f1[0] = 48;
        struct1.f1[1] = 65;
        struct1.f2[0] = 97;
        struct1.f2[1] = null;
        struct1.f3[0] = ByteBuffer.wrap("000".getBytes());
        struct1.f3[1] = ByteBuffer.wrap("AAA".getBytes());
        struct1.f4[0] = ByteBuffer.wrap("aaa".getBytes());
        struct1.f4[1] = null;
        struct1.f5[0] = EnumSimple.ENUM_VALUE_1;
        struct1.f5[1] = EnumSimple.ENUM_VALUE_2;
        struct1.f6[0] = EnumSimple.ENUM_VALUE_1;
        struct1.f6[1] = null;
        struct1.f7[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum()));
        struct1.f7[1] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum()));
        struct1.f8[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum()));
        struct1.f8[1] = null;
        struct1.f9[0] = new StructSimple();
        struct1.f9[1] = new StructSimple();
        struct1.f10[0] = new StructSimple();
        struct1.f10[1] = null;

        // Serialize the struct to the FBE stream
        var writer = new StructArrayModel();
        Assert.assertEquals(writer.model.fbeType(), 125);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 1290);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructArray();
        var reader = new StructArrayModel();
        Assert.assertEquals(reader.model.fbeType(), 125);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructVector()
    {
        // Create a new struct
        var struct1 = new StructVector();
        struct1.f1.add((byte)48);
        struct1.f1.add((byte)65);
        struct1.f2.add((byte)97);
        struct1.f2.add(null);
        struct1.f3.add(ByteBuffer.wrap("000".getBytes()));
        struct1.f3.add(ByteBuffer.wrap("AAA".getBytes()));
        struct1.f4.add(ByteBuffer.wrap("aaa".getBytes()));
        struct1.f4.add(null);
        struct1.f5.add(EnumSimple.ENUM_VALUE_1);
        struct1.f5.add(EnumSimple.ENUM_VALUE_2);
        struct1.f6.add(EnumSimple.ENUM_VALUE_1);
        struct1.f6.add(null);
        struct1.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        struct1.f8.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f8.add(null);
        struct1.f9.add(new StructSimple());
        struct1.f9.add(new StructSimple());
        struct1.f10.add(new StructSimple());
        struct1.f10.add(null);

        // Serialize the struct to the FBE stream
        var writer = new StructVectorModel();
        Assert.assertEquals(writer.model.fbeType(), 130);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 1370);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructVector();
        var reader = new StructVectorModel();
        Assert.assertEquals(reader.model.fbeType(), 130);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructList()
    {
        // Create a new struct
        var struct1 = new StructList();
        struct1.f1.addLast((byte)48);
        struct1.f1.addLast((byte)65);
        struct1.f2.addLast((byte)97);
        struct1.f2.addLast(null);
        struct1.f3.addLast(ByteBuffer.wrap("000".getBytes()));
        struct1.f3.addLast(ByteBuffer.wrap("AAA".getBytes()));
        struct1.f4.addLast(ByteBuffer.wrap("aaa".getBytes()));
        struct1.f4.addLast(null);
        struct1.f5.addLast(EnumSimple.ENUM_VALUE_1);
        struct1.f5.addLast(EnumSimple.ENUM_VALUE_2);
        struct1.f6.addLast(EnumSimple.ENUM_VALUE_1);
        struct1.f6.addLast(null);
        struct1.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        struct1.f8.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f8.addLast(null);
        struct1.f9.addLast(new StructSimple());
        struct1.f9.addLast(new StructSimple());
        struct1.f10.addLast(new StructSimple());
        struct1.f10.addLast(null);

        // Serialize the struct to the FBE stream
        var writer = new StructListModel();
        Assert.assertEquals(writer.model.fbeType(), 131);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 1370);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructList();
        var reader = new StructListModel();
        Assert.assertEquals(reader.model.fbeType(), 131);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructSet()
    {
        // Create a new struct
        var struct1 = new StructSet();
        struct1.f1.add((byte)48);
        struct1.f1.add((byte)65);
        struct1.f1.add((byte)97);
        struct1.f2.add(EnumSimple.ENUM_VALUE_1);
        struct1.f2.add(EnumSimple.ENUM_VALUE_2);
        struct1.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        var s1 = new StructSimple();
        s1.id = 48;
        struct1.f4.add(s1);
        var s2 = new StructSimple();
        s2.id = 65;
        struct1.f4.add(s2);

        // Serialize the struct to the FBE stream
        var writer = new StructSetModel();
        Assert.assertEquals(writer.model.fbeType(), 132);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 843);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructSet();
        var reader = new StructSetModel();
        Assert.assertEquals(reader.model.fbeType(), 132);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
        Assert.assertTrue(struct2.f4.contains(s1));
        Assert.assertTrue(struct2.f4.contains(s2));
    }

    @Test()
    public void serializationStructMap()
    {
        // Create a new struct
        var struct1 = new StructMap();
        struct1.f1.put(10, (byte)48);
        struct1.f1.put(20, (byte)65);
        struct1.f2.put(10, (byte)97);
        struct1.f2.put(20, null);
        struct1.f3.put(10, ByteBuffer.wrap("000".getBytes()));
        struct1.f3.put(20, ByteBuffer.wrap("AAA".getBytes()));
        struct1.f4.put(10, ByteBuffer.wrap("aaa".getBytes()));
        struct1.f4.put(20, null);
        struct1.f5.put(10, EnumSimple.ENUM_VALUE_1);
        struct1.f5.put(20, EnumSimple.ENUM_VALUE_2);
        struct1.f6.put(10, EnumSimple.ENUM_VALUE_1);
        struct1.f6.put(20, null);
        struct1.f7.put(10, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f7.put(20, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        struct1.f8.put(10, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f8.put(20, null);
        var s1 = new StructSimple();
        s1.id = 48;
        struct1.f9.put(10, s1);
        var s2 = new StructSimple();
        s2.id = 65;
        struct1.f9.put(20, s2);
        struct1.f10.put(10, s1);
        struct1.f10.put(20, null);

        // Serialize the struct to the FBE stream
        var writer = new StructMapModel();
        Assert.assertEquals(writer.model.fbeType(), 140);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 1450);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructMap();
        var reader = new StructMapModel();
        Assert.assertEquals(reader.model.fbeType(), 140);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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
    public void serializationStructHash()
    {
        // Create a new struct
        var struct1 = new StructHash();
        struct1.f1.put("10", (byte)48);
        struct1.f1.put("20", (byte)65);
        struct1.f2.put("10", (byte)97);
        struct1.f2.put("20", null);
        struct1.f3.put("10", ByteBuffer.wrap("000".getBytes()));
        struct1.f3.put("20", ByteBuffer.wrap("AAA".getBytes()));
        struct1.f4.put("10", ByteBuffer.wrap("aaa".getBytes()));
        struct1.f4.put("20", null);
        struct1.f5.put("10", EnumSimple.ENUM_VALUE_1);
        struct1.f5.put("20", EnumSimple.ENUM_VALUE_2);
        struct1.f6.put("10", EnumSimple.ENUM_VALUE_1);
        struct1.f6.put("20", null);
        struct1.f7.put("10", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f7.put("20", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        struct1.f8.put("10", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        struct1.f8.put("20", null);
        var s1 = new StructSimple();
        s1.id = 48;
        struct1.f9.put("10", s1);
        var s2 = new StructSimple();
        s2.id = 65;
        struct1.f9.put("20", s2);
        struct1.f10.put("10", s1);
        struct1.f10.put("20", null);

        // Serialize the struct to the FBE stream
        var writer = new StructHashModel();
        Assert.assertEquals(writer.model.fbeType(), 141);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 1570);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructHash();
        var reader = new StructHashModel();
        Assert.assertEquals(reader.model.fbeType(), 141);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

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

    @Test()
    public void serializationStructHashExtended()
    {
        // Create a new struct
        var struct1 = new StructHashEx();
        var s1 = new StructSimple();
        s1.id = 48;
        struct1.f1.put(s1, new StructNested());
        var s2 = new StructSimple();
        s2.id = 65;
        struct1.f1.put(s2, new StructNested());
        struct1.f2.put(s1, new StructNested());
        struct1.f2.put(s2, null);

        // Serialize the struct to the FBE stream
        var writer = new StructHashExModel();
        Assert.assertEquals(writer.model.fbeType(), 142);
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(struct1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 7879);

        // Deserialize the struct from the FBE stream
        var struct2 = new StructHashEx();
        var reader = new StructHashExModel();
        Assert.assertEquals(reader.model.fbeType(), 142);
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(struct2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(struct2.f1.size(), 2);
        Assert.assertEquals(struct2.f1.get(s1).f1002, EnumTyped.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f1.get(s2).f1002, EnumTyped.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f2.size(), 2);
        Assert.assertEquals(struct2.f2.get(s1).f1002, EnumTyped.ENUM_VALUE_2);
        Assert.assertEquals(struct2.f2.get(s2), null);
    }
}
