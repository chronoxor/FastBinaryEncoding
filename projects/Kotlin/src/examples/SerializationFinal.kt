package examples

import java.util.*

import com.chronoxor.proto.*
import com.chronoxor.proto.fbe.*

object SerializationFinal
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account with some orders
        val account = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        val writer = AccountFinalModel()
        writer.serialize(account)
        assert(writer.verify())

        // Show the serialized FBE size
        println("FBE final size: " + writer.buffer.size)

        // Deserialize the account from the FBE stream
        val reader = AccountFinalModel()
        reader.attach(writer.buffer)
        assert(reader.verify())
        reader.deserialize(account)

        // Show account content
        println()
        println(account)
    }
}
