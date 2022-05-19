using System;
using System.Diagnostics;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace Serialization
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

            // Serialize the account to the FBE stream
            var writer = new AccountModel();
            writer.Serialize(account);
            Debug.Assert(writer.Verify());

            // Show the serialized FBE size
            Console.WriteLine($"FBE size: {writer.Buffer.Size}");

            // Deserialize the account from the FBE stream
            var reader = new AccountModel();
            reader.Attach(writer.Buffer);
            Debug.Assert(reader.Verify());
            reader.Deserialize(out account);

            // Show account content
            Console.WriteLine();
            Console.WriteLine(account);
        }
    }
}
