require 'test/unit'

require_relative '../proto/protoex'

class MyFinalSender < Protoex::FinalSender
  def on_send(buffer, offset, size)
    # Send nothing...
    0
  end
end

class MyFinalReceiver < Protoex::FinalReceiver
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

class TestSendReceiveFinal < Test::Unit::TestCase
  def send_and_receive_final(index1, index2)
    sender = MyFinalSender.new

    # Create and send a new order
    order = Protoex::Order.new(1, 'EURUSD', Protoex::OrderSide.buy, Protoex::OrderType.market, 1.23456, 1000.0, 0.0, 0.0)
    sender.send(Protoex::OrderMessage.new(order))

    # Create and send a new balance wallet
    balance = Protoex::Balance.new(Proto::Balance.new('USD', 1000.0), 100.0)
    sender.send(Protoex::BalanceMessage.new(balance))

    # Create and send a new account with some orders
    account = Protoex::Account.new(1, 'Test', Protoex::StateEx.good, Protoex::Balance.new(Proto::Balance.new('USD', 1000.0), 100.0), Protoex::Balance.new(Proto::Balance.new('EUR', 100.0), 10.0))
    account.orders.push(Protoex::Order.new(1, 'EURUSD', Protoex::OrderSide.buy, Protoex::OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
    account.orders.push(Protoex::Order.new(2, 'EURUSD', Protoex::OrderSide.sell, Protoex::OrderType.limit, 1.0, 100.0, 0.0, 0.0))
    account.orders.push(Protoex::Order.new(3, 'EURUSD', Protoex::OrderSide.buy, Protoex::OrderType.stop, 1.5, 10.0, 0.0, 0.0))
    sender.send(Protoex::AccountMessage.new(account))

    receiver = MyFinalReceiver.new

    # Receive data from the sender
    index1 %= sender.buffer.size
    index2 %= sender.buffer.size
    index2 = [index1, index2].max
    receiver.receive(sender.buffer, 0, index1)
    receiver.receive(sender.buffer, index1, index2 - index1)
    receiver.receive(sender.buffer, index2, sender.buffer.size - index2)
    receiver.check
  end

  def test_send_and_receive_final
    100.times do |i|
      100.times do |j|
        assert_true(send_and_receive_final(i, j))
      end
    end
  end
end
