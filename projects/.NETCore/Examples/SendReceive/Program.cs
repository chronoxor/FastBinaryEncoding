using System;

namespace SendReceive
{
    public class MySender : FBE.proto.Sender
    {
        protected override long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }

        protected override void OnSendLog(string message)
        {
            Console.WriteLine($"OnSend: {message}");
        }
    }

    public class MyReceiver : FBE.proto.Receiver
    {
        protected override void OnReceive(proto.Order value) {}
        protected override void OnReceive(proto.Balance value) {}
        protected override void OnReceive(proto.Account value) {}

        protected override void OnReceiveLog(string message)
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
            var order = new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0);
            sender.Send(order);

            // Create and send a new balance wallet
            var balance = new proto.Balance("USD", 1000.0);
            sender.Send(balance);

            // Create and send a new account with some orders
            var account = proto.Account.Default;
            account.uid = 1;
            account.name = "Test";
            account.state = proto.State.good;
            account.wallet.currency = "USD";
            account.wallet.amount = 1000.0;
            account.asset = new proto.Balance("EUR", 100.0);
            account.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            account.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            account.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));
            sender.Send(account);

            var receiver = new MyReceiver { Logging = true };

            // Enable logging

            // Receive all data from the sender
            receiver.Receive(sender.Buffer);
        }
    }
}
