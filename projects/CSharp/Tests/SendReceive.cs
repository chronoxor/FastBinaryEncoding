using System;
using Xunit;

namespace Tests
{
    public class MySender : FBE.proto.Sender
    {
        protected override long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }
    }

    public class MyReceiver : FBE.proto.Receiver, FBE.proto.IReceiverListener
    {
        private bool _order;
        private bool _balance;
        private bool _account;

        public bool Check() { return _order && _balance && _account; }

        public void OnReceive(proto.OrderMessage value) { _order = true; }
        public void OnReceive(proto.BalanceMessage value) { _balance = true; }
        public void OnReceive(proto.AccountMessage value) { _account = true; }
    }

    public class SendReceive
    {
        private static bool SendAndReceive(long index1, long index2)
        {
            var sender = new MySender();

            // Create and send a new order
            var order = new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0);
            sender.Send(new proto.OrderMessage(order));

            // Create and send a new balance wallet
            var balance = new proto.Balance("USD", 1000.0);
            sender.Send(new proto.BalanceMessage(balance));

            // Create and send a new account with some orders
            var account = proto.Account.Default;
            account.id = 1;
            account.name = "Test";
            account.state = proto.State.good;
            account.wallet.currency = "USD";
            account.wallet.amount = 1000.0;
            account.asset = new proto.Balance("EUR", 100.0);
            account.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            account.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            account.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));
            sender.Send(new proto.AccountMessage(account));

            var receiver = new MyReceiver();

            // Receive data from the sender
            index1 %= sender.Buffer.Size;
            index2 %= sender.Buffer.Size;
            index2 = Math.Max(index1, index2);
            receiver.Receive(sender.Buffer.Data, 0, index1);
            receiver.Receive(sender.Buffer.Data, index1, index2 - index1);
            receiver.Receive(sender.Buffer.Data, index2, sender.Buffer.Size - index2);
            return receiver.Check();
        }

        [Fact(DisplayName = "Send & Receive")]
        public void SendAndReceiveTest()
        {
            for (long i = 0; i < 1000; ++i)
                for (long j = 0; j < 1000; ++j)
                    Assert.True(SendAndReceive(i, j));
        }
    }
}
