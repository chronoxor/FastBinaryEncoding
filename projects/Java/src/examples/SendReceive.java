package examples;

import java.util.*;

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

    @Override
    protected void onSendLog(String message)
    {
        System.out.println("onSend: " + message);
    }
}

class MyReceiver extends Receiver
{
    @Override
    protected void onReceive(OrderMessage value) {}
    @Override
    protected void onReceive(BalanceMessage value) {}
    @Override
    protected void onReceive(AccountMessage value) {}

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

        // Enable logging
        receiver.setLogging(true);

        // Receive all data from the sender
        receiver.receive(sender.getBuffer());
    }
}
