//
// Created by Ivan Shynkarenka on 19.05.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto.h"

class SerializationFixture
{
protected:
    FBE::proto::AccountModel<FBE::WriteBuffer> writer;
    proto::Account account;

    SerializationFixture()
    {
        // Create a new account with some orders
        account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, stdmakeoptional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    }
};

BENCHMARK_FIXTURE(SerializationFixture, "Serialize")
{
    // Reset FBE stream
    writer.reset();

    // Serialize the account to the FBE stream
    writer.serialize(account);
}

BENCHMARK_MAIN()
