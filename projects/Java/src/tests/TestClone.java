package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.proto.*;

public class TestClone
{
    @Test()
    public void cloneStructs()
    {
        // Create a new account with some orders
        var account1 = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        account1.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        account1.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        account1.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Clone the account
        Account account2 = account1.clone();

        // Clear the source account
        account1 = new Account();

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
}
