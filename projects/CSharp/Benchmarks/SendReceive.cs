using BenchmarkDotNet.Attributes;

namespace Benchmarks
{
    public class MySender1 : FBE.proto.Sender, FBE.proto.ISenderListener
    {
        private long Size { get; set; }
        private long LogSize { get; set; }

        public long OnSend(byte[] buffer, long offset, long size) { Size += size; return size; }
        public void OnSendLog(string message) { LogSize += message.Length; }
    }

    public class MySender2 : FBE.proto.Sender, FBE.proto.ISenderListener
    {
        private long Size { get; set; }
        private long LogSize { get; set; }

        public long OnSend(byte[] buffer, long offset, long size) { Size += size; return 0; }
        public void OnSendLog(string message) { LogSize += message.Length; }
    }

    public class MyReceiver : FBE.proto.Receiver, FBE.proto.IReceiverListener
    {
        private long LogSize { get; set; }

        public void OnReceive(proto.OrderMessage value) {}
        public void OnReceive(proto.BalanceMessage value) {}
        public void OnReceive(proto.AccountMessage value) {}

        public void OnReceiveLog(string message) { LogSize += message.Length; }
    }

    public class SendReceive
    {
        private readonly proto.AccountMessage _account;
        private readonly MySender1 _sender1;
        private readonly MySender2 _sender2;
        private readonly MyReceiver _receiver;

        public SendReceive()
        {
            // Create a new account with some orders
            _account = new proto.AccountMessage(proto.Account.Default);
            _account.body.id = 1;
            _account.body.name = "Test";
            _account.body.state = proto.State.good;
            _account.body.wallet.currency = "USD";
            _account.body.wallet.amount = 1000.0;
            _account.body.asset = new proto.Balance("EUR", 100.0);
            _account.body.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            _account.body.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            _account.body.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

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
