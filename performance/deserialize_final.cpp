//
// Created by Ivan Shynkarenka on 09.07.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto_final_models.h"

class FinalDeserializationFixture
{
protected:
    FBE::proto::AccountFinalModel writer;
    FBE::proto::AccountFinalModel reader;
    proto::Account deserialized;

    FinalDeserializationFixture()
    {
        // Create a new account with some orders
        proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

        // Serialize the account to the FBE stream
        writer.serialize(account);
        assert(writer.verify() && "Model is broken!");
        reader.attach(writer.buffer());
        assert(reader.verify() && "Model is broken!");
    }
};

BENCHMARK_FIXTURE(FinalDeserializationFixture, "Deserialize (Final)")
{
    // Deserialize the account from the FBE stream
    reader.deserialize(deserialized);
}

BENCHMARK_MAIN()
