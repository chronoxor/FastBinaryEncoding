using System;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace SendReceive
{
    public class MySender : Sender, ISenderListener
    {
        public long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }

        public void OnSendLog(string message)
        {
            Console.WriteLine($"OnSend: {message}");
        }
    }

    public class MyReceiver : Receiver, IReceiverListener
    {
        public void OnReceive(OrderMessage value) {}
        public void OnReceive(BalanceMessage value) {}
        public void OnReceive(AccountMessage value) {}

        public void OnReceiveLog(string message)
        {
            Console.WriteLine($"OnReceive: {message}");
        }
    }

    public static class Program
    {
        public static void Main()
        {
            var sender = new MySender { Logging = true };

            // Enable logging

            // Create and send a new order
            var order = new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0);
            sender.Send(new OrderMessage(order));

            // Create and send a new balance wallet
            var balance = new Balance("USD", 1000.0);
            sender.Send(new BalanceMessage(balance));

            // Create and send a new account with some orders
            var account = Account.Default;
            account.id = 1;
            account.name = "Test";
            account.state = State.good;
            account.wallet.currency = "USD";
            account.wallet.amount = 1000.0;
            account.asset = new Balance("EUR", 100.0);
            account.orders.Add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
            account.orders.Add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
            account.orders.Add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));
            sender.Send(new AccountMessage(account));

            var receiver = new MyReceiver { Logging = true };

            // Enable logging

            // Receive all data from the sender
            receiver.Receive(sender.Buffer);
        }
    }
}
