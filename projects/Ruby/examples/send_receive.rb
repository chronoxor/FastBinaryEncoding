require_relative '../proto/proto'

class MySender < Proto::Sender
  def on_send(buffer, offset, size)
    # Send nothing...
    0
  end

  def on_send_log(message)
    puts "onSend: #{message}"
  end
end

class MyReceiver < Proto::Receiver
  def on_receive_ordermessage(value)
  end

  def on_receive_balancemessage(value)
  end

  def on_receive_accountmessage(value)
  end

  def on_receive_log(message)
    puts "onReceive: #{message}"
  end
end

sender = MySender.new

# Enable logging
sender.logging = true

# Create and send a new order
order = Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0)
sender.send(Proto::OrderMessage.new(order))

# Create and send a new balance wallet
balance = Proto::Balance.new('USD', 1000.0)
sender.send(Proto::BalanceMessage.new(balance))

# Create and send a new account with some orders
account = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
account.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
account.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
account.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))
sender.send(Proto::AccountMessage.new(account))

receiver = MyReceiver.new

# Enable logging
receiver.logging = true

# Receive all data from the sender
receiver.receive(sender.buffer)
