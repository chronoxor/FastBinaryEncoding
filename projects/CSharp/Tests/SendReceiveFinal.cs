using NUnit.Framework;

namespace Tests
{
    public class MyFinalSender : FBE.proto.FinalSender
    {
        protected override long OnSend(byte[] buffer, long offset, long size)
        {
            // Send nothing...
            return 0;
        }
    }

    public class MyFinalReceiver : FBE.proto.FinalReceiver
    {
        private bool _order;
        private bool _balance;
        private bool _account;

        public bool Check() { return _order && _balance && _account; }

        protected override void OnReceive(proto.Order value) { _order = true; }
        protected override void OnReceive(proto.Balance value) { _balance = true; }
        protected override void OnReceive(proto.Account value) { _account = true; }
    }

    [TestFixture]
    public class SendReceiveFinal
    {
        private static bool SendAndReceiveFinal(long index)
        {
            var sender = new MyFinalSender();

            // Create and send a new order
            var order = new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0);
            sender.Send(order);

            // Create and send a new balance wallet
            var balance = new proto.Balance("USD", 1000.0);
            sender.Send(balance);

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
            sender.Send(account);

            var receiver = new MyFinalReceiver();

            // Receive data from the sender
            index %= sender.Buffer.Size;
            receiver.Receive(sender.Buffer.Data, 0, index);
            receiver.Receive(sender.Buffer.Data, index, sender.Buffer.Size - index);
            return receiver.Check();
        }

        [TestCase(TestName = "Send & Receive (Final)")]
        public void SendAndReceiveFinalTest()
        {
            for (long i = 0; i < 1000; ++i)
                Assert.That(SendAndReceiveFinal(i));
        }
    }
}
