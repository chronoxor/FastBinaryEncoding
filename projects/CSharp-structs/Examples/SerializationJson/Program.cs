using System;

using com.chronoxor.proto;

namespace SerializationJson
{
    public static class Program
    {
        public static void Main()
        {
            // Create a new account with some orders
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

            // Serialize the account to the JSON string
            var json = account.ToJson();

            // Show the serialized JSON and its size
            Console.WriteLine($"JSON: {json}");
            Console.WriteLine($"JSON size: {json.Length}");

            // Deserialize the account from the JSON string
            account = Account.FromJson(json);

            // Show account content
            Console.WriteLine();
            Console.WriteLine(account);
        }
    }
}
