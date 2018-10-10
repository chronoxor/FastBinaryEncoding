package examples

import java.util.*

object SerializationJson
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account with some orders
        var account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        account.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the JSON string
        val json = account.toJson()

        // Show the serialized JSON and its size
        println("JSON: $json")
        System.out.println("JSON size: " + json.length)

        // Deserialize the account from the JSON string
        account = proto.Account.fromJson(json)

        // Show account content
        println()
        println(account)
    }
}
