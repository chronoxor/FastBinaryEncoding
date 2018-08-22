package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

class MySender extends proto.fbe.Sender
{
    @Override
    protected long onSend(byte[] buffer, long offset, long size)
    {
        // Send nothing...
        return 0;
    }
}

class MyReceiver extends proto.fbe.Receiver
{
    private boolean _order;
    private boolean _balance;
    private boolean _account;

    public boolean check() { return _order && _balance && _account; }

    @Override
    protected void onReceive(proto.Order value) { _order = true; }
    @Override
    protected void onReceive(proto.Balance value) { _balance = true; }
    @Override
    protected void onReceive(proto.Account value) { _account = true; }
}

public class TestSendReceive
{
    public static boolean SendAndReceive(long index)
    {
        var sender = new MySender();

        // Create and send a new order
        var order = new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0);
        sender.send(order);

        // Create and send a new balance wallet
        var balance = new proto.Balance("USD", 1000.0);
        sender.send(balance);

        // Create and send a new account with some orders
        var account = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        account.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        account.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        account.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));
        sender.send(account);

        var receiver = new MyReceiver();

        // Receive data from the sender
        index %= sender.getBuffer().getSize();
        receiver.receive(sender.getBuffer().getData(), 0, index);
        receiver.receive(sender.getBuffer().getData(), index, sender.getBuffer().getSize() - index);
        return receiver.check();
    }

    @Test()
    public void SendAndReceive()
    {
        for (long i = 0; i < 1000; ++i)
            Assert.assertTrue(SendAndReceive(i));
    }
}
