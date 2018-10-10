package tests

import java.util.*
import kotlin.test.*
import org.testng.annotations.*

internal class MyFinalSender : proto.fbe.FinalSender()
{
    override fun onSend(buffer: ByteArray, offset: Long, size: Long): Long
    {
        // Send nothing...
        return 0
    }
}

internal class MyFinalReceiver : proto.fbe.FinalReceiver()
{
    private var _order: Boolean = false
    private var _balance: Boolean = false
    private var _account: Boolean = false

    val check: Boolean get() = _order && _balance && _account

    override fun onReceive(value: proto.Order) { _order = true }
    override fun onReceive(value: proto.Balance) { _balance = true }
    override fun onReceive(value: proto.Account) { _account = true }
}

class TestSendReceiveFinal
{
    private fun sendAndReceiveFinal(i: Long): Boolean
    {
        val sender = MyFinalSender()

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

        val receiver = MyFinalReceiver()

        // Receive data from the sender
        val index = i % sender.buffer.size
        receiver.receive(sender.buffer.data, 0, index)
        receiver.receive(sender.buffer.data, index, sender.buffer.size - index)
        return receiver.check
    }

    @Test
    fun sendAndReceiveFinal()
    {
        for (i in 0..999)
            assertTrue(sendAndReceiveFinal(i.toLong()))
    }
}
