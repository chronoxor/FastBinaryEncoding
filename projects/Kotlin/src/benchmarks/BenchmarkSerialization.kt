package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

@State(Scope.Benchmark)
class BenchmarkSerialization
{
    @Suppress("JoinDeclarationAndAssignment")
    private val _account: proto.Account
    private val _writer: proto.fbe.AccountModel
    private val _reader: proto.fbe.AccountModel

    init
    {
        // Create a new account with some orders
        _account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        _account.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        _account.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        _account.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the FBE stream
        _writer = proto.fbe.AccountModel()
        _writer.serialize(_account)
        assert(_writer.verify())

        // Deserialize the account from the FBE stream
        _reader = proto.fbe.AccountModel()
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
