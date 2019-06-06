package tests;

import org.testng.*;
import org.testng.annotations.*;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;

public class TestCreate
{
    @Test()
    public void createAndAccess()
    {
        // Create a new account using FBE model into the FBE stream
        var writer = new AccountModel();
        Assert.assertEquals(writer.model.fbeOffset(), 4);
        long modelBegin = writer.createBegin();
        long accountBegin = writer.model.setBegin();
        writer.model.id.set(1);
        writer.model.name.set("Test");
        writer.model.state.set(State.good);
        long walletBegin = writer.model.wallet.setBegin();
        writer.model.wallet.currency.set("USD");
        writer.model.wallet.amount.set(1000.0);
        writer.model.wallet.setEnd(walletBegin);
        long assetBegin = writer.model.asset.setBegin(true);
        long assetWalletBegin = writer.model.asset.value.setBegin();
        writer.model.asset.value.currency.set("EUR");
        writer.model.asset.value.amount.set(100.0);
        writer.model.asset.setEnd(assetBegin);
        writer.model.asset.value.setEnd(assetWalletBegin);
        var order = writer.model.orders.resize(3);
        long orderBegin = order.setBegin();
        order.id.set(1);
        order.symbol.set("EURUSD");
        order.side.set(OrderSide.buy);
        order.type.set(OrderType.market);
        order.price.set(1.23456);
        order.volume.set(1000.0);
        order.setEnd(orderBegin);
        order.fbeShift(order.fbeSize());
        orderBegin = order.setBegin();
        order.id.set(2);
        order.symbol.set("EURUSD");
        order.side.set(OrderSide.sell);
        order.type.set(OrderType.limit);
        order.price.set(1.0);
        order.volume.set(100.0);
        order.setEnd(orderBegin);
        order.fbeShift(order.fbeSize());
        orderBegin = order.setBegin();
        order.id.set(3);
        order.symbol.set("EURUSD");
        order.side.set(OrderSide.buy);
        order.type.set(OrderType.stop);
        order.price.set(1.5);
        order.volume.set(10.0);
        order.setEnd(orderBegin);
        order.fbeShift(order.fbeSize());
        writer.model.setEnd(accountBegin);
        long serialized = writer.createEnd(modelBegin);
        Assert.assertEquals(serialized, writer.getBuffer().getSize());
        Assert.assertTrue(writer.verify());
        writer.next(serialized);
        Assert.assertEquals(writer.model.fbeOffset(), (4 + writer.getBuffer().getSize()));

        // Check the serialized FBE size
        Assert.assertEquals(writer.getBuffer().getSize(), 252);

        // Access the account model in the FBE stream
        var reader = new AccountModel();
        Assert.assertEquals(reader.model.fbeOffset(), 4);
        reader.attach(writer.getBuffer());
        Assert.assertTrue(reader.verify());

        int id;
        String name;
        State state;
        String walletCurrency;
        double walletAmount;
        String assetWalletCurrency;
        double assetWalletAmount;

        accountBegin = reader.model.getBegin();
        id = reader.model.id.get();
        Assert.assertEquals(id, 1);
        name = reader.model.name.get();
        Assert.assertEquals(name, "Test");
        state = reader.model.state.get();
        Assert.assertTrue(state.hasFlags(State.good));

        walletBegin = reader.model.wallet.getBegin();
        walletCurrency = reader.model.wallet.currency.get();
        Assert.assertEquals(walletCurrency, "USD");
        walletAmount = reader.model.wallet.amount.get();
        Assert.assertEquals(walletAmount, 1000.0);
        reader.model.wallet.getEnd(walletBegin);

        Assert.assertTrue(reader.model.asset.hasValue());
        assetBegin = reader.model.asset.getBegin();
        assetWalletBegin = reader.model.asset.value.getBegin();
        assetWalletCurrency = reader.model.asset.value.currency.get();
        Assert.assertEquals(assetWalletCurrency, "EUR");
        assetWalletAmount = reader.model.asset.value.amount.get();
        Assert.assertEquals(assetWalletAmount, 100.0);
        reader.model.asset.value.getEnd(assetWalletBegin);
        reader.model.asset.getEnd(assetBegin);

        Assert.assertEquals(reader.model.orders.getSize(), 3);

        int orderId;
        String orderSymbol;
        OrderSide orderSide;
        OrderType orderType;
        double orderPrice;
        double orderVolume;

        var o1 = reader.model.orders.getItem(0);
        orderBegin = o1.getBegin();
        orderId = o1.id.get();
        Assert.assertEquals(orderId, 1);
        orderSymbol = o1.symbol.get();
        Assert.assertEquals(orderSymbol, "EURUSD");
        orderSide = o1.side.get();
        Assert.assertEquals(orderSide, OrderSide.buy);
        orderType = o1.type.get();
        Assert.assertEquals(orderType, OrderType.market);
        orderPrice = o1.price.get();
        Assert.assertEquals(orderPrice, 1.23456);
        orderVolume = o1.volume.get();
        Assert.assertEquals(orderVolume, 1000.0);
        o1.getEnd(orderBegin);

        var o2 = reader.model.orders.getItem(1);
        orderBegin = o2.getBegin();
        orderId = o2.id.get();
        Assert.assertEquals(orderId, 2);
        orderSymbol = o2.symbol.get();
        Assert.assertEquals(orderSymbol, "EURUSD");
        orderSide = o2.side.get();
        Assert.assertEquals(orderSide, OrderSide.sell);
        orderType = o2.type.get();
        Assert.assertEquals(orderType, OrderType.limit);
        orderPrice = o2.price.get();
        Assert.assertEquals(orderPrice, 1.0);
        orderVolume = o2.volume.get();
        Assert.assertEquals(orderVolume, 100.0);
        o1.getEnd(orderBegin);

        var o3 = reader.model.orders.getItem(2);
        orderBegin = o3.getBegin();
        orderId = o3.id.get();
        Assert.assertEquals(orderId, 3);
        orderSymbol = o3.symbol.get();
        Assert.assertEquals(orderSymbol, "EURUSD");
        orderSide = o3.side.get();
        Assert.assertEquals(orderSide, OrderSide.buy);
        orderType = o3.type.get();
        Assert.assertEquals(orderType, OrderType.stop);
        orderPrice = o3.price.get();
        Assert.assertEquals(orderPrice, 1.5);
        orderVolume = o3.volume.get();
        Assert.assertEquals(orderVolume, 10.0);
        o1.getEnd(orderBegin);

        reader.model.getEnd(accountBegin);
    }
}
