package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

@State(Scope.Benchmark)
class BenchmarkSerializationFinal
{
    @Suppress("JoinDeclarationAndAssignment")
    private var _account: com.chronoxor.proto.Account
    private var _writer: com.chronoxor.proto.fbe.AccountFinalModel
    private var _reader: com.chronoxor.proto.fbe.AccountFinalModel

    init
    {
        // Create a new account with some orders
        _account = com.chronoxor.proto.Account(1, "Test", com.chronoxor.proto.State.good, com.chronoxor.proto.Balance("USD", 1000.0), com.chronoxor.proto.Balance("EUR", 100.0), ArrayList())
        _account.orders.add(com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0))
        _account.orders.add(com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0))
        _account.orders.add(com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        _writer = com.chronoxor.proto.fbe.AccountFinalModel()
        _writer.serialize(_account)
        assert(_writer.verify())

        // Deserialize the account from the FBE stream
        _reader = com.chronoxor.proto.fbe.AccountFinalModel()
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
