using System;
using Xunit;

using com.chronoxor.protoex;
using com.chronoxor.protoex.FBE;

namespace Tests
{
    public class MyFinalSender : FinalSender, ISenderListener
    {
        public long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }
    }

    public class MyFinalReceiver : FinalReceiver, IFinalReceiverListener
    {
        private bool _order;
        private bool _balance;
        private bool _account;

        public bool Check() { return _order && _balance && _account; }

        public void OnReceive(OrderMessage value) { _order = true; }
        public void OnReceive(BalanceMessage value) { _balance = true; }
        public void OnReceive(AccountMessage value) { _account = true; }
    }

    public class TestSendReceiveFinal
    {
        private static bool SendAndReceiveFinal(long index1, long index2)
        {
            var sender = new MyFinalSender();

            // Create and send a new order
            var order = new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0, 0.0, 0.0);
            sender.Send(new OrderMessage(order));

            // Create and send a new balance wallet
            var balance = new Balance(new com.chronoxor.proto.Balance("USD", 1000.0), 100.0);
            sender.Send(new BalanceMessage(balance));

            // Create and send a new account with some orders
            var account = Account.Default;
            account.id = 1;
            account.name = "Test";
            account.state = StateEx.good;
            account.wallet.parent.currency = "USD";
            account.wallet.parent.amount = 1000.0;
            account.asset = new Balance(new com.chronoxor.proto.Balance("EUR", 100.0), 100.0);
            account.orders.Add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
            account.orders.Add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0, 0.0, 0.0));
            account.orders.Add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0, 0.0, 0.0));
            sender.Send(new AccountMessage(account));

            var receiver = new MyFinalReceiver();

            // Receive data from the sender
            index1 %= sender.Buffer.Size;
            index2 %= sender.Buffer.Size;
            index2 = Math.Max(index1, index2);
            receiver.Receive(sender.Buffer.Data, 0, index1);
            receiver.Receive(sender.Buffer.Data, index1, index2 - index1);
            receiver.Receive(sender.Buffer.Data, index2, sender.Buffer.Size - index2);
            return receiver.Check();
        }

        [Fact(DisplayName = "Send & Receive (Final)")]
        public void SendAndReceiveFinalTest()
        {
            for (long i = 0; i < 1000; ++i)
                for (long j = 0; j < 1000; ++j)
                    Assert.True(SendAndReceiveFinal(i, j));
        }
    }
}
