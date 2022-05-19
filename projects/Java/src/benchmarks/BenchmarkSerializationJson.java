package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

import com.chronoxor.proto.*;

@State(Scope.Benchmark)
public class BenchmarkSerializationJson
{
    private Account _account;
    private String _json;

    public BenchmarkSerializationJson()
    {
        // Create a new account with some orders
        _account = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        _account.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        _account.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Serialize the account to the JSON string
        _json = _account.toJson();

        // Deserialize the account from the JSON string
        _account = Account.fromJson(_json);
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void serialize()
    {
        // Serialize the account to the JSON string
        _json = _account.toJson();
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void deserialize()
    {
        // Deserialize the account from the JSON string
        _account = Account.fromJson(_json);
    }
}
