//
// Created by Ivan Shynkarenka on 07.05.2018
//

#include "test.h"

#include "../proto/proto_models.h"
#include "../proto/test_models.h"

TEST_CASE("Create & access", "[FBE]")
{
    // Create a new account using FBE model into the FBE stream
    FBE::proto::AccountModel writer;
    REQUIRE(writer.model.fbe_offset() == 4);
    size_t model_begin = writer.create_begin();
    size_t account_begin = writer.model.set_begin();
    writer.model.id.set(1);
    writer.model.name.set(std::string("Test"));
    writer.model.state.set(proto::State::good);
    size_t wallet_begin = writer.model.wallet.set_begin();
    writer.model.wallet.currency.set(std::string("USD"));
    writer.model.wallet.amount.set(1000.0);
    writer.model.wallet.set_end(wallet_begin);
    size_t asset_begin = writer.model.asset.set_begin(true);
    size_t asset_wallet_begin = writer.model.asset.value.set_begin();
    writer.model.asset.value.currency.set(std::string("EUR"));
    writer.model.asset.value.amount.set(100.0);
    writer.model.asset.set_end(asset_begin);
    writer.model.asset.value.set_end(asset_wallet_begin);
    auto order = writer.model.orders.resize(3);
    size_t order_begin = order.set_begin();
    order.id.set(1);
    order.symbol.set(std::string("EURUSD"));
    order.side.set(proto::OrderSide::buy);
    order.type.set(proto::OrderType::market);
    order.price.set(1.23456);
    order.volume.set(1000.0);
    order.set_end(order_begin);
    order.fbe_shift(order.fbe_size());
    order_begin = order.set_begin();
    order.id.set(2);
    order.symbol.set(std::string("EURUSD"));
    order.side.set(proto::OrderSide::sell);
    order.type.set(proto::OrderType::limit);
    order.price.set(1.0);
    order.volume.set(100.0);
    order.set_end(order_begin);
    order.fbe_shift(order.fbe_size());
    order_begin = order.set_begin();
    order.id.set(3);
    order.symbol.set(std::string("EURUSD"));
    order.side.set(proto::OrderSide::buy);
    order.type.set(proto::OrderType::stop);
    order.price.set(1.5);
    order.volume.set(10.0);
    order.set_end(order_begin);
    order.fbe_shift(order.fbe_size());
    writer.model.set_end(account_begin);
    size_t serialized = writer.create_end(model_begin);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);
    REQUIRE(writer.model.fbe_offset() == (4 + writer.buffer().size()));

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 252);

    // Access the account model in the FBE stream
    FBE::proto::AccountModel reader;
    REQUIRE(reader.model.fbe_offset() == 4);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());

    int32_t id;
    std::string name;
    proto::State state;
    std::string wallet_currency;
    double wallet_amount;
    std::string asset_wallet_currency;
    double asset_wallet_amount;

    account_begin = reader.model.get_begin();
    reader.model.id.get(id);
    REQUIRE(id == 1);
    reader.model.name.get(name);
    REQUIRE(name == "Test");
    reader.model.state.get(state);
    REQUIRE((state | proto::State::good));

    wallet_begin = reader.model.wallet.get_begin();
    reader.model.wallet.currency.get(wallet_currency);
    REQUIRE(wallet_currency == "USD");
    reader.model.wallet.amount.get(wallet_amount);
    REQUIRE(wallet_amount == 1000.0);
    reader.model.wallet.get_end(wallet_begin);

    REQUIRE(reader.model.asset.has_value());
    asset_begin = reader.model.asset.get_begin();
    asset_wallet_begin = reader.model.asset.value.get_begin();
    reader.model.asset.value.currency.get(asset_wallet_currency);
    REQUIRE(asset_wallet_currency == "EUR");
    reader.model.asset.value.amount.get(asset_wallet_amount);
    REQUIRE(asset_wallet_amount == 100.0);
    reader.model.asset.value.get_end(asset_wallet_begin);
    reader.model.asset.get_end(asset_begin);

    REQUIRE(reader.model.orders.size() == 3);

    int order_id;
    std::string order_symbol;
    proto::OrderSide order_side;
    proto::OrderType order_type;
    double order_price;
    double order_volume;

    auto o1 = reader.model.orders[0];
    order_begin = o1.get_begin();
    o1.id.get(order_id);
    REQUIRE(order_id == 1);
    o1.symbol.get(order_symbol);
    REQUIRE(order_symbol == "EURUSD");
    o1.side.get(order_side);
    REQUIRE(order_side == proto::OrderSide::buy);
    o1.type.get(order_type);
    REQUIRE(order_type == proto::OrderType::market);
    o1.price.get(order_price);
    REQUIRE(order_price == 1.23456);
    o1.volume.get(order_volume);
    REQUIRE(order_volume == 1000.0);
    o1.get_end(order_begin);

    auto o2 = reader.model.orders[1];
    order_begin = o2.get_begin();
    o2.id.get(order_id);
    REQUIRE(order_id == 2);
    o2.symbol.get(order_symbol);
    REQUIRE(order_symbol == "EURUSD");
    o2.side.get(order_side);
    REQUIRE(order_side == proto::OrderSide::sell);
    o2.type.get(order_type);
    REQUIRE(order_type == proto::OrderType::limit);
    o2.price.get(order_price);
    REQUIRE(order_price == 1.0);
    o2.volume.get(order_volume);
    REQUIRE(order_volume == 100.0);
    o1.get_end(order_begin);

    auto o3 = reader.model.orders[2];
    order_begin = o3.get_begin();
    o3.id.get(order_id);
    REQUIRE(order_id == 3);
    o3.symbol.get(order_symbol);
    REQUIRE(order_symbol == "EURUSD");
    o3.side.get(order_side);
    REQUIRE(order_side == proto::OrderSide::buy);
    o3.type.get(order_type);
    REQUIRE(order_type == proto::OrderType::stop);
    o3.price.get(order_price);
    REQUIRE(order_price == 1.5);
    o3.volume.get(order_volume);
    REQUIRE(order_volume == 10.0);
    o1.get_end(order_begin);

    reader.model.get_end(account_begin);
}
