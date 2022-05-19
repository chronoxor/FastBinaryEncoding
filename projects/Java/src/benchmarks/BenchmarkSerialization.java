package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;

@State(Scope.Benchmark)
public class BenchmarkSerialization
{
    private Account _account;
    private final AccountModel _writer;
    private final AccountModel _reader;

    public BenchmarkSerialization()
    {
        // Create a new account with some orders
        _account = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        _account.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        _account.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        _writer = new AccountModel();
        _writer.serialize(_account);
        assert _writer.verify();

        // Deserialize the account from the FBE stream
        _reader = new AccountModel();
        _reader.attach(_writer.getBuffer());
        assert _reader.verify();
        _reader.deserialize(_account);
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void verify()
    {
        // Verify the account
        _writer.verify();
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void serialize()
    {
        // Reset FBE stream
        _writer.reset();

        // Serialize the account to the FBE stream
        _writer.serialize(_account);
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void deserialize()
    {
        // Deserialize the account from the FBE stream
        _reader.deserialize(_account);
    }
}
