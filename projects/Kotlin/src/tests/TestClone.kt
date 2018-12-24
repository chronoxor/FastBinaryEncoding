package tests

import java.util.*
import kotlin.test.*
import org.testng.annotations.*

class TestClone
{
    @Test
    fun cloneStructs()
    {
        // Create a new account with some orders
        var account1 = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        account1.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account1.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account1.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Clone the account
        val account2 = account1.clone()

        // Clear the source account
        @Suppress("UNUSED_VALUE")
        account1 = proto.Account()

        assertEquals(account2.id, 1)
        assertEquals(account2.name, "Test")
        assertTrue(account2.state.hasFlags(proto.State.good))
        assertEquals(account2.wallet.currency, "USD")
        assertEquals(account2.wallet.amount, 1000.0)
        assertNotEquals(account2.asset, null)
        assertEquals(account2.asset!!.currency, "EUR")
        assertEquals(account2.asset!!.amount, 100.0)
        assertEquals(account2.orders.size, 3)
        assertEquals(account2.orders[0].id, 1)
        assertEquals(account2.orders[0].symbol, "EURUSD")
        assertEquals(account2.orders[0].side, proto.OrderSide.buy)
        assertEquals(account2.orders[0].type, proto.OrderType.market)
        assertEquals(account2.orders[0].price, 1.23456)
        assertEquals(account2.orders[0].volume, 1000.0)
        assertEquals(account2.orders[1].id, 2)
        assertEquals(account2.orders[1].symbol, "EURUSD")
        assertEquals(account2.orders[1].side, proto.OrderSide.sell)
        assertEquals(account2.orders[1].type, proto.OrderType.limit)
        assertEquals(account2.orders[1].price, 1.0)
        assertEquals(account2.orders[1].volume, 100.0)
        assertEquals(account2.orders[2].id, 3)
        assertEquals(account2.orders[2].symbol, "EURUSD")
        assertEquals(account2.orders[2].side, proto.OrderSide.buy)
        assertEquals(account2.orders[2].type, proto.OrderType.stop)
        assertEquals(account2.orders[2].price, 1.5)
        assertEquals(account2.orders[2].volume, 10.0)
    }
}
