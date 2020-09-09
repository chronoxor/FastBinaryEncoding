//
// Created by Ivan Shynkarenka on 19.05.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto_models.h"

class VerifyFixture
{
protected:
    FBE::proto::AccountModel model;

    VerifyFixture()
    {
        // Create a new account with some orders
        proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

        // Serialize the account to the FBE stream
        model.serialize(account);
    }
};

BENCHMARK_FIXTURE(VerifyFixture, "Verify")
{
    // Verify the account
    model.verify();
}

BENCHMARK_MAIN()
