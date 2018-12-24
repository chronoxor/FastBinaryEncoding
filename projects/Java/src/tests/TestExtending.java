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
        var account1 = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        account1.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        account1.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        account1.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        var writer = new proto.fbe.AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(account1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 252);

        // Deserialize the account from the FBE stream
        var account2 = new protoex.Account();
        var reader = new protoex.fbe.AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(account2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(account2.id, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertEquals(account2.state, protoex.StateEx.good);
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
        Assert.assertEquals(account2.orders.get(0).side, protoex.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, protoex.OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(0).tp, 10.0);
        Assert.assertEquals(account2.orders.get(0).sl, -10.0);
        Assert.assertEquals(account2.orders.get(1).id, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, protoex.OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, protoex.OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(1).tp, 10.0);
        Assert.assertEquals(account2.orders.get(1).sl, -10.0);
        Assert.assertEquals(account2.orders.get(2).id, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(2).side, protoex.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(2).type, protoex.OrderType.stop);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
        Assert.assertEquals(account2.orders.get(2).tp, 10.0);
        Assert.assertEquals(account2.orders.get(2).sl, -10.0);
    }

    @Test()
    public void extendingNewOld()
    {
        // Create a new account with some orders
        var account1 = new protoex.Account();
        account1.id = 1;
        account1.name = "Test";
        account1.state = protoex.StateEx.fromSet(EnumSet.of(protoex.StateEx.good.getEnum(), protoex.StateEx.happy.getEnum()));
        account1.wallet.currency = "USD";
        account1.wallet.amount = 1000.0;
        account1.wallet.locked = 123.456;
        account1.asset = new protoex.Balance();
        account1.asset.currency = "EUR";
        account1.asset.amount = 100.0;
        account1.asset.locked = 12.34;
        account1.orders.add(new protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
        account1.orders.add(new protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1));
        account1.orders.add(new protoex.Order(3, "EURUSD", protoex.OrderSide.tell, protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1));

        // Serialize the account to the FBE stream
        var writer = new protoex.fbe.AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long serialized = writer.serialize(account1);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 316);

        // Deserialize the account from the FBE stream
        var account2 = new proto.Account();
        var reader = new proto.fbe.AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());
        long deserialized = reader.deserialize(account2);
        Assert.assertEquals(deserialized, reader.getBuffer().getSize());
        reader.next(deserialized);
        Assert.assertEquals(reader.model.fbeOffset(), (4 + reader.getBuffer().getSize()));

        Assert.assertEquals(account2.id, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertTrue(account2.state.hasFlags(proto.State.good));
        Assert.assertEquals(account2.wallet.currency, "USD");
        Assert.assertEquals(account2.wallet.amount, 1000.0);
        Assert.assertNotEquals(account2.asset, null);
        Assert.assertEquals(account2.asset.currency, "EUR");
        Assert.assertEquals(account2.asset.amount, 100.0);
        Assert.assertEquals(account2.orders.size(), 3);
        Assert.assertEquals(account2.orders.get(0).id, 1);
        Assert.assertEquals(account2.orders.get(0).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(0).side, proto.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, proto.OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(1).id, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, proto.OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, proto.OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(2).id, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertNotEquals(account2.orders.get(2).side, proto.OrderSide.buy);
        Assert.assertNotEquals(account2.orders.get(2).type, proto.OrderType.market);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
    }
}
