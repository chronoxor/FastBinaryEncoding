package tests;

import java.util.*;
import org.testng.*;
import org.testng.annotations.*;

class MyFinalSender extends protoex.fbe.FinalSender
{
    @Override
    protected long onSend(byte[] buffer, long offset, long size)
    {
        // Send nothing...
        return 0;
    }
}

class MyFinalReceiver extends protoex.fbe.FinalReceiver
{
    private boolean _order;
    private boolean _balance;
    private boolean _account;

    public boolean check() { return _order && _balance && _account; }

    @Override
    protected void onReceive(protoex.Order value) { _order = true; }
    @Override
    protected void onReceive(protoex.Balance value) { _balance = true; }
    @Override
    protected void onReceive(protoex.Account value) { _account = true; }
}

public class TestSendReceiveFinal
{
    public static boolean sendAndReceiveFinal(long index)
    {
        var sender = new MyFinalSender();

        // Create and send a new order
        var order = new protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0);
        sender.send(order);

        // Create and send a new balance wallet
        var balance = new protoex.Balance(new proto.Balance("USD", 1000.0), 100.0);
        sender.send(balance);

        // Create and send a new account with some orders
        var account = new protoex.Account(1, "Test", protoex.StateEx.good, new protoex.Balance(new proto.Balance("USD", 1000.0), 100.0), new protoex.Balance(new proto.Balance("EUR", 100.0), 10.0), new ArrayList<protoex.Order>());
        account.orders.add(new protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
        account.orders.add(new protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.0, 0.0));
        account.orders.add(new protoex.Order(3, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.stop, 1.5, 10.0, 0.0, 0.0));
        sender.send(account);

        var receiver = new MyFinalReceiver();

        // Receive data from the sender
        index %= sender.getBuffer().getSize();
        receiver.receive(sender.getBuffer().getData(), 0, index);
        receiver.receive(sender.getBuffer().getData(), index, sender.getBuffer().getSize() - index);
        return receiver.check();
    }

    @Test()
    public void sendAndReceiveFinal()
    {
        for (long i = 0; i < 1000; ++i)
            Assert.assertTrue(sendAndReceiveFinal(i));
    }
}
