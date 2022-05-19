// ReSharper disable CompareOfFloatsByEqualityOperator

using Xunit;

namespace Tests
{
    public class TestExtending
    {
        [Fact(DisplayName = "Extending: old -> new")]
        public void ExtendingOldNew()
        {
            // Create a new account with some orders
            var account1 = com.chronoxor.proto.Account.Default;
            account1.id = 1;
            account1.name = "Test";
            account1.state = com.chronoxor.proto.State.good;
            account1.wallet.currency = "USD";
            account1.wallet.amount = 1000.0;
            account1.asset = new com.chronoxor.proto.Balance("EUR", 100.0);
            account1.orders.Add(new com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0));
            account1.orders.Add(new com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0));
            account1.orders.Add(new com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0));

            // Serialize the account to the FBE stream
            var writer = new com.chronoxor.proto.FBE.AccountModel();
            Assert.True(writer.model.FBEOffset == 4);
            long serialized = writer.Serialize(account1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 252);

            // Deserialize the account from the FBE stream
            var reader = new com.chronoxor.protoex.FBE.AccountModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var account2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);
            Assert.True(reader.model.FBEOffset == (4 + reader.Buffer.Size));

            Assert.True(account2.id == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state == com.chronoxor.protoex.StateEx.good);
            Assert.True(account2.wallet.parent.currency == "USD");
            Assert.True(account2.wallet.parent.amount == 1000.0);
            Assert.True(account2.wallet.locked == 0.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.parent.currency == "EUR");
            Assert.True(account2.asset.Value.parent.amount == 100.0);
            Assert.True(account2.asset.Value.locked == 0.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].id == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == com.chronoxor.protoex.OrderSide.buy);
            Assert.True(account2.orders[0].type == com.chronoxor.protoex.OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[0].tp == 10.0);
            Assert.True(account2.orders[0].sl == -10.0);
            Assert.True(account2.orders[1].id == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == com.chronoxor.protoex.OrderSide.sell);
            Assert.True(account2.orders[1].type == com.chronoxor.protoex.OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[1].tp == 10.0);
            Assert.True(account2.orders[1].sl == -10.0);
            Assert.True(account2.orders[2].id == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side == com.chronoxor.protoex.OrderSide.buy);
            Assert.True(account2.orders[2].type == com.chronoxor.protoex.OrderType.stop);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
            Assert.True(account2.orders[2].tp == 10.0);
            Assert.True(account2.orders[2].sl == -10.0);
        }

        [Fact(DisplayName = "Extending: new -> old")]
        public void ExtendingNewOld()
        {
            // Create a new account with some orders
            com.chronoxor.protoex.Account account1 = com.chronoxor.protoex.Account.Default;
            account1.id = 1;
            account1.name = "Test";
            account1.state = com.chronoxor.protoex.StateEx.good | com.chronoxor.protoex.StateEx.happy;
            account1.wallet.parent.currency = "USD";
            account1.wallet.parent.amount = 1000.0;
            account1.wallet.locked = 123.456;
            account1.asset = new com.chronoxor.protoex.Balance(new com.chronoxor.proto.Balance("EUR", 100.0), 12.34);
            account1.orders.Add(new com.chronoxor.protoex.Order(1, "EURUSD", com.chronoxor.protoex.OrderSide.buy, com.chronoxor.protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
            account1.orders.Add(new com.chronoxor.protoex.Order(2, "EURUSD", com.chronoxor.protoex.OrderSide.sell, com.chronoxor.protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1));
            account1.orders.Add(new com.chronoxor.protoex.Order(3, "EURUSD", com.chronoxor.protoex.OrderSide.tell, com.chronoxor.protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1));

            // Serialize the account to the FBE stream
            var writer = new com.chronoxor.protoex.FBE.AccountModel();
            Assert.True(writer.model.FBEOffset == 4);
            long serialized = writer.Serialize(account1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 316);

            // Deserialize the account from the FBE stream
            var reader = new com.chronoxor.proto.FBE.AccountModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var account2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);
            Assert.True(reader.model.FBEOffset == (4 + reader.Buffer.Size));

            Assert.True(account2.id == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state.HasFlags(com.chronoxor.proto.State.good));
            Assert.True(account2.wallet.currency == "USD");
            Assert.True(account2.wallet.amount == 1000.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.currency == "EUR");
            Assert.True(account2.asset.Value.amount == 100.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].id == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == com.chronoxor.proto.OrderSide.buy);
            Assert.True(account2.orders[0].type == com.chronoxor.proto.OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[1].id == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == com.chronoxor.proto.OrderSide.sell);
            Assert.True(account2.orders[1].type == com.chronoxor.proto.OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[2].id == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side != com.chronoxor.proto.OrderSide.buy);
            Assert.True(account2.orders[2].type != com.chronoxor.proto.OrderType.market);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
        }
    }
}
