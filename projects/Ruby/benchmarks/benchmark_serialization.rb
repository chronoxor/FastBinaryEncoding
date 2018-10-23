require 'benchmark'

require_relative '../proto/proto'

class BenchmarkSerialization
  def initialize
    # Create a new account with some orders
    @account = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
    @account.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
    @account.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
    @account.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

    # Serialize the account to the FBE stream
    @writer = Proto::AccountModel.new(FBE::WriteBuffer.new)
    @writer.serialize(@account)
    raise "Verify error!" unless @writer.verify

    # Deserialize the account from the FBE stream
    @reader = Proto::AccountModel.new(FBE::ReadBuffer.new)
    @reader.attach_buffer(@writer.buffer)
    raise "Verify error!" unless @reader.verify
    @reader.deserialize(@account)
  end

  def serialize
    # Reset FBE stream
    @writer.reset

    # Serialize the account to the FBE stream
    @writer.serialize(@account)
  end

  def deserialize
    # Deserialize the account from the FBE stream
    @reader.deserialize(@account)
  end

  def verify
    # Verify the account
    @writer.verify
  end
end

benchmark = BenchmarkSerialization.new
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

puts "Benchmarking verify() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.verify }
end
report("Validate", duration, iterations)

puts "Benchmarking serialize() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.serialize }
end
report("Serialize", duration, iterations)

puts "Benchmarking deserialize() method..."
duration = Benchmark.realtime do
  iterations.times { benchmark.deserialize }
end
report("Deserialize", duration, iterations)
