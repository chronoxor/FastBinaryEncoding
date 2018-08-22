//
// Created by Ivan Shynkarenka on 19.05.2018
//

#include "benchmark/cppbenchmark.h"

#include "../proto/proto.h"

class MySender : public FBE::proto::Sender<FBE::WriteBuffer>
{
public:
    size_t size() const noexcept { return _size; }
    size_t log_size() const noexcept { return _log_size; }

protected:
    size_t onSend(const void* data, size_t size) override { _size += size; return size; }
    void onSendLog(const std::string& message) const override { _log_size += message.size(); }

private:
    size_t _size;
    mutable size_t _log_size;
};

class SenderFixture
{
protected:
    MySender sender;
    proto::Account account;

    SenderFixture()
    {
        // Create a new account with some orders
        account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std_make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
        account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
        account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
        account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    }
};

BENCHMARK_FIXTURE(SenderFixture, "Send")
{
    // Serialize and send the account
    sender.send(account);
}

/*
BENCHMARK_FIXTURE(SenderFixture, "Send with logs")
{
    // Enable logging
    sender.logging(true);

    // Serialize and send the account
    sender.send(account);
}
*/

BENCHMARK_MAIN()
