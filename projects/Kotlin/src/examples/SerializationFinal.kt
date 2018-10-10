package examples

import java.util.*

object SerializationFinal
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account with some orders
        val account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        account.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        val writer = proto.fbe.AccountFinalModel()
        writer.serialize(account)
        assert(writer.verify())

        // Show the serialized FBE size
        println("FBE final size: " + writer.buffer.size)

        // Deserialize the account from the FBE stream
        val reader = proto.fbe.AccountFinalModel()
        reader.attach(writer.buffer)
        assert(reader.verify())
        reader.deserialize(account)

        // Show account content
        println()
        println(account)
    }
}
