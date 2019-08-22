import proto
from proto import proto


class MySender(proto.Sender):

    def on_send(self, buffer, offset, size):
        # Send nothing...
        return 0

    def on_send_log(self, message):
        print("onSend: {}".format(message))


class MyReceiver(proto.Receiver):

    def on_receive_ordermessage(self, value):
        pass

    def on_receive_balancemessage(self, value):
        pass

    def on_receive_accountmessage(self, value):
        pass

    def on_receive_log(self, message):
        print("onReceive: {}".format(message))


def main():
    sender = MySender()

    # Enable logging
    sender.logging = True

    # Create and send a new order
    order = proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0)
    sender.send(proto.OrderMessage(order))

    # Create and send a new balance wallet
    balance = proto.Balance("USD", 1000.0)
    sender.send(proto.BalanceMessage(balance))

    # Create and send a new account with some orders
    account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
    account.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
    account.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
    account.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))
    sender.send(proto.AccountMessage(account))

    receiver = MyReceiver()

    # Enable logging
    receiver.logging = True

    # Receive all data from the sender
    receiver.receive(sender.buffer)


if __name__ == "__main__":
    main()
