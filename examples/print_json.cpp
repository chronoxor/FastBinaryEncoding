/*!
    \file print_json.cpp
    \brief Fast Binary Encoding print JSON example
    \author Ivan Shynkarenka
    \date 16.08.2018
    \copyright MIT License
*/

#include "../proto/proto.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);

    writer.Reset(buffer);
    FBE::JSON::to_json(writer, test::StructSimple());
    std::cout << buffer.GetString() << std::endl << std::endl;

    return 0;
}
