package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

public class TestClone
{
    @Test()
    public void CloneStructs()
    {
        // Create a new account with some orders
        var account1 = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        account1.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        account1.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        account1.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

        // Clone the account
        proto.Account account2 = account1.clone();

        // Clear the source account
        account1 = new proto.Account();

        Assert.assertEquals(account2.uid, 1);
        Assert.assertEquals(account2.name, "Test");
        Assert.assertTrue(account2.state.hasFlags(proto.State.good));
        Assert.assertEquals(account2.wallet.currency, "USD");
        Assert.assertEquals(account2.wallet.amount, 1000.0);
        Assert.assertNotEquals(account2.asset, null);
        Assert.assertEquals(account2.asset.currency, "EUR");
        Assert.assertEquals(account2.asset.amount, 100.0);
        Assert.assertEquals(account2.orders.size(), 3);
        Assert.assertEquals(account2.orders.get(0).uid, 1);
        Assert.assertEquals(account2.orders.get(0).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(0).side, proto.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(0).type, proto.OrderType.market);
        Assert.assertEquals(account2.orders.get(0).price, 1.23456);
        Assert.assertEquals(account2.orders.get(0).volume, 1000.0);
        Assert.assertEquals(account2.orders.get(1).uid, 2);
        Assert.assertEquals(account2.orders.get(1).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(1).side, proto.OrderSide.sell);
        Assert.assertEquals(account2.orders.get(1).type, proto.OrderType.limit);
        Assert.assertEquals(account2.orders.get(1).price, 1.0);
        Assert.assertEquals(account2.orders.get(1).volume, 100.0);
        Assert.assertEquals(account2.orders.get(2).uid, 3);
        Assert.assertEquals(account2.orders.get(2).symbol, "EURUSD");
        Assert.assertEquals(account2.orders.get(2).side, proto.OrderSide.buy);
        Assert.assertEquals(account2.orders.get(2).type, proto.OrderType.stop);
        Assert.assertEquals(account2.orders.get(2).price, 1.5);
        Assert.assertEquals(account2.orders.get(2).volume, 10.0);
    }
}
