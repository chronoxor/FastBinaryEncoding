package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

import com.chronoxor.proto.*
import com.chronoxor.proto.fbe.*

@State(Scope.Benchmark)
class BenchmarkSerialization
{
    @Suppress("JoinDeclarationAndAssignment")
    private val _account: Account
    private val _writer: AccountModel
    private val _reader: AccountModel

    init
    {
        // Create a new account with some orders
        _account = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        _account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        _account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        _account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        _writer = AccountModel()
        _writer.serialize(_account)
        assert(_writer.verify())

        // Deserialize the account from the FBE stream
        _reader = AccountModel()
        _reader.attach(_writer.buffer)
        assert(_reader.verify())
        _reader.deserialize(_account)
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    fun verify()
    {
        // Verify the account
        _writer.verify()
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    fun serialize()
    {
        // Reset FBE stream
        _writer.reset()

        // Serialize the account to the FBE stream
        _writer.serialize(_account)
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    fun deserialize()
    {
        // Deserialize the account from the FBE stream
        _reader.deserialize(_account)
    }
}
