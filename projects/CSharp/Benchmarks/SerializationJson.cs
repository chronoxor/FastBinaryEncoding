using BenchmarkDotNet.Attributes;

using com.chronoxor.proto;

namespace Benchmarks
{
    public class SerializationJson
    {
        private Account _account;
        private string _json;

        public SerializationJson()
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

            // Serialize the account to the JSON string
            _json = _account.ToJson();

            // Deserialize the account from the JSON string
            _account = Account.FromJson(_json);
        }

        [Benchmark]
        public void Serialize()
        {
            // Serialize the account to the JSON string
            _json = _account.ToJson();
        }

        [Benchmark]
        public void Deserialize()
        {
            // Deserialize the account from the JSON string
            _account = Account.FromJson(_json);
        }
    }
}
