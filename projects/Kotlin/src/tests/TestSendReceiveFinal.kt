package tests

import java.util.*
import kotlin.math.*
import kotlin.test.*
import org.testng.annotations.*

import com.chronoxor.protoex.*
import com.chronoxor.protoex.fbe.*

internal class MyFinalSender : FinalSender()
{
    override fun onSend(buffer: ByteArray, offset: Long, size: Long): Long
    {
        // Send nothing...
        return 0
    }
}

internal class MyFinalReceiver : FinalReceiver()
{
    private var _order: Boolean = false
    private var _balance: Boolean = false
    private var _account: Boolean = false

    val check: Boolean get() = _order && _balance && _account

    override fun onReceive(value: OrderMessage) { _order = true }
    override fun onReceive(value: BalanceMessage) { _balance = true }
    override fun onReceive(value: AccountMessage) { _account = true }
}

class TestSendReceiveFinal
{
    private fun sendAndReceiveFinal(i: Long, j: Long): Boolean
    {
        val sender = MyFinalSender()

        // Create and send a new order
        val order = Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0, 0.0, 0.0)
        sender.send(OrderMessage(order))

        // Create and send a new balance wallet
        val balance = Balance(com.chronoxor.proto.Balance("USD", 1000.0), 100.0)
        sender.send(BalanceMessage(balance))

        // Create and send a new account with some orders
        val account = Account(1, "Test", StateEx.good, Balance(com.chronoxor.proto.Balance("USD", 1000.0), 100.0), Balance(com.chronoxor.proto.Balance("EUR", 100.0), 10.0), ArrayList())
        account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
        account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0, 0.0, 0.0))
        account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0, 0.0, 0.0))
        sender.send(AccountMessage(account))

        val receiver = MyFinalReceiver()

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
    fun sendAndReceiveFinal()
    {
        for (i in 0..999)
            for (j in 0..999)
                assertTrue(sendAndReceiveFinal(i.toLong(), j.toLong()))
    }
}
