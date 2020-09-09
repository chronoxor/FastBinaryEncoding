/*!
    \file create.cpp
    \brief Fast Binary Encoding create & access example
    \author Ivan Shynkarenka
    \date 08.05.2018
    \copyright MIT License
*/

#include "../proto/proto_models.h"

#include <iostream>

int main(int argc, char** argv)
{
    // Create a new account using FBE model
    FBE::proto::AccountModel account;
    size_t model_begin = account.create_begin();
    size_t account_begin = account.model.set_begin();
    account.model.id.set(1);
    account.model.name.set("Test");
    account.model.state.set(proto::State::good);
    size_t wallet_begin = account.model.wallet.set_begin();
    account.model.wallet.currency.set("USD");
    account.model.wallet.amount.set(1000.0);
    account.model.wallet.set_end(wallet_begin);
    account.model.set_end(account_begin);
    account.create_end(model_begin);
    assert(account.verify());

    // Show the serialized FBE size
    std::cout << "FBE size: " << account.buffer().size() << std::endl;

    // Access the account using the FBE model
    FBE::proto::AccountModel access;
    access.attach(account.buffer());
    assert(access.verify());

    int32_t id;
    std::string name;
    proto::State state;
    std::string wallet_currency;
    double wallet_amount;

    account_begin = access.model.get_begin();
    access.model.id.get(id);
    access.model.name.get(name);
    access.model.state.get(state);
    wallet_begin = access.model.wallet.get_begin();
    access.model.wallet.currency.get(wallet_currency);
    access.model.wallet.amount.get(wallet_amount);
    access.model.wallet.get_end(wallet_begin);
    access.model.get_end(account_begin);

    // Show account content
    std::cout << std::endl;
    std::cout << "account.id = " << id << std::endl;
    std::cout << "account.name = " << name << std::endl;
    std::cout << "account.state = " << state << std::endl;
    std::cout << "account.wallet.currency = " << wallet_currency << std::endl;
    std::cout << "account.wallet.amount = " << wallet_amount << std::endl;

    return 0;
}
