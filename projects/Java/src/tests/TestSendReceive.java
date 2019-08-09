package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;

class MySender extends Sender
{
    @Override
    protected long onSend(byte[] buffer, long offset, long size)
    {
        // Send nothing...
        return 0;
    }
}

class MyReceiver extends Receiver
{
    private boolean _order;
    private boolean _balance;
    private boolean _account;

    public boolean check() { return _order && _balance && _account; }

    @Override
    protected void onReceive(OrderMessage value) { _order = true; }
    @Override
    protected void onReceive(BalanceMessage value) { _balance = true; }
    @Override
    protected void onReceive(AccountMessage value) { _account = true; }
}

public class TestSendReceive
{
    public static boolean sendAndReceive(long index1, long index2)
    {
        var sender = new MySender();

        // Create and send a new order
        var order = new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0);
        sender.send(new OrderMessage(order));

        // Create and send a new balance wallet
        var balance = new Balance("USD", 1000.0);
        sender.send(new BalanceMessage(balance));

        // Create and send a new account with some orders
        var account = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        account.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        account.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        account.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));
        sender.send(new AccountMessage(account));

        var receiver = new MyReceiver();

        // Receive data from the sender
        index1 %= sender.getBuffer().getSize();
        index2 %= sender.getBuffer().getSize();
        index2 = Math.max(index1, index2);
        receiver.receive(sender.getBuffer().getData(), 0, index1);
        receiver.receive(sender.getBuffer().getData(), index1, index2 - index1);
        receiver.receive(sender.getBuffer().getData(), index2, sender.getBuffer().getSize() - index2);
        return receiver.check();
    }

    @Test()
    public void sendAndReceive()
    {
        for (long i = 0; i < 1000; ++i)
            for (long j = 0; j < 1000; ++j)
                Assert.assertTrue(sendAndReceive(i, j));
    }
}
