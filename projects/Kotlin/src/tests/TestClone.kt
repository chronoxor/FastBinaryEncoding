package tests

import java.util.*
import kotlin.test.*
import org.testng.annotations.*

import com.chronoxor.proto.*

class TestClone
{
    @Test
    fun cloneStructs()
    {
        // Create a new account with some orders
        var account1 = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        account1.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        account1.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        account1.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))

        // Clone the account
        val account2 = account1.clone()

        // Clear the source account
        @Suppress("UNUSED_VALUE")
        account1 = Account()

        assertEquals(account2.id, 1)
        assertEquals(account2.name, "Test")
        assertTrue(account2.state.hasFlags(State.good))
        assertEquals(account2.wallet.currency, "USD")
        assertEquals(account2.wallet.amount, 1000.0)
        assertNotEquals(account2.asset, null)
        assertEquals(account2.asset!!.currency, "EUR")
        assertEquals(account2.asset!!.amount, 100.0)
        assertEquals(account2.orders.size, 3)
        assertEquals(account2.orders[0].id, 1)
        assertEquals(account2.orders[0].symbol, "EURUSD")
        assertEquals(account2.orders[0].side, OrderSide.buy)
        assertEquals(account2.orders[0].type, OrderType.market)
        assertEquals(account2.orders[0].price, 1.23456)
        assertEquals(account2.orders[0].volume, 1000.0)
        assertEquals(account2.orders[1].id, 2)
        assertEquals(account2.orders[1].symbol, "EURUSD")
        assertEquals(account2.orders[1].side, OrderSide.sell)
        assertEquals(account2.orders[1].type, OrderType.limit)
        assertEquals(account2.orders[1].price, 1.0)
        assertEquals(account2.orders[1].volume, 100.0)
        assertEquals(account2.orders[2].id, 3)
        assertEquals(account2.orders[2].symbol, "EURUSD")
        assertEquals(account2.orders[2].side, OrderSide.buy)
        assertEquals(account2.orders[2].type, OrderType.stop)
        assertEquals(account2.orders[2].price, 1.5)
        assertEquals(account2.orders[2].volume, 10.0)
    }
}
