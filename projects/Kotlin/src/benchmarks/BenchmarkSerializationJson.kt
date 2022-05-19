package benchmarks

import java.util.*
import org.openjdk.jmh.annotations.*

import com.chronoxor.proto.*

@State(Scope.Benchmark)
class BenchmarkSerializationJson
{
    private var _account: Account
    private var _json: String

    init
    {
        // Create a new account with some orders
        _account = Account(1, "Test", State.good, Balance("USD", 1000.0), Balance("EUR", 100.0), ArrayList())
        _account.orders.add(Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0))
        _account.orders.add(Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0))
        _account.orders.add(Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0))

        // Serialize the account to the JSON string
        _json = _account.toJson()

        // Deserialize the account from the JSON string
        _account = Account.fromJson(_json)
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
        _account = Account.fromJson(_json)
    }
}
