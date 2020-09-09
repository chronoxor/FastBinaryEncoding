//
// Created by Ivan Shynkarenka on 04.05.2018
//

#include "test.h"

#include "../proto/proto_models.h"
#include "../proto/protoex_models.h"

TEST_CASE("Extending: old -> new", "[FBE]")
{
    // Create a new account with some orders
    proto::Account account1;
    account1.id = 1;
    account1.name = "Test";
    account1.state = proto::State::good;
    account1.wallet.currency = "USD";
    account1.wallet.amount = 1000.0;
    account1.asset.emplace(proto::Balance{ "EUR", 100.0 });
    account1.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account1.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account1.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the FBE stream
    FBE::proto::AccountModel writer;
    REQUIRE(writer.model.fbe_offset() == 4);
    size_t serialized = writer.serialize(account1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);
    REQUIRE(writer.model.fbe_offset() == (4 + writer.buffer().size()));

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 252);

    // Deserialize the account from the FBE stream
    protoex::Account account2;
    FBE::protoex::AccountModel reader;
    REQUIRE(reader.model.fbe_offset() == 4);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(account2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);
    REQUIRE(reader.model.fbe_offset() == (4 + reader.buffer().size()));

    REQUIRE(account2.id == 1);
    REQUIRE(account2.name == "Test");
    REQUIRE(account2.state == protoex::StateEx::good);
    REQUIRE(std::string(account2.wallet.currency) == "USD");
    REQUIRE(account2.wallet.amount == 1000.0);
    REQUIRE(account2.wallet.locked == 0.0);
    REQUIRE(account2.asset.has_value());
    REQUIRE(std::string(account2.asset.value().currency) == "EUR");
    REQUIRE(account2.asset.value().amount == 100.0);
    REQUIRE(account2.asset.value().locked == 0.0);
    REQUIRE(account2.orders.size() == 3);
    REQUIRE(account2.orders[0].id == 1);
    REQUIRE(std::string(account2.orders[0].symbol) == "EURUSD");
    REQUIRE(account2.orders[0].side == protoex::OrderSide::buy);
    REQUIRE(account2.orders[0].type == protoex::OrderType::market);
    REQUIRE(account2.orders[0].price == 1.23456);
    REQUIRE(account2.orders[0].volume == 1000.0);
    REQUIRE(account2.orders[0].tp == 10.0);
    REQUIRE(account2.orders[0].sl == -10.0);
    REQUIRE(account2.orders[1].id == 2);
    REQUIRE(std::string(account2.orders[1].symbol) == "EURUSD");
    REQUIRE(account2.orders[1].side == protoex::OrderSide::sell);
    REQUIRE(account2.orders[1].type == protoex::OrderType::limit);
    REQUIRE(account2.orders[1].price == 1.0);
    REQUIRE(account2.orders[1].volume == 100.0);
    REQUIRE(account2.orders[1].tp == 10.0);
    REQUIRE(account2.orders[1].sl == -10.0);
    REQUIRE(account2.orders[2].id == 3);
    REQUIRE(std::string(account2.orders[2].symbol) == "EURUSD");
    REQUIRE(account2.orders[2].side == protoex::OrderSide::buy);
    REQUIRE(account2.orders[2].type == protoex::OrderType::stop);
    REQUIRE(account2.orders[2].price == 1.5);
    REQUIRE(account2.orders[2].volume == 10.0);
    REQUIRE(account2.orders[2].tp == 10.0);
    REQUIRE(account2.orders[2].sl == -10.0);
}

TEST_CASE("Extending: new -> old", "[FBE]")
{
    // Create a new account with some orders
    protoex::Account account1;
    account1.id = 1;
    account1.name = "Test";
    account1.state = protoex::StateEx::good | protoex::StateEx::happy;
    account1.wallet.currency = "USD";
    account1.wallet.amount = 1000.0;
    account1.wallet.locked = 123.456;
    account1.asset = protoex::Balance();
    account1.asset.value().currency = "EUR";
    account1.asset.value().amount = 100.0;
    account1.asset.value().locked = 12.34;
    account1.orders.emplace_back(1, "EURUSD", protoex::OrderSide::buy, protoex::OrderType::market, 1.23456, 1000.0, 0, 0);
    account1.orders.emplace_back(2, "EURUSD", protoex::OrderSide::sell, protoex::OrderType::limit, 1.0, 100.0, 0.1, -0.1);
    account1.orders.emplace_back(3, "EURUSD", protoex::OrderSide::tell, protoex::OrderType::stoplimit, 1.5, 10.0, 1.1, -1.1);

    // Serialize the account to the FBE stream
    FBE::protoex::AccountModel writer;
    REQUIRE(writer.model.fbe_offset() == 4);
    size_t serialized = writer.serialize(account1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);
    REQUIRE(writer.model.fbe_offset() == (4 + writer.buffer().size()));

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 316);

    // Deserialize the account from the FBE stream
    proto::Account account2;
    FBE::proto::AccountModel reader;
    REQUIRE(reader.model.fbe_offset() == 4);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(account2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);
    REQUIRE(reader.model.fbe_offset() == (4 + reader.buffer().size()));

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
    REQUIRE(account2.orders[2].side != proto::OrderSide::buy);
    REQUIRE(account2.orders[2].type != proto::OrderType::market);
    REQUIRE(account2.orders[2].price == 1.5);
    REQUIRE(account2.orders[2].volume == 10.0);
}
