package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

@State(Scope.Benchmark)
public class BenchmarkSerializationFinal
{
    private proto.Account _account;
    private final proto.fbe.AccountFinalModel _writer;
    private final proto.fbe.AccountFinalModel _reader;

    public BenchmarkSerializationFinal()
    {
        // Create a new account with some orders
        _account = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        _account.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        _account.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        _writer = new proto.fbe.AccountFinalModel();
        _writer.serialize(_account);
        assert _writer.verify();

        // Deserialize the account from the FBE stream
        _reader = new proto.fbe.AccountFinalModel();
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
