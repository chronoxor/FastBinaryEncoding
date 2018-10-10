package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

@State(Scope.Benchmark)
class BenchmarkSerializationJson
{
    private var _account: proto.Account
    private var _json: String

    init
    {
        // Create a new account with some orders
        _account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0), ArrayList())
        _account.orders.add(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        _account.orders.add(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        _account.orders.add(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the JSON string
        _json = _account.toJson()

        // Deserialize the account from the JSON string
        _account = proto.Account.fromJson(_json)
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    fun serialize()
    {
        // Serialize the account to the JSON string
        _json = _account.toJson()
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    fun deserialize()
    {
        // Deserialize the account from the JSON string
        _account = proto.Account.fromJson(_json)
    }
}
