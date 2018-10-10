package tests

import java.util.*
import kotlin.test.*
import org.testng.annotations.*

class TestExtending
{
    @Test
    fun extendingOldNew()
    {
        // Create a new account with some orders
        val account1 = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        account1.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account1.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account1.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        val writer = proto.fbe.AccountModel()
        assertEquals(writer.model.fbeOffset, 4)
        val serialized = writer.serialize(account1)
        assertEquals(serialized, writer.buffer.size)
        assertTrue(writer.verify())
        writer.next(serialized)
        assertEquals(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        assertEquals(writer.buffer.size, 252)

        // Deserialize the account from the FBE stream
        val account2 = protoex.Account()
        val reader = protoex.fbe.AccountModel()
        assertEquals(reader.model.fbeOffset, 4)
        reader.attach(writer.buffer)
        assertTrue(reader.verify())
        val deserialized = reader.deserialize(account2)
        assertEquals(deserialized, reader.buffer.size)
        reader.next(deserialized)
        assertEquals(reader.model.fbeOffset, 4 + reader.buffer.size)

        assertEquals(account2.uid, 1)
        assertEquals(account2.name, "Test")
        assertEquals(account2.state, protoex.StateEx.good)
        assertEquals(account2.wallet.currency, "USD")
        assertEquals(account2.wallet.amount, 1000.0)
        assertEquals(account2.wallet.locked, 0.0)
        assertNotEquals(account2.asset, null)
        assertEquals(account2.asset!!.currency, "EUR")
        assertEquals(account2.asset!!.amount, 100.0)
        assertEquals(account2.asset!!.locked, 0.0)
        assertEquals(account2.orders.size, 3)
        assertEquals(account2.orders[0].uid, 1)
        assertEquals(account2.orders[0].symbol, "EURUSD")
        assertEquals(account2.orders[0].side, protoex.OrderSide.buy)
        assertEquals(account2.orders[0].type, protoex.OrderType.market)
        assertEquals(account2.orders[0].price, 1.23456)
        assertEquals(account2.orders[0].volume, 1000.0)
        assertEquals(account2.orders[0].tp, 10.0)
        assertEquals(account2.orders[0].sl, -10.0)
        assertEquals(account2.orders[1].uid, 2)
        assertEquals(account2.orders[1].symbol, "EURUSD")
        assertEquals(account2.orders[1].side, protoex.OrderSide.sell)
        assertEquals(account2.orders[1].type, protoex.OrderType.limit)
        assertEquals(account2.orders[1].price, 1.0)
        assertEquals(account2.orders[1].volume, 100.0)
        assertEquals(account2.orders[1].tp, 10.0)
        assertEquals(account2.orders[1].sl, -10.0)
        assertEquals(account2.orders[2].uid, 3)
        assertEquals(account2.orders[2].symbol, "EURUSD")
        assertEquals(account2.orders[2].side, protoex.OrderSide.buy)
        assertEquals(account2.orders[2].type, protoex.OrderType.stop)
        assertEquals(account2.orders[2].price, 1.5)
        assertEquals(account2.orders[2].volume, 10.0)
        assertEquals(account2.orders[2].tp, 10.0)
        assertEquals(account2.orders[2].sl, -10.0)
    }

    @Test
    fun extendingNewOld()
    {
        // Create a new account with some orders
        val account1 = protoex.Account()
        account1.uid = 1
        account1.name = "Test"
        account1.state = protoex.StateEx.fromSet(EnumSet.of(protoex.StateEx.good.value, protoex.StateEx.happy.value))
        account1.wallet.currency = "USD"
        account1.wallet.amount = 1000.0
        account1.wallet.locked = 123.456
        account1.asset = protoex.Balance()
        account1.asset!!.currency = "EUR"
        account1.asset!!.amount = 100.0
        account1.asset!!.locked = 12.34
        account1.orders.add(protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
        account1.orders.add(protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1))
        account1.orders.add(protoex.Order(3, "EURUSD", protoex.OrderSide.tell, protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1))

        // Serialize the account to the FBE stream
        val writer = protoex.fbe.AccountModel()
        assertEquals(writer.model.fbeOffset, 4)
        val serialized = writer.serialize(account1)
        assertEquals(serialized, writer.buffer.size)
        assertTrue(writer.verify())
        writer.next(serialized)
        assertEquals(writer.model.fbeOffset, 4 + writer.buffer.size)

        // Check the serialized FBE size
        assertEquals(writer.buffer.size, 316)

        // Deserialize the account from the FBE stream
        val account2 = proto.Account()
        val reader = proto.fbe.AccountModel()
        assertEquals(reader.model.fbeOffset, 4)
        reader.attach(writer.buffer)
        assertTrue(reader.verify())
        val deserialized = reader.deserialize(account2)
        assertEquals(deserialized, reader.buffer.size)
        reader.next(deserialized)
        assertEquals(reader.model.fbeOffset, 4 + reader.buffer.size)

        assertEquals(account2.uid, 1)
        assertEquals(account2.name, "Test")
        assertTrue(account2.state.hasFlags(proto.State.good))
        assertEquals(account2.wallet.currency, "USD")
        assertEquals(account2.wallet.amount, 1000.0)
        assertNotEquals(account2.asset, null)
        assertEquals(account2.asset!!.currency, "EUR")
        assertEquals(account2.asset!!.amount, 100.0)
        assertEquals(account2.orders.size, 3)
        assertEquals(account2.orders[0].uid, 1)
        assertEquals(account2.orders[0].symbol, "EURUSD")
        assertEquals(account2.orders[0].side, proto.OrderSide.buy)
        assertEquals(account2.orders[0].type, proto.OrderType.market)
        assertEquals(account2.orders[0].price, 1.23456)
        assertEquals(account2.orders[0].volume, 1000.0)
        assertEquals(account2.orders[1].uid, 2)
        assertEquals(account2.orders[1].symbol, "EURUSD")
        assertEquals(account2.orders[1].side, proto.OrderSide.sell)
        assertEquals(account2.orders[1].type, proto.OrderType.limit)
        assertEquals(account2.orders[1].price, 1.0)
        assertEquals(account2.orders[1].volume, 100.0)
        assertEquals(account2.orders[2].uid, 3)
        assertEquals(account2.orders[2].symbol, "EURUSD")
        assertNotEquals(account2.orders[2].side, proto.OrderSide.buy)
        assertNotEquals(account2.orders[2].type, proto.OrderType.market)
        assertEquals(account2.orders[2].price, 1.5)
        assertEquals(account2.orders[2].volume, 10.0)
    }
}
