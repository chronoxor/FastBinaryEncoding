//
// Created by Ivan Shynkarenka on 19.05.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto_json.h"

class DeserializationJsonFixture
{
protected:
    rapidjson::Document json;
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer;
    proto::Account deserialized;

    DeserializationJsonFixture() : writer(buffer)
    {
        // Create a new account with some orders
        proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

        // Serialize the account to the JSON stream
        FBE::JSON::to_json(writer, account);

        // Parse the JSON document
        json.Parse(buffer.GetString());
    }
};

BENCHMARK_FIXTURE(DeserializationJsonFixture, "Deserialize (JSON)")
{
    // Deserialize the account from the JSON stream
    FBE::JSON::from_json(json, deserialized);
}

BENCHMARK_MAIN()
