//
// Created by Ivan Shynkarenka on 09.07.2018
//

#include "test.h"

#include "../proto/protoex_protocol.h"
#include "../proto/test_protocol.h"

class MyFinalSender : public FBE::protoex::FinalSender<FBE::WriteBuffer>
{
protected:
    size_t onSend(const void* data, size_t size) override
    {
        // Send nothing...
        return 0;
    }
};

class MyFinalReceiver : public FBE::protoex::FinalReceiver<FBE::WriteBuffer>
{
public:
    MyFinalReceiver() : _order(false), _balance(false), _account(false) {}

    bool check() const { return _order && _balance && _account; }

protected:
    void onReceive(const protoex::Order& value) override { _order = true; }
    void onReceive(const protoex::Balance& value) override { _balance = true; }
    void onReceive(const protoex::Account& value) override { _account = true; }

private:
    bool _order;
    bool _balance;
    bool _account;
};

bool SendAndReceiveFinal(size_t index1, size_t index2)
{
    MyFinalSender sender;

    // Create and send a new order
    protoex::Order order = { 1, "EURUSD", protoex::OrderSide::buy, protoex::OrderType::market, 1.23456, 1000.0, 0.0, 0.0 };
    sender.send(order);

    // Create and send a new balance wallet
    protoex::Balance balance = { proto::Balance("USD", 1000.0), 100.0 };
    sender.send(balance);

    // Create and send a new account with some orders
    protoex::Account account = { 1, "Test", protoex::StateEx::good, { proto::Balance("USD", 1000.0), 100.0 }, std::make_optional<protoex::Balance>({ proto::Balance("EUR", 100.0), 10.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", protoex::OrderSide::buy, protoex::OrderType::market, 1.23456, 1000.0, 0.0, 0.0);
    account.orders.emplace_back(2, "EURUSD", protoex::OrderSide::sell, protoex::OrderType::limit, 1.0, 100.0, 0.0, 0.0);
    account.orders.emplace_back(3, "EURUSD", protoex::OrderSide::buy, protoex::OrderType::stop, 1.5, 10.0, 0.0, 0.0);
    sender.send(account);

    MyFinalReceiver receiver;

    // Receive data from the sender
    index1 %= sender.buffer().size();
    index2 %= sender.buffer().size();
    index2 = std::max(index1, index2);
    receiver.receive(sender.buffer().data(), index1);
    receiver.receive(sender.buffer().data() + index1, index2 - index1);
    receiver.receive(sender.buffer().data() + index2, sender.buffer().size() - index2);
    return receiver.check();
}

TEST_CASE("Send & Receive (Final)", "[FBE]")
{
    for (size_t i = 0; i < 1000; ++i)
        for (size_t j = i; j < 1000; ++j)
            REQUIRE(SendAndReceiveFinal(i, j));
}
