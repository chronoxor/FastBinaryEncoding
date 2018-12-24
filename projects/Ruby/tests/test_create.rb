require 'test/unit'

require_relative '../proto/proto'

class TestCreate < Test::Unit::TestCase
  def test_create_and_access
    # Create a new account using FBE model into the FBE stream
    writer = Proto::AccountModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_offset, 4)
    model_begin = writer.create_begin
    account_begin = writer.model.set_begin
    writer.model.id.set(1)
    writer.model.name.set('Test')
    writer.model.state.set(Proto::State.good)
    wallet_begin = writer.model.wallet.set_begin
    writer.model.wallet.currency.set('USD')
    writer.model.wallet.amount.set(1000.0)
    writer.model.wallet.set_end(wallet_begin)
    asset_begin = writer.model.asset.set_begin(true)
    asset_wallet_begin = writer.model.asset.value.set_begin
    writer.model.asset.value.currency.set('EUR')
    writer.model.asset.value.amount.set(100.0)
    writer.model.asset.set_end(asset_begin)
    writer.model.asset.value.set_end(asset_wallet_begin)
    order = writer.model.orders.resize(3)
    order_begin = order.set_begin
    order.id.set(1)
    order.symbol.set('EURUSD')
    order.side.set(Proto::OrderSide.buy)
    order.type.set(Proto::OrderType.market)
    order.price.set(1.23456)
    order.volume.set(1000.0)
    order.set_end(order_begin)
    order.fbe_shift(order.fbe_size)
    order_begin = order.set_begin
    order.id.set(2)
    order.symbol.set('EURUSD')
    order.side.set(Proto::OrderSide.sell)
    order.type.set(Proto::OrderType.limit)
    order.price.set(1.0)
    order.volume.set(100.0)
    order.set_end(order_begin)
    order.fbe_shift(order.fbe_size)
    order_begin = order.set_begin
    order.id.set(3)
    order.symbol.set('EURUSD')
    order.side.set(Proto::OrderSide.buy)
    order.type.set(Proto::OrderType.stop)
    order.price.set(1.5)
    order.volume.set(10.0)
    order.set_end(order_begin)
    order.fbe_shift(order.fbe_size)
    writer.model.set_end(account_begin)
    serialized = writer.create_end(model_begin)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 252)

    # Access the account model in the FBE stream
    reader = Proto::AccountModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)

    account_begin = reader.model.get_begin
    id = reader.model.id.get
    assert_equal(id, 1)
    name = reader.model.name.get
    assert_equal(name, 'Test')
    state = reader.model.state.get
    assert_true(state.has_flags(Proto::State.good))

    wallet_begin = reader.model.wallet.get_begin
    wallet_currency = reader.model.wallet.currency.get
    assert_equal(wallet_currency, 'USD')
    wallet_amount = reader.model.wallet.amount.get
    assert_equal(wallet_amount, 1000.0)
    reader.model.wallet.get_end(wallet_begin)

    assert_true(reader.model.asset.has_value?)
    asset_begin = reader.model.asset.get_begin
    asset_wallet_begin = reader.model.asset.value.get_begin
    asset_wallet_currency = reader.model.asset.value.currency.get
    assert_equal(asset_wallet_currency, 'EUR')
    asset_wallet_amount = reader.model.asset.value.amount.get
    assert_equal(asset_wallet_amount, 100.0)
    reader.model.asset.value.get_end(asset_wallet_begin)
    reader.model.asset.get_end(asset_begin)

    assert_equal(reader.model.orders.size, 3)

    o1 = reader.model.orders[0]
    order_begin = o1.get_begin
    order_id = o1.id.get
    assert_equal(order_id, 1)
    order_symbol = o1.symbol.get
    assert_equal(order_symbol, 'EURUSD')
    order_side = o1.side.get
    assert_equal(order_side, Proto::OrderSide.buy)
    order_type = o1.type.get
    assert_equal(order_type, Proto::OrderType.market)
    order_price = o1.price.get
    assert_equal(order_price, 1.23456)
    order_volume = o1.volume.get
    assert_equal(order_volume, 1000.0)
    o1.get_end(order_begin)

    o2 = reader.model.orders[1]
    order_begin = o2.get_begin
    order_id = o2.id.get
    assert_equal(order_id, 2)
    order_symbol = o2.symbol.get
    assert_equal(order_symbol, 'EURUSD')
    order_side = o2.side.get
    assert_equal(order_side, Proto::OrderSide.sell)
    order_type = o2.type.get
    assert_equal(order_type, Proto::OrderType.limit)
    order_price = o2.price.get
    assert_equal(order_price, 1.0)
    order_volume = o2.volume.get
    assert_equal(order_volume, 100.0)
    o1.get_end(order_begin)

    o3 = reader.model.orders[2]
    order_begin = o3.get_begin
    order_id = o3.id.get
    assert_equal(order_id, 3)
    order_symbol = o3.symbol.get
    assert_equal(order_symbol, 'EURUSD')
    order_side = o3.side.get
    assert_equal(order_side, Proto::OrderSide.buy)
    order_type = o3.type.get
    assert_equal(order_type, Proto::OrderType.stop)
    order_price = o3.price.get
    assert_equal(order_price, 1.5)
    order_volume = o3.volume.get
    assert_equal(order_volume, 10.0)
    o1.get_end(order_begin)

    reader.model.get_end(account_begin)
  end
end
