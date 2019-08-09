import proto
from proto import proto
from unittest import TestCase


class MySender(proto.Sender):

    def on_send(self, buffer, offset, size):
        # Send nothing...
        return 0


class MyReceiver(proto.Receiver):

    def __init__(self):
        super().__init__()
        self._order = False
        self._balance = False
        self._account = False

    def check(self):
        return self._order and self._balance and self._account

    def on_receive_ordermessage(self, value):
        self._order = True

    def on_receive_balancemessage(self, value):
        self._balance = True

    def on_receive_accountmessage(self, value):
        self._account = True


class TestSendReceive(TestCase):

    @staticmethod
    def send_and_receive(index1, index2):
        sender = MySender()

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

        # Receive data from the sender
        index1 %= sender.buffer.size
        index2 %= sender.buffer.size
        index2 = max(index1, index2)
        receiver.receive(sender.buffer, 0, index1)
        receiver.receive(sender.buffer, index1, index2 - index1)
        receiver.receive(sender.buffer, index2, sender.buffer.size - index2)
        return receiver.check()

    def test_send_and_receive(self):
        for i in range(100):
            for j in range(100):
                self.assertTrue(self.send_and_receive(i, j))
