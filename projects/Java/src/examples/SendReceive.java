package examples;

import java.util.*;

class MySender extends proto.fbe.Sender
{
    @Override
    protected long onSend(byte[] buffer, long offset, long size)
    {
        // Send nothing...
        return 0;
    }

    @Override
    protected void onSendLog(String message)
    {
        System.out.println("onSend: " + message);
    }
}

class MyReceiver extends proto.fbe.Receiver
{
    @Override
    protected void onReceive(proto.Order value) {}
    @Override
    protected void onReceive(proto.Balance value) {}
    @Override
    protected void onReceive(proto.Account value) {}

    @Override
    protected void onReceiveLog(String message)
    {
        System.out.println("onReceive: " + message);
    }
}

public class SendReceive
{
    public static void main(String[] args)
    {
        var sender = new MySender();

        // Enable logging
        sender.setLogging(true);

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

        // Enable logging
        receiver.setLogging(true);

        // Receive all data from the sender
        receiver.receive(sender.getBuffer());
    }
}
