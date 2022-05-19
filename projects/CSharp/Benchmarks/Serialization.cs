using System.Diagnostics;
using BenchmarkDotNet.Attributes;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace Benchmarks
{
    public class Serialization
    {
        private Account _account;
        private readonly AccountModel _writer;
        private readonly AccountModel _reader;

        public Serialization()
        {
            // Create a new account with some orders
            _account = Account.Default;
            _account.id = 1;
            _account.name = "Test";
            _account.state = State.good;
            _account.wallet.currency = "USD";
            _account.wallet.amount = 1000.0;
            _account.asset = new Balance("EUR", 100.0);
            _account.orders.Add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
            _account.orders.Add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
            _account.orders.Add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

            // Serialize the account to the FBE stream
            _writer = new AccountModel();
            _writer.Serialize(_account);
            Debug.Assert(_writer.Verify());

            // Deserialize the account from the FBE stream
            _reader = new AccountModel();
            _reader.Attach(_writer.Buffer);
            Debug.Assert(_reader.Verify());
            _reader.Deserialize(out _account);
        }

        [Benchmark]
        public void Verify()
        {
            // Verify the account
            _writer.Verify();
        }

        [Benchmark]
        public void Serialize()
        {
            // Reset FBE stream
            _writer.Reset();

            // Serialize the account to the FBE stream
            _writer.Serialize(_account);
        }

        [Benchmark]
        public void Deserialize()
        {
            // Deserialize the account from the FBE stream
            _reader.Deserialize(out _account);
        }
    }
}
