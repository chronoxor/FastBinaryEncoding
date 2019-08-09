require 'benchmark'

require_relative '../proto/proto'

class MySender1 < Proto::Sender
  def initialize
    super
    @_size = 0
    @_log_size = 0
  end

  def size
    @_size
  end

  def log_size
    @_log_size
  end

  def on_send(buffer, offset, size)
    @_size += size
    size
  end

  def on_send_log(message)
    @_log_size += message.length
  end
end

class MySender2 < Proto::Sender
  def initialize
    super
    @_size = 0
    @_log_size = 0
  end

  def size
    @_size
  end

  def log_size
    @_log_size
  end

  def on_send(buffer, offset, size)
    @_size += size
    0
  end

  def on_send_log(message)
    @_log_size += message.length
  end
end

class MyReceiver < Proto::Receiver
  def initialize
    super
    @_log_size = 0
  end

  def log_size
    @_log_size
  end

  def on_receive_ordermessage(value)
  end

  def on_receive_balancemessage(value)
  end

  def on_receive_accountmessage(value)
  end

  def on_receive_log(message)
    @_log_size += message.length
  end
end

class BenchmarkSendReceive
  def initialize
    # Create a new account with some orders
    @account = Proto::AccountMessage.new(Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0)))
    @account.body.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
    @account.body.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
    @account.body.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

    @sender1 = MySender1.new
    @sender1.send(@account)

    @sender2 = MySender2.new
    @sender2.send(@account)

    @receiver = MyReceiver.new
    @receiver.receive(@sender2.buffer)
  end

  def send
    # Serialize and send the account
    @sender1.send(@account)
  end

  def send_with_logs
    # Enable logging
    @sender1.logging = true

    # Serialize and send the account
    @sender1.send(@account)
  end

  def receive
    # Receive the account from the sender
    @receiver.receive(@sender2.buffer)
  end

  def receive_with_logs
    # Enable logging
    @receiver.logging = true

    # Receive the account from the sender
    @receiver.receive(@sender2.buffer)
  end
end

benchmark = BenchmarkSendReceive.new
iterations = 100000

def report(name, duration, iterations)
  puts
  puts "Phase: #{name}"
  puts "Average time: %.3f mcs / iteration" % (duration / iterations * 1000000)
  puts "Total time: %.3f s" % duration
  puts "Total iterations: %d" % iterations
  puts "Iterations throughput: %.3f / second" % (iterations / duration)
  puts
end

puts "Benchmarking send() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.send }
end
report("Send", duration, iterations)

puts "Benchmarking send_with_logs() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.send_with_logs }
end
report("Send with logs", duration, iterations)

puts "Benchmarking receive() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.receive }
end
report("Receive", duration, iterations)

puts "Benchmarking receive_with_logs() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.receive_with_logs }
end
report("Receive with logs", duration, iterations)
