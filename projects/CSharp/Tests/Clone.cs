// ReSharper disable CompareOfFloatsByEqualityOperator
// ReSharper disable RedundantAssignment

using NUnit.Framework;

namespace Tests
{
    [TestFixture]
    public class Clone
    {
        [TestCase(TestName = "Clone structs")]
        public void CopyStructs()
        {
            // Create a new account with some orders
            var account1 = proto.Account.Default;
            account1.id = 1;
            account1.name = "Test";
            account1.state = proto.State.good;
            account1.wallet.currency = "USD";
            account1.wallet.amount = 1000.0;
            account1.asset = new proto.Balance("EUR", 100.0);
            account1.orders.Add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
            account1.orders.Add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
            account1.orders.Add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

            // Clone the account
            proto.Account account2 = account1.Clone();

            // Clear the source account
            account1 = proto.Account.Default;

            Assert.That(account2.id == 1);
            Assert.That(account2.name == "Test");
            Assert.That(account2.state.HasFlags(proto.State.good));
            Assert.That(account2.wallet.currency == "USD");
            Assert.That(account2.wallet.amount == 1000.0);
            Assert.That(account2.asset.HasValue);
            Assert.That(account2.asset.Value.currency == "EUR");
            Assert.That(account2.asset.Value.amount == 100.0);
            Assert.That(account2.orders.Count == 3);
            Assert.That(account2.orders[0].id == 1);
            Assert.That(account2.orders[0].symbol == "EURUSD");
            Assert.That(account2.orders[0].side == proto.OrderSide.buy);
            Assert.That(account2.orders[0].type == proto.OrderType.market);
            Assert.That(account2.orders[0].price == 1.23456);
            Assert.That(account2.orders[0].volume == 1000.0);
            Assert.That(account2.orders[1].id == 2);
            Assert.That(account2.orders[1].symbol == "EURUSD");
            Assert.That(account2.orders[1].side == proto.OrderSide.sell);
            Assert.That(account2.orders[1].type == proto.OrderType.limit);
            Assert.That(account2.orders[1].price == 1.0);
            Assert.That(account2.orders[1].volume == 100.0);
            Assert.That(account2.orders[2].id == 3);
            Assert.That(account2.orders[2].symbol == "EURUSD");
            Assert.That(account2.orders[2].side == proto.OrderSide.buy);
            Assert.That(account2.orders[2].type == proto.OrderType.stop);
            Assert.That(account2.orders[2].price == 1.5);
            Assert.That(account2.orders[2].volume == 10.0);
        }
    }
}
