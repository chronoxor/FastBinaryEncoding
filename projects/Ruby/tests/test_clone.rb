require 'test/unit'

require_relative '../proto/proto'

class TestClone < Test::Unit::TestCase
  def test_clone
    # Create a new account with some orders
    account1 = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
    account1.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
    account1.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
    account1.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

    # Clone the account
    account2 = account1.clone

    # Clear the source account
    # noinspection RubyUnusedLocalVariable
    account1 = Proto::Account.new

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
    assert_equal(account2.orders[2].side, Proto::OrderSide.buy)
    assert_equal(account2.orders[2].type, Proto::OrderType.stop)
    assert_equal(account2.orders[2].price, 1.5)
    assert_equal(account2.orders[2].volume, 10.0)
  end
end
