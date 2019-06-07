package tests

import kotlin.test.*
import org.testng.annotations.*

import com.chronoxor.proto.*
import com.chronoxor.proto.fbe.*

class TestCreate
{
    @Test
    fun createAndAccess()
    {
        // Create a new account using FBE model into the FBE stream
        val writer = AccountModel()
        assertEquals(writer.model.fbeOffset, 4)
        val modelBegin = writer.createBegin()
        var accountBegin = writer.model.setBegin()
        writer.model.id.set(1)
        writer.model.name.set("Test")
        writer.model.state.set(State.good)
        var walletBegin = writer.model.wallet.setBegin()
        writer.model.wallet.currency.set("USD")
        writer.model.wallet.amount.set(1000.0)
        writer.model.wallet.setEnd(walletBegin)
        var assetBegin = writer.model.asset.setBegin(true)
        var assetWalletBegin = writer.model.asset.value.setBegin()
        writer.model.asset.value.currency.set("EUR")
        writer.model.asset.value.amount.set(100.0)
        writer.model.asset.setEnd(assetBegin)
        writer.model.asset.value.setEnd(assetWalletBegin)
        val order = writer.model.orders.resize(3)
        var orderBegin = order.setBegin()
        order.id.set(1)
        order.symbol.set("EURUSD")
        order.side.set(OrderSide.buy)
        order.type.set(OrderType.market)
        order.price.set(1.23456)
        order.volume.set(1000.0)
        order.setEnd(orderBegin)
        order.fbeShift(order.fbeSize)
        orderBegin = order.setBegin()
        order.id.set(2)
        order.symbol.set("EURUSD")
        order.side.set(OrderSide.sell)
        order.type.set(OrderType.limit)
        order.price.set(1.0)
        order.volume.set(100.0)
        order.setEnd(orderBegin)
        order.fbeShift(order.fbeSize)
        orderBegin = order.setBegin()
        order.id.set(3)
        order.symbol.set("EURUSD")
        order.side.set(OrderSide.buy)
        order.type.set(OrderType.stop)
        order.price.set(1.5)
        order.volume.set(10.0)
        order.setEnd(orderBegin)
        order.fbeShift(order.fbeSize)
        writer.model.setEnd(accountBegin)
        val serialized = writer.createEnd(modelBegin)
        assertEquals(serialized, writer.buffer.size)
        assertTrue(writer.verify())
        writer.next(serialized)
        assertEquals(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        assertEquals(writer.buffer.size, 252)

        // Access the account model in the FBE stream
        val reader = AccountModel()
        assertEquals(reader.model.fbeOffset, 4)
        reader.attach(writer.buffer)
        assertTrue(reader.verify())

        val id: Int
        val name: String
        val state: State
        val walletCurrency: String
        val walletAmount: Double
        val assetWalletCurrency: String
        val assetWalletAmount: Double

        accountBegin = reader.model.getBegin()
        id = reader.model.id.get()
        assertEquals(id, 1)
        name = reader.model.name.get()
        assertEquals(name, "Test")
        state = reader.model.state.get()
        assertTrue(state.hasFlags(State.good))

        walletBegin = reader.model.wallet.getBegin()
        walletCurrency = reader.model.wallet.currency.get()
        assertEquals(walletCurrency, "USD")
        walletAmount = reader.model.wallet.amount.get()
        assertEquals(walletAmount, 1000.0)
        reader.model.wallet.getEnd(walletBegin)

        assertTrue(reader.model.asset.hasValue())
        assetBegin = reader.model.asset.getBegin()
        assetWalletBegin = reader.model.asset.value.getBegin()
        assetWalletCurrency = reader.model.asset.value.currency.get()
        assertEquals(assetWalletCurrency, "EUR")
        assetWalletAmount = reader.model.asset.value.amount.get()
        assertEquals(assetWalletAmount, 100.0)
        reader.model.asset.value.getEnd(assetWalletBegin)
        reader.model.asset.getEnd(assetBegin)

        assertEquals(reader.model.orders.size, 3)

        var orderId: Int
        var orderSymbol: String
        var orderSide: OrderSide
        var orderType: OrderType
        var orderPrice: Double
        var orderVolume: Double

        val o1 = reader.model.orders.getItem(0)
        orderBegin = o1.getBegin()
        orderId = o1.id.get()
        assertEquals(orderId, 1)
        orderSymbol = o1.symbol.get()
        assertEquals(orderSymbol, "EURUSD")
        orderSide = o1.side.get()
        assertEquals(orderSide, OrderSide.buy)
        orderType = o1.type.get()
        assertEquals(orderType, OrderType.market)
        orderPrice = o1.price.get()
        assertEquals(orderPrice, 1.23456)
        orderVolume = o1.volume.get()
        assertEquals(orderVolume, 1000.0)
        o1.getEnd(orderBegin)

        val o2 = reader.model.orders.getItem(1)
        orderBegin = o2.getBegin()
        orderId = o2.id.get()
        assertEquals(orderId, 2)
        orderSymbol = o2.symbol.get()
        assertEquals(orderSymbol, "EURUSD")
        orderSide = o2.side.get()
        assertEquals(orderSide, OrderSide.sell)
        orderType = o2.type.get()
        assertEquals(orderType, OrderType.limit)
        orderPrice = o2.price.get()
        assertEquals(orderPrice, 1.0)
        orderVolume = o2.volume.get()
        assertEquals(orderVolume, 100.0)
        o1.getEnd(orderBegin)

        val o3 = reader.model.orders.getItem(2)
        orderBegin = o3.getBegin()
        orderId = o3.id.get()
        assertEquals(orderId, 3)
        orderSymbol = o3.symbol.get()
        assertEquals(orderSymbol, "EURUSD")
        orderSide = o3.side.get()
        assertEquals(orderSide, OrderSide.buy)
        orderType = o3.type.get()
        assertEquals(orderType, OrderType.stop)
        orderPrice = o3.price.get()
        assertEquals(orderPrice, 1.5)
        orderVolume = o3.volume.get()
        assertEquals(orderVolume, 10.0)
        o1.getEnd(orderBegin)

        reader.model.getEnd(accountBegin)
    }
}
