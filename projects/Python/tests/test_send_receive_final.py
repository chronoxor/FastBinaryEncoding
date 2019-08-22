import proto
from proto import proto
from proto import protoex
from unittest import TestCase


class MyFinalSender(protoex.FinalSender):

    def on_send(self, buffer, offset, size):
        # Send nothing...
        return 0


class MyFinalReceiver(protoex.FinalReceiver):

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


class TestSendReceiveFinal(TestCase):

    @staticmethod
    def send_and_receive_final(index1, index2):
        sender = MyFinalSender()

        # Create and send a new order
        order = protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0)
        sender.send(protoex.OrderMessage(order))

        # Create and send a new balance wallet
        balance = protoex.Balance(proto.Balance("USD", 1000.0), 100.0)
        sender.send(protoex.BalanceMessage(balance))

        # Create and send a new account with some orders
        account = protoex.Account(1, "Test", protoex.StateEx.good, protoex.Balance(proto.Balance("USD", 1000.0), 100.0), protoex.Balance(proto.Balance("EUR", 100.0), 10.0))
        account.orders.append(protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
        account.orders.append(protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.0, 0.0))
        account.orders.append(protoex.Order(3, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.stop, 1.5, 10.0, 0.0, 0.0))
        sender.send(protoex.AccountMessage(account))

        receiver = MyFinalReceiver()

        # Receive data from the sender
        index1 %= sender.buffer.size
        index2 %= sender.buffer.size
        index2 = max(index1, index2)
        receiver.receive(sender.buffer, 0, index1)
        receiver.receive(sender.buffer, index1, index2 - index1)
        receiver.receive(sender.buffer, index2, sender.buffer.size - index2)
        return receiver.check()

    def test_send_and_receive_final(self):
        for i in range(100):
            for j in range(100):
                self.assertTrue(self.send_and_receive_final(i, j))
