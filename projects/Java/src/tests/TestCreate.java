package tests;

import org.testng.*;
import org.testng.annotations.*;

public class TestCreate
{
    @Test()
    public void CreateAndAccess()
    {
        // Create a new account using FBE model into the FBE stream
        var writer = new proto.fbe.AccountModel();
        Assert.assertEquals(writer.model.FBEOffset(), 4);
        long model_begin = writer.createBegin();
        long account_begin = writer.model.setBegin();
        writer.model.uid.set(1);
        writer.model.name.set("Test");
        writer.model.state.set(proto.State.good);
        long wallet_begin = writer.model.wallet.setBegin();
        writer.model.wallet.currency.set("USD");
        writer.model.wallet.amount.set(1000.0);
        writer.model.wallet.setEnd(wallet_begin);
        long asset_begin = writer.model.asset.setBegin(true);
        long asset_wallet_begin = writer.model.asset.value.setBegin();
        writer.model.asset.value.currency.set("EUR");
        writer.model.asset.value.amount.set(100.0);
        writer.model.asset.setEnd(asset_begin);
        writer.model.asset.value.setEnd(asset_wallet_begin);
        var order = writer.model.orders.resize(3);
        long order_begin = order.setBegin();
        order.uid.set(1);
        order.symbol.set("EURUSD");
        order.side.set(proto.OrderSide.buy);
        order.type.set(proto.OrderType.market);
        order.price.set(1.23456);
        order.volume.set(1000.0);
        order.setEnd(order_begin);
        order.FBEShift(order.FBESize());
        order_begin = order.setBegin();
        order.uid.set(2);
        order.symbol.set("EURUSD");
        order.side.set(proto.OrderSide.sell);
        order.type.set(proto.OrderType.limit);
        order.price.set(1.0);
        order.volume.set(100.0);
        order.setEnd(order_begin);
        order.FBEShift(order.FBESize());
        order_begin = order.setBegin();
        order.uid.set(3);
        order.symbol.set("EURUSD");
        order.side.set(proto.OrderSide.buy);
        order.type.set(proto.OrderType.stop);
        order.price.set(1.5);
        order.volume.set(10.0);
        order.setEnd(order_begin);
        order.FBEShift(order.FBESize());
        writer.model.setEnd(account_begin);
        long serialized = writer.createEnd(model_begin);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.FBEOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 252);

        // Access the account model in the FBE stream
        var reader = new proto.fbe.AccountModel();
        Assert.assertEquals(reader.model.FBEOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());

        int uid;
        String name;
        proto.State state;
        String wallet_currency;
        double wallet_amount;
        String asset_wallet_currency;
        double asset_wallet_amount;

        account_begin = reader.model.getBegin();
        uid = reader.model.uid.get();
        Assert.assertEquals(uid, 1);
        name = reader.model.name.get();
        Assert.assertEquals(name, "Test");
        state = reader.model.state.get();
        Assert.assertTrue(state.hasFlags(proto.State.good));

        wallet_begin = reader.model.wallet.getBegin();
        wallet_currency = reader.model.wallet.currency.get();
        Assert.assertEquals(wallet_currency, "USD");
        wallet_amount = reader.model.wallet.amount.get();
        Assert.assertEquals(wallet_amount, 1000.0);
        reader.model.wallet.getEnd(wallet_begin);

        Assert.assertTrue(reader.model.asset.hasValue());
        asset_begin = reader.model.asset.getBegin();
        asset_wallet_begin = reader.model.asset.value.getBegin();
        asset_wallet_currency = reader.model.asset.value.currency.get();
        Assert.assertEquals(asset_wallet_currency, "EUR");
        asset_wallet_amount = reader.model.asset.value.amount.get();
        Assert.assertEquals(asset_wallet_amount, 100.0);
        reader.model.asset.value.getEnd(asset_wallet_begin);
        reader.model.asset.getEnd(asset_begin);

        Assert.assertEquals(reader.model.orders.getSize(), 3);

        int order_id;
        String order_symbol;
        proto.OrderSide order_side;
        proto.OrderType order_type;
        double order_price;
        double order_volume;

        var o1 = reader.model.orders.getItem(0);
        order_begin = o1.getBegin();
        order_id = o1.uid.get();
        Assert.assertEquals(order_id, 1);
        order_symbol = o1.symbol.get();
        Assert.assertEquals(order_symbol, "EURUSD");
        order_side = o1.side.get();
        Assert.assertEquals(order_side, proto.OrderSide.buy);
        order_type = o1.type.get();
        Assert.assertEquals(order_type, proto.OrderType.market);
        order_price = o1.price.get();
        Assert.assertEquals(order_price, 1.23456);
        order_volume = o1.volume.get();
        Assert.assertEquals(order_volume, 1000.0);
        o1.getEnd(order_begin);

        var o2 = reader.model.orders.getItem(1);
        order_begin = o2.getBegin();
        order_id = o2.uid.get();
        Assert.assertEquals(order_id, 2);
        order_symbol = o2.symbol.get();
        Assert.assertEquals(order_symbol, "EURUSD");
        order_side = o2.side.get();
        Assert.assertEquals(order_side, proto.OrderSide.sell);
        order_type = o2.type.get();
        Assert.assertEquals(order_type, proto.OrderType.limit);
        order_price = o2.price.get();
        Assert.assertEquals(order_price, 1.0);
        order_volume = o2.volume.get();
        Assert.assertEquals(order_volume, 100.0);
        o1.getEnd(order_begin);

        var o3 = reader.model.orders.getItem(2);
        order_begin = o3.getBegin();
        order_id = o3.uid.get();
        Assert.assertEquals(order_id, 3);
        order_symbol = o3.symbol.get();
        Assert.assertEquals(order_symbol, "EURUSD");
        order_side = o3.side.get();
        Assert.assertEquals(order_side, proto.OrderSide.buy);
        order_type = o3.type.get();
        Assert.assertEquals(order_type, proto.OrderType.stop);
        order_price = o3.price.get();
        Assert.assertEquals(order_price, 1.5);
        order_volume = o3.volume.get();
        Assert.assertEquals(order_volume, 10.0);
        o1.getEnd(order_begin);

        reader.model.getEnd(account_begin);
    }
}
