using System;
using System.Diagnostics;

namespace Serialization
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

            // Serialize the account to the FBE stream
            var writer = new FBE.proto.AccountModel();
            writer.Serialize(account);
            Debug.Assert(writer.Verify());

            // Show the serialized FBE size
            Console.WriteLine($"FBE size: {writer.Buffer.Size}");

            // Deserialize the account from the FBE stream
            var reader = new FBE.proto.AccountModel();
            reader.Attach(writer.Buffer);
            Debug.Assert(reader.Verify());
            reader.Deserialize(out account);

            // Show account content
            Console.WriteLine();
            Console.WriteLine(account);
        }
    }
}
