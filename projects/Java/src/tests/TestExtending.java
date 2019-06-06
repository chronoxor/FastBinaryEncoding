package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

public class TestExtending
{
    @Test()
    public void extendingOldNew()
    {
        // Create a new account with some orders
        var account1 = new com.chronoxor.proto.Account(1, "Test", com.chronoxor.proto.State.good, new com.chronoxor.proto.Balance("USD", 1000.0), new com.chronoxor.proto.Balance("EUR", 100.0), new ArrayList<com.chronoxor.proto.Order>());
        account1.orders.add(new com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0));
        account1.orders.add(new com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0));
        account1.orders.add(new com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        var writer = new com.chronoxor.proto.fbe.AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(account1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 252);

        // Deserialize the account from the FBE stream
        var account2 = new com.chronoxor.protoex.Account();
        var reader = new com.chronoxor.protoex.fbe.AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(account2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(account2.id, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertEquals(account2.state, com.chronoxor.protoex.StateEx.good);
        Assert.assertEquals(account2.wallet.currency, "USD");
        Assert.assertEquals(account2.wallet.amount, 1000.0);
        Assert.assertEquals(account2.wallet.locked, 0.0);
        Assert.assertNotEquals(account2.asset, null);
        Assert.assertEquals(account2.asset.currency, "EUR");
        Assert.assertEquals(account2.asset.amount, 100.0);
        Assert.assertEquals(account2.asset.locked, 0.0);
        Assert.assertEquals(account2.orders.size(), 3);
        Assert.assertEquals(account2.orders.get(0).id, 1);
        Assert.assertEquals(account2.orders.get(0).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(0).side, com.chronoxor.protoex.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, com.chronoxor.protoex.OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(0).tp, 10.0);
        Assert.assertEquals(account2.orders.get(0).sl, -10.0);
        Assert.assertEquals(account2.orders.get(1).id, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, com.chronoxor.protoex.OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, com.chronoxor.protoex.OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(1).tp, 10.0);
        Assert.assertEquals(account2.orders.get(1).sl, -10.0);
        Assert.assertEquals(account2.orders.get(2).id, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(2).side, com.chronoxor.protoex.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(2).type, com.chronoxor.protoex.OrderType.stop);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
        Assert.assertEquals(account2.orders.get(2).tp, 10.0);
        Assert.assertEquals(account2.orders.get(2).sl, -10.0);
    }

    @Test()
    public void extendingNewOld()
    {
        // Create a new account with some orders
        var account1 = new com.chronoxor.protoex.Account();
        account1.id = 1;
        account1.name = "Test";
        account1.state = com.chronoxor.protoex.StateEx.fromSet(EnumSet.of(com.chronoxor.protoex.StateEx.good.getEnum(), com.chronoxor.protoex.StateEx.happy.getEnum()));
        account1.wallet.currency = "USD";
        account1.wallet.amount = 1000.0;
        account1.wallet.locked = 123.456;
        account1.asset = new com.chronoxor.protoex.Balance();
        account1.asset.currency = "EUR";
        account1.asset.amount = 100.0;
        account1.asset.locked = 12.34;
        account1.orders.add(new com.chronoxor.protoex.Order(1, "EURUSD", com.chronoxor.protoex.OrderSide.buy, com.chronoxor.protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
        account1.orders.add(new com.chronoxor.protoex.Order(2, "EURUSD", com.chronoxor.protoex.OrderSide.sell, com.chronoxor.protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1));
        account1.orders.add(new com.chronoxor.protoex.Order(3, "EURUSD", com.chronoxor.protoex.OrderSide.tell, com.chronoxor.protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1));

        // Serialize the account to the FBE stream
        var writer = new com.chronoxor.protoex.fbe.AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(account1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 316);

        // Deserialize the account from the FBE stream
        var account2 = new com.chronoxor.proto.Account();
        var reader = new com.chronoxor.proto.fbe.AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(account2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(account2.id, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertTrue(account2.state.hasFlags(com.chronoxor.proto.State.good));
        Assert.assertEquals(account2.wallet.currency, "USD");
        Assert.assertEquals(account2.wallet.amount, 1000.0);
        Assert.assertNotEquals(account2.asset, null);
        Assert.assertEquals(account2.asset.currency, "EUR");
        Assert.assertEquals(account2.asset.amount, 100.0);
        Assert.assertEquals(account2.orders.size(), 3);
        Assert.assertEquals(account2.orders.get(0).id, 1);
        Assert.assertEquals(account2.orders.get(0).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(0).side, com.chronoxor.proto.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, com.chronoxor.proto.OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(1).id, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, com.chronoxor.proto.OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, com.chronoxor.proto.OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(2).id, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertNotEquals(account2.orders.get(2).side, com.chronoxor.proto.OrderSide.buy);
        Assert.assertNotEquals(account2.orders.get(2).type, com.chronoxor.proto.OrderType.market);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
    }
}
