import fbe
import proto
from proto import proto
from proto import protoex
from unittest import TestCase


class TestExtending(TestCase):

    def test_extending_old_new(self):
        # Create a new account with some orders
        account1 = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
        account1.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        account1.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        account1.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        # Serialize the account to the FBE stream
        writer = proto.AccountModel(fbe.WriteBuffer())
        self.assertEqual(writer.model.fbe_offset, 4)
        serialized = writer.serialize(account1)
        self.assertEqual(serialized, writer.buffer.size)
        self.assertTrue(writer.verify())
        writer.next(serialized)
        self.assertEqual(writer.model.fbe_offset, (4 + writer.buffer.size))

        # Check the serialized FBE size
        self.assertEqual(writer.buffer.size, 252)

        # Deserialize the account from the FBE stream
        account2 = protoex.Account()
        reader = protoex.AccountModel(fbe.ReadBuffer())
        self.assertEqual(reader.model.fbe_offset, 4)
        reader.attach_buffer(writer.buffer)
        self.assertTrue(reader.verify())
        (account2, deserialized) = reader.deserialize(account2)
        self.assertEqual(deserialized, reader.buffer.size)
        reader.next(deserialized)
        self.assertEqual(reader.model.fbe_offset, (4 + reader.buffer.size))

        self.assertEqual(account2.id, 1)
        self.assertEqual(account2.name, "Test")
        self.assertTrue(account2.state.has_flags(protoex.StateEx.good))
        self.assertEqual(account2.wallet.currency, "USD")
        self.assertEqual(account2.wallet.amount, 1000.0)
        self.assertEqual(account2.wallet.locked, 0.0)
        self.assertNotEqual(account2.asset, None)
        self.assertEqual(account2.asset.currency, "EUR")
        self.assertEqual(account2.asset.amount, 100.0)
        self.assertEqual(account2.asset.locked, 0.0)
        self.assertEqual(len(account2.orders), 3)
        self.assertEqual(account2.orders[0].id, 1)
        self.assertEqual(account2.orders[0].symbol, "EURUSD")
        self.assertEqual(account2.orders[0].side, protoex.OrderSide.buy)
        self.assertEqual(account2.orders[0].type, protoex.OrderType.market)
        self.assertEqual(account2.orders[0].price, 1.23456)
        self.assertEqual(account2.orders[0].volume, 1000.0)
        self.assertEqual(account2.orders[0].tp, 10.0)
        self.assertEqual(account2.orders[0].sl, -10.0)
        self.assertEqual(account2.orders[1].id, 2)
        self.assertEqual(account2.orders[1].symbol, "EURUSD")
        self.assertEqual(account2.orders[1].side, protoex.OrderSide.sell)
        self.assertEqual(account2.orders[1].type, protoex.OrderType.limit)
        self.assertEqual(account2.orders[1].price, 1.0)
        self.assertEqual(account2.orders[1].volume, 100.0)
        self.assertEqual(account2.orders[1].tp, 10.0)
        self.assertEqual(account2.orders[1].sl, -10.0)
        self.assertEqual(account2.orders[2].id, 3)
        self.assertEqual(account2.orders[2].symbol, "EURUSD")
        self.assertEqual(account2.orders[2].side, protoex.OrderSide.buy)
        self.assertEqual(account2.orders[2].type, protoex.OrderType.stop)
        self.assertEqual(account2.orders[2].price, 1.5)
        self.assertEqual(account2.orders[2].volume, 10.0)
        self.assertEqual(account2.orders[2].tp, 10.0)
        self.assertEqual(account2.orders[2].sl, -10.0)

    def test_extending_new_old(self):
        # Create a new account with some orders
        account1 = protoex.Account(1, "Test", protoex.StateEx.good | protoex.StateEx.happy, protoex.Balance(proto.Balance("USD", 1000.0), 123.456), protoex.Balance(proto.Balance("EUR", 100.0), 12.34))
        account1.orders.append(protoex.Order(1, "EURUSD", protoex.OrderSide.buy, protoex.OrderType.market, 1.23456, 1000.0, 0.0, 0.0))
        account1.orders.append(protoex.Order(2, "EURUSD", protoex.OrderSide.sell, protoex.OrderType.limit, 1.0, 100.0, 0.1, -0.1))
        account1.orders.append(protoex.Order(3, "EURUSD", protoex.OrderSide.tell, protoex.OrderType.stoplimit, 1.5, 10.0, 1.1, -1.1))

        # Serialize the account to the FBE stream
        writer = protoex.AccountModel(fbe.WriteBuffer())
        self.assertEqual(writer.model.fbe_offset, 4)
        serialized = writer.serialize(account1)
        self.assertEqual(serialized, writer.buffer.size)
        self.assertTrue(writer.verify())
        writer.next(serialized)
        self.assertEqual(writer.model.fbe_offset, (4 + writer.buffer.size))

        # Check the serialized FBE size
        self.assertEqual(writer.buffer.size, 316)

        # Deserialize the account from the FBE stream
        account2 = proto.Account()
        reader = proto.AccountModel(fbe.ReadBuffer())
        self.assertEqual(reader.model.fbe_offset, 4)
        reader.attach_buffer(writer.buffer)
        self.assertTrue(reader.verify())
        (account2, deserialized) = reader.deserialize(account2)
        self.assertEqual(deserialized, reader.buffer.size)
        reader.next(deserialized)
        self.assertEqual(reader.model.fbe_offset, (4 + reader.buffer.size))

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
        self.assertNotEqual(account2.orders[2].side, proto.OrderSide.buy)
        self.assertNotEqual(account2.orders[2].type, proto.OrderType.market)
        self.assertEqual(account2.orders[2].price, 1.5)
        self.assertEqual(account2.orders[2].volume, 10.0)
