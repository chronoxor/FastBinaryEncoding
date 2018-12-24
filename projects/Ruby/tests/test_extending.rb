require 'test/unit'

require_relative '../proto/protoex'

class TestExtending < Test::Unit::TestCase
  def test_extending_old_new
    # Create a new account with some orders
    account1 = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
    account1.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
    account1.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
    account1.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

    # Serialize the account to the FBE stream
    writer = Proto::AccountModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(account1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 252)

    # Deserialize the account from the FBE stream
    # noinspection RubyUnusedLocalVariable
    account2 = Protoex::Account.new
    reader = Protoex::AccountModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    account2, deserialized = reader.deserialize(account2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(account2.id, 1)
    assert_equal(account2.name, 'Test')
    assert_true(account2.state.has_flags(Protoex::StateEx.good))
    assert_equal(account2.wallet.currency, 'USD')
    assert_equal(account2.wallet.amount, 1000.0)
    assert_equal(account2.wallet.locked, 0.0)
    assert_false(account2.asset.nil?)
    assert_equal(account2.asset.currency, 'EUR')
    assert_equal(account2.asset.amount, 100.0)
    assert_equal(account2.asset.locked, 0.0)
    assert_equal(account2.orders.length, 3)
    assert_equal(account2.orders[0].id, 1)
    assert_equal(account2.orders[0].symbol, 'EURUSD')
    assert_equal(account2.orders[0].side, Protoex::OrderSide.buy)
    assert_equal(account2.orders[0].type, Protoex::OrderType.market)
    assert_equal(account2.orders[0].price, 1.23456)
    assert_equal(account2.orders[0].volume, 1000.0)
    assert_equal(account2.orders[0].tp, 10.0)
    assert_equal(account2.orders[0].sl, -10.0)
    assert_equal(account2.orders[1].id, 2)
    assert_equal(account2.orders[1].symbol, 'EURUSD')
    assert_equal(account2.orders[1].side, Protoex::OrderSide.sell)
    assert_equal(account2.orders[1].type, Protoex::OrderType.limit)
    assert_equal(account2.orders[1].price, 1.0)
    assert_equal(account2.orders[1].volume, 100.0)
    assert_equal(account2.orders[1].tp, 10.0)
    assert_equal(account2.orders[1].sl, -10.0)
    assert_equal(account2.orders[2].id, 3)
    assert_equal(account2.orders[2].symbol, 'EURUSD')
    assert_equal(account2.orders[2].side, Protoex::OrderSide.buy)
    assert_equal(account2.orders[2].type, Protoex::OrderType.stop)
    assert_equal(account2.orders[2].price, 1.5)
    assert_equal(account2.orders[2].volume, 10.0)
    assert_equal(account2.orders[2].tp, 10.0)
    assert_equal(account2.orders[2].sl, -10.0)
  end

  def test_extending_new_old
    # Create a new account with some orders
    account1 = Protoex::Account.new(1, 'Test', Protoex::StateEx.good | Protoex::StateEx.happy, Protoex::Balance.new(Proto::Balance.new('USD', 1000.0), 123.456), Protoex::Balance.new(Proto::Balance.new('EUR', 100.0), 12.34))
    account1.orders.push(Protoex::Order.new(1, 'EURUSD', Protoex::OrderSide.buy, Protoex::OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
    account1.orders.push(Protoex::Order.new(2, 'EURUSD', Protoex::OrderSide.sell, Protoex::OrderType.limit, 1.0, 100.0, 0.1, -0.1))
    account1.orders.push(Protoex::Order.new(3, 'EURUSD', Protoex::OrderSide.tell, Protoex::OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1))

    # Serialize the account to the FBE stream
    writer = Protoex::AccountModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(account1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 316)

    # Deserialize the account from the FBE stream
    # noinspection RubyUnusedLocalVariable
    account2 = Proto::Account.new
    reader = Proto::AccountModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    account2, deserialized = reader.deserialize(account2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(account2.id, 1)
    assert_equal(account2.name, 'Test')
    assert_true(account2.state.has_flags(Proto::State.good))
    assert_equal(account2.wallet.currency, 'USD')
    assert_equal(account2.wallet.amount, 1000.0)
    assert_false(account2.asset.nil?)
    assert_equal(account2.asset.currency, 'EUR')
    assert_equal(account2.asset.amount, 100.0)
    assert_equal(account2.orders.length, 3)
    assert_equal(account2.orders[0].id, 1)
    assert_equal(account2.orders[0].symbol, 'EURUSD')
    assert_equal(account2.orders[0].side, Proto::OrderSide.buy)
    assert_equal(account2.orders[0].type, Proto::OrderType.market)
    assert_equal(account2.orders[0].price, 1.23456)
    assert_equal(account2.orders[0].volume, 1000.0)
    assert_equal(account2.orders[1].id, 2)
    assert_equal(account2.orders[1].symbol, 'EURUSD')
    assert_equal(account2.orders[1].side, Proto::OrderSide.sell)
    assert_equal(account2.orders[1].type, Proto::OrderType.limit)
    assert_equal(account2.orders[1].price, 1.0)
    assert_equal(account2.orders[1].volume, 100.0)
    assert_equal(account2.orders[2].id, 3)
    assert_equal(account2.orders[2].symbol, 'EURUSD')
    assert_not_equal(account2.orders[2].side, Proto::OrderSide.buy)
    assert_not_equal(account2.orders[2].type, Proto::OrderType.market)
    assert_equal(account2.orders[2].price, 1.5)
    assert_equal(account2.orders[2].volume, 10.0)
  end
end
