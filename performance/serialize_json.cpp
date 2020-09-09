//
// Created by Ivan Shynkarenka on 20.06.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto_json.h"

class SerializationJsonFixture
{
protected:
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer;
    proto::Account account;

    SerializationJsonFixture() : writer(buffer)
    {
        // Create a new account with some orders
        account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    }
};

BENCHMARK_FIXTURE(SerializationJsonFixture, "Serialize (JSON)")
{
    // Reset JSON stream
    buffer.Clear();
    writer.Reset(buffer);

    // Serialize the account to the JSON stream
    FBE::JSON::to_json(writer, account);
}

BENCHMARK_MAIN()
