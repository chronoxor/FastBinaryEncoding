// ReSharper disable CompareOfFloatsByEqualityOperator
// ReSharper disable RedundantAssignment

using Xunit;

using com.chronoxor.proto;

namespace Tests
{
    public class TestClone
    {
        [Fact(DisplayName = "Clone structs")]
        public void CopyStructs()
        {
            // Create a new account with some orders
            var account1 = Account.Default;
            account1.id = 1;
            account1.name = "Test";
            account1.state = State.good;
            account1.wallet.currency = "USD";
            account1.wallet.amount = 1000.0;
            account1.asset = new Balance("EUR", 100.0);
            account1.orders.Add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
            account1.orders.Add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
            account1.orders.Add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

            // Clone the account
            Account account2 = account1.Clone();

            // Clear the source account
            account1 = Account.Default;

            Assert.True(account2.id == 1);
            Assert.True(account2.name == "Test");
            Assert.True(account2.state.HasFlags(State.good));
            Assert.True(account2.wallet.currency == "USD");
            Assert.True(account2.wallet.amount == 1000.0);
            Assert.True(account2.asset.HasValue);
            Assert.True(account2.asset.Value.currency == "EUR");
            Assert.True(account2.asset.Value.amount == 100.0);
            Assert.True(account2.orders.Count == 3);
            Assert.True(account2.orders[0].id == 1);
            Assert.True(account2.orders[0].symbol == "EURUSD");
            Assert.True(account2.orders[0].side == OrderSide.buy);
            Assert.True(account2.orders[0].type == OrderType.market);
            Assert.True(account2.orders[0].price == 1.23456);
            Assert.True(account2.orders[0].volume == 1000.0);
            Assert.True(account2.orders[1].id == 2);
            Assert.True(account2.orders[1].symbol == "EURUSD");
            Assert.True(account2.orders[1].side == OrderSide.sell);
            Assert.True(account2.orders[1].type == OrderType.limit);
            Assert.True(account2.orders[1].price == 1.0);
            Assert.True(account2.orders[1].volume == 100.0);
            Assert.True(account2.orders[2].id == 3);
            Assert.True(account2.orders[2].symbol == "EURUSD");
            Assert.True(account2.orders[2].side == OrderSide.buy);
            Assert.True(account2.orders[2].type == OrderType.stop);
            Assert.True(account2.orders[2].price == 1.5);
            Assert.True(account2.orders[2].volume == 10.0);
        }
    }
}
