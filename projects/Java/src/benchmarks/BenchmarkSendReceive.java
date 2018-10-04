package benchmarks;

import java.util.*;
import org.openjdk.jmh.annotations.*;

class MySender1 extends proto.fbe.Sender
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

class MySender2 extends proto.fbe.Sender
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

class MyReceiver extends proto.fbe.Receiver
{
    private long _logSize;

    public long getLogSize() { return _logSize; }

    @Override
    protected void onReceive(proto.Order value) {}
    @Override
    protected void onReceive(proto.Balance value) {}
    @Override
    protected void onReceive(proto.Account value) {}

    @Override
    protected void onReceiveLog(String message) { _logSize += message.length(); }
}

@State(Scope.Benchmark)
public class BenchmarkSendReceive
{
    private final proto.Account _account;
    private final MySender1 _sender1;
    private final MySender2 _sender2;
    private final MyReceiver _receiver;

    public BenchmarkSendReceive()
    {
        // Create a new account with some orders
        _account = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        _account.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        _account.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        _account.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

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
