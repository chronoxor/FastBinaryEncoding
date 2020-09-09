/*!
    \file send_receive.cpp
    \brief Fast Binary Encoding send & receive example
    \author Ivan Shynkarenka
    \date 14.05.2018
    \copyright MIT License
*/

#include "../proto/proto_protocol.h"

#include <iostream>

class MySender : public FBE::proto::Sender
{
protected:
    size_t onSend(const void* data, size_t size) override
    {
        // Send nothing...
        return 0;
    }

    void onSendLog(const std::string& message) const override
    {
        std::cout << "onSend: " << message << std::endl;
    }
};

class MyReceiver : public FBE::proto::Receiver
{
protected:
    void onReceive(const proto::OrderMessage& value) override {}
    void onReceive(const proto::BalanceMessage& value) override {}
    void onReceive(const proto::AccountMessage& value) override {}

    void onReceiveLog(const std::string& message) const override
    {
        std::cout << "onReceive: " << message << std::endl;
    }
};

int main(int argc, char** argv)
{
    MySender sender;

    // Enable logging
    sender.logging(true);

    // Create and send a new order
    proto::OrderMessage order({ proto::Order({ 1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0 }) });
    sender.send(order);

    // Create and send a new balance wallet
    proto::BalanceMessage balance({ proto::Balance({ "USD", 1000.0 }) });
    sender.send(balance);

    // Create and send a new account with some orders
    proto::AccountMessage account({ proto::Account({ 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} }) });
    account.body.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.body.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.body.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);
    sender.send(account);

    MyReceiver receiver;

    // Enable logging
    receiver.logging(true);

    // Receive all data from the sender
    receiver.receive(sender.buffer().data(), sender.buffer().size());

    return 0;
}
