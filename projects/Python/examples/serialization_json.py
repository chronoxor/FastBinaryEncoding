import proto
from proto import proto


def main():
    # Create a new account with some orders
    account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
    account.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
    account.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
    account.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

    # Serialize the account to the JSON string
    json = account.to_json()

    # Show the serialized JSON and its size
    print("JSON: {}".format(json))
    print("JSON size: {}".format(len(json)))

    # Deserialize the account from the JSON string
    account = proto.Account.from_json(json)

    # Show account content
    print()
    print(account)


if __name__ == "__main__":
    main()
