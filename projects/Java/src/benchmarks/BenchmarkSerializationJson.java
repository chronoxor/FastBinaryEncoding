package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

@State(Scope.Benchmark)
public class BenchmarkSerializationJson
{
    private proto.Account _account;
    private String _json;

    public BenchmarkSerializationJson()
    {
        // Create a new account with some orders
        _account = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        _account.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        _account.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the JSON string
        _json = _account.toJson();

        // Deserialize the account from the JSON string
        _account = proto.Account.fromJson(_json);
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
        _account = proto.Account.fromJson(_json);
    }
}
