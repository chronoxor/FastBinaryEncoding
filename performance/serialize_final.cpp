//
// Created by Ivan Shynkarenka on 09.07.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto_final_models.h"

class FinalSerializationFixture
{
protected:
    FBE::proto::AccountFinalModel writer;
    proto::Account account;

    FinalSerializationFixture()
    {
        // Create a new account with some orders
        account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    }
};

BENCHMARK_FIXTURE(FinalSerializationFixture, "Serialize (Final)")
{
    // Reset FBE stream
    writer.reset();

    // Serialize the account to the FBE stream
    writer.serialize(account);
}

BENCHMARK_MAIN()
