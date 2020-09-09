/*!
    \file serialization_json.cpp
    \brief Fast Binary Encoding JSON serialization example
    \author Ivan Shynkarenka
    \date 20.06.2018
    \copyright MIT License
*/

#include "../proto/proto_json.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account with some orders
    proto::Account account = { 1, "Test", proto::State::good, { "USD", 1000.0 }, std::make_optional<proto::Balance>({ "EUR", 100.0 }), {} };
    account.orders.emplace_back(1, "EURUSD", proto::OrderSide::buy, proto::OrderType::market, 1.23456, 1000.0);
    account.orders.emplace_back(2, "EURUSD", proto::OrderSide::sell, proto::OrderType::limit, 1.0, 100.0);
    account.orders.emplace_back(3, "EURUSD", proto::OrderSide::buy, proto::OrderType::stop, 1.5, 10.0);

    // Serialize the account to the JSON stream
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
    FBE::JSON::to_json(writer, account);

    // Show the serialized JSON and its size
    std::cout << "JSON: " << buffer.GetString() << std::endl;
    std::cout << "JSON size: " << buffer.GetSize() << std::endl;

    // Parse the JSON document
    rapidjson::Document json;
    json.Parse(buffer.GetString());

    // Deserialize the account from the JSON stream
    FBE::JSON::from_json(json, account);

    // Show account content
    std::cout << std::endl;
    std::cout << account;

    return 0;
}
