// ReSharper disable CompareOfFloatsByEqualityOperator

using NUnit.Framework;

namespace Tests
{
    [TestFixture]
    public class Create
    {
        [TestCase(TestName = "Create & access")]
        public void CreateAndAccess()
        {
            // Create a new account using FBE model into the FBE stream
            var writer = new FBE.proto.AccountModel();
            Assert.That(writer.model.FBEOffset == 4);
            long modelBegin = writer.CreateBegin();
            long accountBegin = writer.model.SetBegin();
            writer.model.id.Set(1);
            writer.model.name.Set("Test");
            writer.model.state.Set(proto.State.good);
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
            order.side.Set(proto.OrderSide.buy);
            order.type.Set(proto.OrderType.market);
            order.price.Set(1.23456);
            order.volume.Set(1000.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            orderBegin = order.SetBegin();
            order.id.Set(2);
            order.symbol.Set("EURUSD");
            order.side.Set(proto.OrderSide.sell);
            order.type.Set(proto.OrderType.limit);
            order.price.Set(1.0);
            order.volume.Set(100.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            orderBegin = order.SetBegin();
            order.id.Set(3);
            order.symbol.Set("EURUSD");
            order.side.Set(proto.OrderSide.buy);
            order.type.Set(proto.OrderType.stop);
            order.price.Set(1.5);
            order.volume.Set(10.0);
            order.SetEnd(orderBegin);
            order.FBEShift(order.FBESize);
            writer.model.SetEnd(accountBegin);
            long serialized = writer.CreateEnd(modelBegin);
            Assert.That(serialized == writer.Buffer.Size);
            Assert.That(writer.Verify());
            writer.Next(serialized);
            Assert.That(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.That(writer.Buffer.Size == 252);

            // Access the account model in the FBE stream
            var reader = new FBE.proto.AccountModel();
            Assert.That(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.That(reader.Verify());

            accountBegin = reader.model.GetBegin();
            reader.model.id.Get(out var id);
            Assert.That(id == 1);
            reader.model.name.Get(out var name);
            Assert.That(name == "Test");
            reader.model.state.Get(out var state);
            Assert.That(state.HasFlags(proto.State.good));

            walletBegin = reader.model.wallet.GetBegin();
            reader.model.wallet.currency.Get(out var walletCurrency);
            Assert.That(walletCurrency == "USD");
            reader.model.wallet.amount.Get(out var walletAmount);
            Assert.That(walletAmount == 1000.0);
            reader.model.wallet.GetEnd(walletBegin);

            Assert.That(reader.model.asset.HasValue);
            assetBegin = reader.model.asset.GetBegin();
            assetWalletBegin = reader.model.asset.Value.GetBegin();
            reader.model.asset.Value.currency.Get(out var assetWalletCurrency);
            Assert.That(assetWalletCurrency == "EUR");
            reader.model.asset.Value.amount.Get(out var assetWalletAmount);
            Assert.That(assetWalletAmount == 100.0);
            reader.model.asset.Value.GetEnd(assetWalletBegin);
            reader.model.asset.GetEnd(assetBegin);

            Assert.That(reader.model.orders.Size == 3);

            var o1 = reader.model.orders[0];
            orderBegin = o1.GetBegin();
            o1.id.Get(out var orderId1);
            Assert.That(orderId1 == 1);
            o1.symbol.Get(out var orderSymbol1);
            Assert.That(orderSymbol1 == "EURUSD");
            o1.side.Get(out var orderSide1);
            Assert.That(orderSide1 == proto.OrderSide.buy);
            o1.type.Get(out var orderType1);
            Assert.That(orderType1 == proto.OrderType.market);
            o1.price.Get(out var orderPrice1);
            Assert.That(orderPrice1 == 1.23456);
            o1.volume.Get(out var orderVolume1);
            Assert.That(orderVolume1 == 1000.0);
            o1.GetEnd(orderBegin);

            var o2 = reader.model.orders[1];
            orderBegin = o2.GetBegin();
            o2.id.Get(out var orderId2);
            Assert.That(orderId2 == 2);
            o2.symbol.Get(out var orderSymbol2);
            Assert.That(orderSymbol2 == "EURUSD");
            o2.side.Get(out var orderSide2);
            Assert.That(orderSide2 == proto.OrderSide.sell);
            o2.type.Get(out var orderType2);
            Assert.That(orderType2 == proto.OrderType.limit);
            o2.price.Get(out var orderPrice2);
            Assert.That(orderPrice2 == 1.0);
            o2.volume.Get(out var orderVolume2);
            Assert.That(orderVolume2 == 100.0);
            o1.GetEnd(orderBegin);

            var o3 = reader.model.orders[2];
            orderBegin = o3.GetBegin();
            o3.id.Get(out var orderId3);
            Assert.That(orderId3 == 3);
            o3.symbol.Get(out var orderSymbol3);
            Assert.That(orderSymbol3 == "EURUSD");
            o3.side.Get(out var orderSide3);
            Assert.That(orderSide3 == proto.OrderSide.buy);
            o3.type.Get(out var orderType3);
            Assert.That(orderType3 == proto.OrderType.stop);
            o3.price.Get(out var orderPrice3);
            Assert.That(orderPrice3 == 1.5);
            o3.volume.Get(out var orderVolume3);
            Assert.That(orderVolume3 == 10.0);
            o1.GetEnd(orderBegin);

            reader.model.GetEnd(accountBegin);
        }
    }
}
