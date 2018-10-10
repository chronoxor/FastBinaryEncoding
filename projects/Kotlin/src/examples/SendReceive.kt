package examples

import java.util.*

internal class MySender : proto.fbe.Sender()
{
    override fun onSend(buffer: ByteArray, offset: Long, size: Long): Long
    {
        // Send nothing...
        return 0
    }

    override fun onSendLog(message: String)
    {
        println("onSend: $message")
    }
}

internal class MyReceiver : proto.fbe.Receiver()
{
    override fun onReceive(value: proto.Order) {}
    override fun onReceive(value: proto.Balance) {}
    override fun onReceive(value: proto.Account) {}

    override fun onReceiveLog(message: String)
    {
        println("onReceive: $message")
    }
}

object SendReceive
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        val sender = MySender()

        // Enable logging
        sender.logging = true

        // Create and send a new order
        val order = proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0)
        sender.send(order)

        // Create and send a new balance wallet
        val balance = proto.Balance("USD", 1000.0)
        sender.send(balance)

        // Create and send a new account with some orders
        val account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        account.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))
        sender.send(account)

        val receiver = MyReceiver()

        // Enable logging
        receiver.logging = true

        // Receive all data from the sender
        receiver.receive(sender.buffer)
    }
}
