package tests

import java.util.*
import kotlin.test.*
import org.testng.annotations.*

internal class MyFinalSender : protoex.fbe.FinalSender()
{
    override fun onSend(buffer: ByteArray, offset: Long, size: Long): Long
    {
        // Send nothing...
        return 0
    }
}

internal class MyFinalReceiver : protoex.fbe.FinalReceiver()
{
    private var _order: Boolean = false
    private var _balance: Boolean = false
    private var _account: Boolean = false

    val check: Boolean get() = _order && _balance && _account

    override fun onReceive(value: protoex.Order) { _order = true }
    override fun onReceive(value: protoex.Balance) { _balance = true }
    override fun onReceive(value: protoex.Account) { _account = true }
}

class TestSendReceiveFinal
{
    private fun sendAndReceiveFinal(i: Long): Boolean
    {
        val sender = MyFinalSender()

        // Create and send a new order
        val order = protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0)
        sender.send(order)

        // Create and send a new balance wallet
        val balance = protoex.Balance(proto.Balance("USD", 1000.0), 100.0)
        sender.send(balance)

        // Create and send a new account with some orders
        val account = protoex.Account(1, "Test", protoex.StateEx.good, protoex.Balance(proto.Balance("USD", 1000.0), 100.0), protoex.Balance(proto.Balance("EUR", 100.0), 10.0), ArrayList())
        account.orders.add(protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
        account.orders.add(protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.0, 0.0))
        account.orders.add(protoex.Order(3, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.stop, 1.5, 10.0, 0.0, 0.0))
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
