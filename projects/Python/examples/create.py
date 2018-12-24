import fbe
import proto
from proto import proto


def main():
    # Create a new account using FBE model
    account = proto.AccountModel(fbe.WriteBuffer())
    model_begin = account.create_begin()
    account_begin = account.model.set_begin()
    account.model.id.set(1)
    account.model.name.set("Test")
    account.model.state.set(proto.State.good)
    wallet_begin = account.model.wallet.set_begin()
    account.model.wallet.currency.set("USD")
    account.model.wallet.amount.set(1000.0)
    account.model.wallet.set_end(wallet_begin)
    account.model.set_end(account_begin)
    account.create_end(model_begin)
    assert account.verify()

    # Show the serialized FBE size
    print("FBE size: {}".format(account.buffer.size))

    # Access the account using the FBE model
    access = proto.AccountModel(fbe.ReadBuffer())
    access.attach_buffer(account.buffer)
    assert access.verify()

    account_begin = access.model.get_begin()
    id = access.model.id.get()
    name = access.model.name.get()
    state = access.model.state.get()
    wallet_begin = access.model.wallet.get_begin()
    wallet_currency = access.model.wallet.currency.get()
    wallet_amount = access.model.wallet.amount.get()
    access.model.wallet.get_end(wallet_begin)
    access.model.get_end(account_begin)

    # Show account content
    print()
    print("account.id = {}".format(id))
    print("account.name = {}".format(name))
    print("account.state = {}".format(state))
    print("account.wallet.currency = {}".format(wallet_currency))
    print("account.wallet.amount = {}".format(wallet_amount))


if __name__ == "__main__":
    main()
