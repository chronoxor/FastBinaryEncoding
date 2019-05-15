/*!
    \file serialization.cpp
    \brief Fast Binary Encoding serialization example
    \author Ivan Shynkarenka
    \date 18.04.2018
    \copyright MIT License
*/

#include "../proto/proto_models.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the FBE stream
    FBE::proto::AccountModel<FBE::WriteBuffer> writer;
    writer.serialize(account);
    assert(writer.verify());

    // Show the serialized FBE size
    std::cout << "FBE size: " << writer.buffer().size() << std::endl;

    // Deserialize the account from the FBE stream
    FBE::proto::AccountModel<FBE::ReadBuffer> reader;
    reader.attach(writer.buffer());
    assert(reader.verify());
    reader.deserialize(account);

    // Show account content
    std::cout << std::endl;
    std::cout << account;

    return 0;
}
