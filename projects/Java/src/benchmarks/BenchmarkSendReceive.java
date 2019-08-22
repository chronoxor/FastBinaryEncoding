package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

class MySender1 extends com.chronoxor.proto.fbe.Sender
{
    private long _size;
    private long _logSize;

    public long getSize() { return _size; }
    public long getLogSize() { return _logSize; }

    @Override
    protected long onSend(byte[] buffer, long offset, long size) { _size += size; return size; }
    @Override
    protected void onSendLog(String message) { _logSize += message.length(); }
}

class MySender2 extends com.chronoxor.proto.fbe.Sender
{
    private long _size;
    private long _logSize;

    public long getSize() { return _size; }
    public long getLogSize() { return _logSize; }

    @Override
    protected long onSend(byte[] buffer, long offset, long size) { _size += size; return 0; }
    @Override
    protected void onSendLog(String message) { _logSize += message.length(); }
}

class MyReceiver extends com.chronoxor.proto.fbe.Receiver
{
    private long _logSize;

    public long getLogSize() { return _logSize; }

    @Override
    protected void onReceive(com.chronoxor.proto.OrderMessage value) {}
    @Override
    protected void onReceive(com.chronoxor.proto.BalanceMessage value) {}
    @Override
    protected void onReceive(com.chronoxor.proto.AccountMessage value) {}

    @Override
    protected void onReceiveLog(String message) { _logSize += message.length(); }
}

@State(Scope.Benchmark)
public class BenchmarkSendReceive
{
    private final com.chronoxor.proto.AccountMessage _account;
    private final MySender1 _sender1;
    private final MySender2 _sender2;
    private final MyReceiver _receiver;

    public BenchmarkSendReceive()
    {
        // Create a new account with some orders
        _account = new com.chronoxor.proto.AccountMessage(new com.chronoxor.proto.Account(1, "Test", com.chronoxor.proto.State.good, new com.chronoxor.proto.Balance("USD", 1000.0), new com.chronoxor.proto.Balance("EUR", 100.0), new ArrayList<com.chronoxor.proto.Order>()));
        _account.body.orders.add(new com.chronoxor.proto.Order(1, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.market, 1.23456, 1000.0));
        _account.body.orders.add(new com.chronoxor.proto.Order(2, "EURUSD", com.chronoxor.proto.OrderSide.sell, com.chronoxor.proto.OrderType.limit, 1.0, 100.0));
        _account.body.orders.add(new com.chronoxor.proto.Order(3, "EURUSD", com.chronoxor.proto.OrderSide.buy, com.chronoxor.proto.OrderType.stop, 1.5, 10.0));

        _sender1 = new MySender1();
        _sender1.send(_account);

        _sender2 = new MySender2();
        _sender2.send(_account);

        _receiver = new MyReceiver();
        _receiver.receive(_sender2.getBuffer());
    }

    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void send()
    {
        // Serialize and send the account
        _sender1.send(_account);
    }
    /*
    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void SendWithLogs()
    {
        // Enable logging
        _sender1.setLogging(true);

        // Serialize and send the account
        _sender1.send(_account);
    }
    */
    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void receive()
    {
        // Receive the account from the sender
        _receiver.receive(_sender2.getBuffer());
    }
    /*
    @Benchmark
    @BenchmarkMode(Mode.Throughput)
    public void receiveWithLogs()
    {
        // Enable logging
        _receiver.setLogging(true);

        // Receive the account from the sender
        _receiver.receive(_sender2.getBuffer());
    }
    */
}
