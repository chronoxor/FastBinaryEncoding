using System;
using Xunit;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace Tests
{
    public class MySender : Sender, ISenderListener
    {
        public long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }
    }

    public class MyReceiver : Receiver, IReceiverListener
    {
        private bool _order;
        private bool _balance;
        private bool _account;

        public bool Check() { return _order && _balance && _account; }

        public void OnReceive(OrderMessage value) { _order = true; }
        public void OnReceive(BalanceMessage value) { _balance = true; }
        public void OnReceive(AccountMessage value) { _account = true; }
    }

    public class TestSendReceive
    {
        private static bool SendAndReceive(long index1, long index2)
        {
            var sender = new MySender();

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
