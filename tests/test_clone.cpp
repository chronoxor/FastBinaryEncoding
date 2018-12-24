//
// Created by Ivan Shynkarenka on 01.07.2018
//

#include "test.h"

#include "../proto/proto.h"

TEST_CASE("Clone structs", "[FBE]")
{
    // Create a new account with some orders
    proto::Account account1 = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account1.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account1.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account1.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Clone the account
    proto::Account account2 = account1;

    // Clear the source account
    account1 = proto::Account();

    REQUIRE(account2.id == 1);
    REQUIRE(account2.name == "Test");
    REQUIRE((account2.state | proto::State::good));
    REQUIRE(std::string(account2.wallet.currency) == "USD");
    REQUIRE(account2.wallet.amount == 1000.0);
    REQUIRE(account2.asset.has_value());
    REQUIRE(std::string(account2.asset.value().currency) == "EUR");
    REQUIRE(account2.asset.value().amount == 100.0);
    REQUIRE(account2.orders.size() == 3);
    REQUIRE(account2.orders[0].id == 1);
    REQUIRE(std::string(account2.orders[0].symbol) == "EURUSD");
    REQUIRE(account2.orders[0].side == proto::OrderSide::buy);
    REQUIRE(account2.orders[0].type == proto::OrderType::market);
    REQUIRE(account2.orders[0].price == 1.23456);
    REQUIRE(account2.orders[0].volume == 1000.0);
    REQUIRE(account2.orders[1].id == 2);
    REQUIRE(std::string(account2.orders[1].symbol) == "EURUSD");
    REQUIRE(account2.orders[1].side == proto::OrderSide::sell);
    REQUIRE(account2.orders[1].type == proto::OrderType::limit);
    REQUIRE(account2.orders[1].price == 1.0);
    REQUIRE(account2.orders[1].volume == 100.0);
    REQUIRE(account2.orders[2].id == 3);
    REQUIRE(std::string(account2.orders[2].symbol) == "EURUSD");
    REQUIRE(account2.orders[2].side == proto::OrderSide::buy);
    REQUIRE(account2.orders[2].type == proto::OrderType::stop);
    REQUIRE(account2.orders[2].price == 1.5);
    REQUIRE(account2.orders[2].volume == 10.0);
}
