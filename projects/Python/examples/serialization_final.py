import fbe
import proto
from proto import proto


def main():
    # Create a new account with some orders
    account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
    account.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
    account.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
    account.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

    # Serialize the account to the FBE stream
    writer = proto.AccountFinalModel(fbe.WriteBuffer())
    writer.serialize(account)
    assert writer.verify()

    # Show the serialized FBE size
    print("FBE size: {}".format(writer.buffer.size))

    # Deserialize the account from the FBE stream
    reader = proto.AccountFinalModel(fbe.ReadBuffer())
    reader.attach_buffer(writer.buffer)
    assert reader.verify()
    reader.deserialize(account)

    # Show account content
    print()
    print(account)


if __name__ == "__main__":
    main()
