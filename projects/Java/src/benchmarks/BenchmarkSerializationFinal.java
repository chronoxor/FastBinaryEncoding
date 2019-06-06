package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

@State(Scope.Benchmark)
public class BenchmarkSerializationFinal
{
    private com.chronoxor.proto.Account _account;
    private final com.chronoxor.proto.fbe.AccountFinalModel _writer;
    private final com.chronoxor.proto.fbe.AccountFinalModel _reader;

    public BenchmarkSerializationFinal()
    {
        // Create a new account with some orders
        _account = new com.chronoxor.proto.Account(1, "Test", com.chronoxor.proto.State.good, new com.chronoxor.proto.Balance("USD", 1000.0), new com.chronoxor.proto.Balance("EUR", 100.0), new ArrayList<com.chronoxor.proto.Order>());
        _account.orders.add(new com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0));
        _account.orders.add(new com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        _writer = new com.chronoxor.proto.fbe.AccountFinalModel();
        _writer.serialize(_account);
        assert _writer.verify();

        // Deserialize the account from the FBE stream
        _reader = new com.chronoxor.proto.fbe.AccountFinalModel();
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
