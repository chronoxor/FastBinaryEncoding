require 'test/unit'

require_relative '../proto/proto'

class MySender < Proto::Sender
  def on_send(buffer, offset, size)
    # Send nothing...
    0
  end
end

class MyReceiver < Proto::Receiver
  def initialize
    super
    @_order = false
    @_balance = false
    @_account = false
  end

  def check
    @_order && @_balance && @_account
  end

  def on_receive_ordermessage(value)
    @_order = true
  end

  def on_receive_balancemessage(value)
    @_balance = true
  end

  def on_receive_accountmessage(value)
    @_account = true
  end
end

class TestSendReceive < Test::Unit::TestCase
  def send_and_receive(index1, index2)
    sender = MySender.new

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

    # Receive data from the sender
    index1 %= sender.buffer.size
    index2 %= sender.buffer.size
    index2 = [index1, index2].max
    receiver.receive(sender.buffer, 0, index1)
    receiver.receive(sender.buffer, index1, index2 - index1)
    receiver.receive(sender.buffer, index2, sender.buffer.size - index2)
    receiver.check
  end

  def test_send_and_receive
    100.times do |i|
      100.times do |j|
        assert_true(send_and_receive(i, j))
      end
    end
  end
end
