using System;

namespace SerializationJson
{
    public static class Program
    {
        public static void Main()
        {
            // Create a new account with some orders
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

            // Serialize the account to the JSON string
            var json = account.ToJson();

            // Show the serialized JSON and its size
            Console.WriteLine($"JSON: {json}");
            Console.WriteLine($"JSON size: {json.Length}");

            // Deserialize the account from the JSON string
            account = proto.Account.FromJson(json);

            // Show account content
            Console.WriteLine();
            Console.WriteLine(account);
        }
    }
}
