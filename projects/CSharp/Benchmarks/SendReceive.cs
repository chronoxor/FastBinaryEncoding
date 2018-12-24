using BenchmarkDotNet.Attributes;

namespace Benchmarks
{
    public class MySender1 : FBE.proto.Sender
    {
        private long Size { get; set; }
        private long LogSize { get; set; }

        protected override long OnSend(byte[] buffer, long offset, long size) { Size += size; return size; }
        protected override void OnSendLog(string message) { LogSize += message.Length; }
    }

    public class MySender2 : FBE.proto.Sender
    {
        private long Size { get; set; }
        private long LogSize { get; set; }

        protected override long OnSend(byte[] buffer, long offset, long size) { Size += size; return 0; }
        protected override void OnSendLog(string message) { LogSize += message.Length; }
    }

    public class MyReceiver : FBE.proto.Receiver
    {
        private long LogSize { get; set; }

        protected override void OnReceive(proto.Order value) {}
        protected override void OnReceive(proto.Balance value) {}
        protected override void OnReceive(proto.Account value) {}

        protected override void OnReceiveLog(string message) { LogSize += message.Length; }
    }

    public class SendReceive
    {
        private readonly proto.Account _account;
        private readonly MySender1 _sender1;
        private readonly MySender2 _sender2;
        private readonly MyReceiver _receiver;

        public SendReceive()
        {
            // Create a new account with some orders
            _account = proto.Account.Default;
            _account.id = 1;
            _account.name = "Test";
            _account.state = proto.State.good;
            _account.wallet.currency = "USD";
            _account.wallet.amount = 1000.0;
            _account.asset = new proto.Balance("EUR", 100.0);
            _account.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            _account.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            _account.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

            _sender1 = new MySender1();
            _sender1.Send(_account);

            _sender2 = new MySender2();
            _sender2.Send(_account);

            _receiver = new MyReceiver();
            _receiver.Receive(_sender2.Buffer);
        }

        [Benchmark]
        public void Send()
        {
            // Serialize and send the account
            _sender1.Send(_account);
        }
        /*
        [Benchmark]
        public void SendWithLogs()
        {
            // Enable logging
            _sender1.Logging = true;

            // Serialize and send the account
            _sender1.Send(_account);
        }
        */
        [Benchmark]
        public void Receive()
        {
            // Receive the account from the sender
            _receiver.Receive(_sender2.Buffer);
        }
        /*
        [Benchmark]
        public void ReceiveWithLogs()
        {
            // Enable logging
            _receiver.Logging = true;

            // Receive the account from the sender
            _receiver.Receive(_sender2.Buffer);
        }
        */
    }
}
