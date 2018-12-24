import proto
from proto import proto
from unittest import TestCase


class TestClone(TestCase):

    def test_clone(self):
        # Create a new account with some orders
        account1 = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
        account1.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account1.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account1.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        # Clone the account
        account2 = account1.clone()

        # Clear the source account
        # noinspection PyUnusedLocal
        account1 = proto.Account()

        self.assertEqual(account2.id, 1)
        self.assertEqual(account2.name, "Test")
        self.assertTrue(account2.state.has_flags(proto.State.good))
        self.assertEqual(account2.wallet.currency, "USD")
        self.assertEqual(account2.wallet.amount, 1000.0)
        self.assertNotEqual(account2.asset, None)
        self.assertEqual(account2.asset.currency, "EUR")
        self.assertEqual(account2.asset.amount, 100.0)
        self.assertEqual(len(account2.orders), 3)
        self.assertEqual(account2.orders[0].id, 1)
        self.assertEqual(account2.orders[0].symbol, "EURUSD")
        self.assertEqual(account2.orders[0].side, proto.OrderSide.buy)
        self.assertEqual(account2.orders[0].type, proto.OrderType.market)
        self.assertEqual(account2.orders[0].price, 1.23456)
        self.assertEqual(account2.orders[0].volume, 1000.0)
        self.assertEqual(account2.orders[1].id, 2)
        self.assertEqual(account2.orders[1].symbol, "EURUSD")
        self.assertEqual(account2.orders[1].side, proto.OrderSide.sell)
        self.assertEqual(account2.orders[1].type, proto.OrderType.limit)
        self.assertEqual(account2.orders[1].price, 1.0)
        self.assertEqual(account2.orders[1].volume, 100.0)
        self.assertEqual(account2.orders[2].id, 3)
        self.assertEqual(account2.orders[2].symbol, "EURUSD")
        self.assertEqual(account2.orders[2].side, proto.OrderSide.buy)
        self.assertEqual(account2.orders[2].type, proto.OrderType.stop)
        self.assertEqual(account2.orders[2].price, 1.5)
        self.assertEqual(account2.orders[2].volume, 10.0)
