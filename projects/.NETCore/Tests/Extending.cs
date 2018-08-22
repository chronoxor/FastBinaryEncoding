// ReSharper disable CompareOfFloatsByEqualityOperator

using Xunit;

namespace Tests
{
    public class Extending
    {
        [Fact(DisplayName = "Extending: old -> new")]
        public void ExtendingOldNew()
        {
            // Create a new account with some orders
            var account1 = proto.Account.Default;
            account1.uid = 1;
            account1.name = "Test";
            account1.state = proto.State.good;
            account1.wallet.currency = "USD";
            account1.wallet.amount = 1000.0;
            account1.asset = new proto.Balance("EUR", 100.0);
            account1.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            account1.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            account1.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

            // Serialize the account to the FBE stream
            var writer = new FBE.proto.AccountModel();
            Assert.True(writer.model.FBEOffset == 4);
            long serialized = writer.Serialize(account1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 252);

            // Deserialize the account from the FBE stream
            var reader = new FBE.protoex.AccountModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var account2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);
            Assert.True(reader.model.FBEOffset == (4 + reader.Buffer.Size));

            Assert.True(account2.uid == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state == protoex.StateEx.good);
            Assert.True(account2.wallet.parent.currency == "USD");
            Assert.True(account2.wallet.parent.amount == 1000.0);
            Assert.True(account2.wallet.locked == 0.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.parent.currency == "EUR");
            Assert.True(account2.asset.Value.parent.amount == 100.0);
            Assert.True(account2.asset.Value.locked == 0.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].uid == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == protoex.OrderSide.buy);
            Assert.True(account2.orders[0].type == protoex.OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[0].tp == 10.0);
            Assert.True(account2.orders[0].sl == -10.0);
            Assert.True(account2.orders[1].uid == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == protoex.OrderSide.sell);
            Assert.True(account2.orders[1].type == protoex.OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[1].tp == 10.0);
            Assert.True(account2.orders[1].sl == -10.0);
            Assert.True(account2.orders[2].uid == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side == protoex.OrderSide.buy);
            Assert.True(account2.orders[2].type == protoex.OrderType.stop);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
            Assert.True(account2.orders[2].tp == 10.0);
            Assert.True(account2.orders[2].sl == -10.0);
        }

        [Fact(DisplayName = "Extending: new -> old")]
        public void ExtendingNewOld()
        {
            // Create a new account with some orders
            protoex.Account account1 = protoex.Account.Default;
            account1.uid = 1;
            account1.name = "Test";
            account1.state = protoex.StateEx.good | protoex.StateEx.happy;
            account1.wallet.parent.currency = "USD";
            account1.wallet.parent.amount = 1000.0;
            account1.wallet.locked = 123.456;
            account1.asset = new protoex.Balance(new proto.Balance("EUR", 100.0), 12.34);
            account1.orders.Add(new protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0));
            account1.orders.Add(new protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1));
            account1.orders.Add(new protoex.Order(3, "EURUSD", protoex.OrderSide.tell, protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1));

            // Serialize the account to the FBE stream
            var writer = new FBE.protoex.AccountModel();
            Assert.True(writer.model.FBEOffset == 4);
            long serialized = writer.Serialize(account1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 316);

            // Deserialize the account from the FBE stream
            var reader = new FBE.proto.AccountModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var account2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);
            Assert.True(reader.model.FBEOffset == (4 + reader.Buffer.Size));

            Assert.True(account2.uid == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state.HasFlags(proto.State.good));
            Assert.True(account2.wallet.currency == "USD");
            Assert.True(account2.wallet.amount == 1000.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.currency == "EUR");
            Assert.True(account2.asset.Value.amount == 100.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].uid == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == proto.OrderSide.buy);
            Assert.True(account2.orders[0].type == proto.OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[1].uid == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == proto.OrderSide.sell);
            Assert.True(account2.orders[1].type == proto.OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[2].uid == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side != proto.OrderSide.buy);
            Assert.True(account2.orders[2].type != proto.OrderType.market);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
        }
    }
}
