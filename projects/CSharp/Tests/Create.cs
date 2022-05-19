// ReSharper disable CompareOfFloatsByEqualityOperator

using Xunit;

using com.chronoxor.proto;
using com.chronoxor.proto.FBE;

namespace Tests
{
    public class TestCreate
    {
        [Fact(DisplayName = "Create & access")]
        public void CreateAndAccess()
        {
            // Create a new account using FBE model into the FBE stream
            var writer = new AccountModel();
            Assert.True(writer.model.FBEOffset == 4);
            long modelBegin = writer.CreateBegin();
            long accountBegin = writer.model.SetBegin();
            writer.model.id.Set(1);
            writer.model.name.Set("Test");
            writer.model.state.Set(State.good);
            long walletBegin = writer.model.wallet.SetBegin();
            writer.model.wallet.currency.Set("USD");
            writer.model.wallet.amount.Set(1000.0);
            writer.model.wallet.SetEnd(walletBegin);
            long assetBegin = writer.model.asset.SetBegin(true);
            long assetWalletBegin = writer.model.asset.Value.SetBegin();
            writer.model.asset.Value.currency.Set("EUR");
            writer.model.asset.Value.amount.Set(100.0);
            writer.model.asset.SetEnd(assetBegin);
            writer.model.asset.Value.SetEnd(assetWalletBegin);
            var order = writer.model.orders.Resize(3);
            long orderBegin = order.SetBegin();
            order.id.Set(1);
            order.symbol.Set("EURUSD");
            order.side.Set(OrderSide.buy);
            order.type.Set(OrderType.market);
            order.price.Set(1.23456);
            order.volume.Set(1000.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            orderBegin = order.SetBegin();
            order.id.Set(2);
            order.symbol.Set("EURUSD");
            order.side.Set(OrderSide.sell);
            order.type.Set(OrderType.limit);
            order.price.Set(1.0);
            order.volume.Set(100.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            orderBegin = order.SetBegin();
            order.id.Set(3);
            order.symbol.Set("EURUSD");
            order.side.Set(OrderSide.buy);
            order.type.Set(OrderType.stop);
            order.price.Set(1.5);
            order.volume.Set(10.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            writer.model.SetEnd(accountBegin);
            long serialized = writer.CreateEnd(modelBegin);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 252);

            // Access the account model in the FBE stream
            var reader = new AccountModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());

            accountBegin = reader.model.GetBegin();
            reader.model.id.Get(out var id);
            Assert.True(id == 1);
            reader.model.name.Get(out var name);
            Assert.True(name == "Test");
            reader.model.state.Get(out var state);
            Assert.True(state.HasFlags(State.good));

            walletBegin = reader.model.wallet.GetBegin();
            reader.model.wallet.currency.Get(out var walletCurrency);
            Assert.True(walletCurrency == "USD");
            reader.model.wallet.amount.Get(out var walletAmount);
            Assert.True(walletAmount == 1000.0);
            reader.model.wallet.GetEnd(walletBegin);

            Assert.True(reader.model.asset.HasValue);
            assetBegin = reader.model.asset.GetBegin();
            assetWalletBegin = reader.model.asset.Value.GetBegin();
            reader.model.asset.Value.currency.Get(out var assetWalletCurrency);
            Assert.True(assetWalletCurrency == "EUR");
            reader.model.asset.Value.amount.Get(out var assetWalletAmount);
            Assert.True(assetWalletAmount == 100.0);
            reader.model.asset.Value.GetEnd(assetWalletBegin);
            reader.model.asset.GetEnd(assetBegin);

            Assert.True(reader.model.orders.Size == 3);

            var o1 = reader.model.orders[0];
            orderBegin = o1.GetBegin();
            o1.id.Get(out var orderId1);
            Assert.True(orderId1 == 1);
            o1.symbol.Get(out var orderSymbol1);
            Assert.True(orderSymbol1 == "EURUSD");
            o1.side.Get(out var orderSide1);
            Assert.True(orderSide1 == OrderSide.buy);
            o1.type.Get(out var orderType1);
            Assert.True(orderType1 == OrderType.market);
            o1.price.Get(out var orderPrice1);
            Assert.True(orderPrice1 == 1.23456);
            o1.volume.Get(out var orderVolume1);
            Assert.True(orderVolume1 == 1000.0);
            o1.GetEnd(orderBegin);

            var o2 = reader.model.orders[1];
            orderBegin = o2.GetBegin();
            o2.id.Get(out var orderId2);
            Assert.True(orderId2 == 2);
            o2.symbol.Get(out var orderSymbol2);
            Assert.True(orderSymbol2 == "EURUSD");
            o2.side.Get(out var orderSide2);
            Assert.True(orderSide2 == OrderSide.sell);
            o2.type.Get(out var orderType2);
            Assert.True(orderType2 == OrderType.limit);
            o2.price.Get(out var orderPrice2);
            Assert.True(orderPrice2 == 1.0);
            o2.volume.Get(out var orderVolume2);
            Assert.True(orderVolume2 == 100.0);
            o1.GetEnd(orderBegin);

            var o3 = reader.model.orders[2];
            orderBegin = o3.GetBegin();
            o3.id.Get(out var orderId3);
            Assert.True(orderId3 == 3);
            o3.symbol.Get(out var orderSymbol3);
            Assert.True(orderSymbol3 == "EURUSD");
            o3.side.Get(out var orderSide3);
            Assert.True(orderSide3 == OrderSide.buy);
            o3.type.Get(out var orderType3);
            Assert.True(orderType3 == OrderType.stop);
            o3.price.Get(out var orderPrice3);
            Assert.True(orderPrice3 == 1.5);
            o3.volume.Get(out var orderVolume3);
            Assert.True(orderVolume3 == 10.0);
            o1.GetEnd(orderBegin);

            reader.model.GetEnd(accountBegin);
        }
    }
}
