package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

@State(Scope.Benchmark)
class BenchmarkSerializationJson
{
    private var _account: com.chronoxor.proto.Account
    private var _json: String

    init
    {
        // Create a new account with some orders
        _account = com.chronoxor.proto.Account(1, "Test", com.chronoxor.proto.State.good, com.chronoxor.proto.Balance("USD", 1000.0), com.chronoxor.proto.Balance("EUR", 100.0), ArrayList())
        _account.orders.add(com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0))
        _account.orders.add(com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0))
        _account.orders.add(com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0))

        // Serialize the account to the JSON string
        _json = _account.toJson()

        // Deserialize the account from the JSON string
        _account = com.chronoxor.proto.Account.fromJson(_json)
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
        _account = com.chronoxor.proto.Account.fromJson(_json)
    }
}
