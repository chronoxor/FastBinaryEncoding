package examples

import java.util.*

import com.chronoxor.proto.*

object SerializationJson
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account with some orders
        var account = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))

        // Serialize the account to the JSON string
        val json = account.toJson()

        // Show the serialized JSON and its size
        println("JSON: $json")
        println("JSON size: " + json.length)

        // Deserialize the account from the JSON string
        account = Account.fromJson(json)

        // Show account content
        println()
        println(account)
    }
}
