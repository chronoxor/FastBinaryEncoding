require_relative '../proto/proto'

# Create a new account with some orders
account = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
account.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
account.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
account.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

# Serialize the account to the FBE stream
writer = Proto::AccountModel.new(FBE::WriteBuffer.new)
writer.serialize(account)
raise "Verify error!" unless writer.verify

# Show the serialized FBE size
puts "FBE size: #{writer.buffer.size}"

# Deserialize the account from the FBE stream
reader = Proto::AccountModel.new(FBE::ReadBuffer.new)
reader.attach_buffer(writer.buffer)
raise "Verify error!" unless reader.verify
reader.deserialize(account)

# Show account content
puts
puts account
