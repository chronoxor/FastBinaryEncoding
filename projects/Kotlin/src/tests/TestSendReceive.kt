package tests

import java.util.*
import kotlin.math.*
import kotlin.test.*
import org.testng.annotations.*

internal class MySender : proto.fbe.Sender()
{
    override fun onSend(buffer: ByteArray, offset: Long, size: Long): Long
    {
        // Send nothing...
        return 0
    }
}

internal class MyReceiver : proto.fbe.Receiver()
{
    private var _order: Boolean = false
    private var _balance: Boolean = false
    private var _account: Boolean = false

    val check: Boolean get() = _order && _balance && _account

    override fun onReceive(value: proto.Order) { _order = true }
    override fun onReceive(value: proto.Balance) { _balance = true }
    override fun onReceive(value: proto.Account) { _account = true }
}

class TestSendReceive
{
    private fun sendAndReceive(i: Long, j: Long): Boolean
    {
        val sender = MySender()

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

        // Receive data from the sender
        val index1 = i % sender.buffer.size
        var index2 = j % sender.buffer.size
        index2 = max(index1, index2)
        receiver.receive(sender.buffer.data, 0, index1)
        receiver.receive(sender.buffer.data, index1, index2 - index1)
        receiver.receive(sender.buffer.data, index2, sender.buffer.size - index2)
        return receiver.check
    }

    @Test
    fun sendAndReceive()
    {
        for (i in 0..999)
            for (j in 0..999)
                assertTrue(sendAndReceive(i.toLong(), j.toLong()))
    }
}
