package examples

import java.util.*

import com.chronoxor.proto.*
import com.chronoxor.proto.fbe.*

internal class MySender : Sender()
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

internal class MyReceiver : Receiver()
{
    override fun onReceive(value: OrderMessage) {}
    override fun onReceive(value: BalanceMessage) {}
    override fun onReceive(value: AccountMessage) {}

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
        val order = Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0)
        sender.send(OrderMessage(order))

        // Create and send a new balance wallet
        val balance = Balance("USD", 1000.0)
        sender.send(BalanceMessage(balance))

        // Create and send a new account with some orders
        val account = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))
        sender.send(AccountMessage(account))

        val receiver = MyReceiver()

        // Enable logging
        receiver.logging = true

        // Receive all data from the sender
        receiver.receive(sender.buffer)
    }
}
