import fbe
import proto
import timeit
from proto import proto


class BenchmarkSerializationFinal(object):

    def __init__(self):
        # Create a new account with some orders
        self.account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
        self.account.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        self.account.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        self.account.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        # Serialize the account to the FBE stream
        self.writer = proto.AccountFinalModel(fbe.WriteBuffer())
        self.writer.serialize(self.account)
        assert self.writer.verify()

        # Deserialize the account from the FBE stream
        self.reader = proto.AccountFinalModel(fbe.ReadBuffer())
        self.reader.attach_buffer(self.writer.buffer)
        assert self.reader.verify()
        self.reader.deserialize(self.account)

    def serialize(self):
        # Reset FBE stream
        self.writer.reset()

        # Serialize the account to the FBE stream
        self.writer.serialize(self.account)

    def deserialize(self):
        # Deserialize the account from the FBE stream
        self.reader.deserialize(self.account)

    def verify(self):
        # Verify the account
        self.writer.verify()


benchmark = BenchmarkSerializationFinal()
iterations = 100000


def report(name, duration):
    print()
    print("Phase: {}".format(name))
    print("Average time: {:.3f} mcs / iteration".format(duration / iterations * 1000000))
    print("Total time: {:.3f} s".format(duration))
    print("Total iterations: {}".format(iterations))
    print("Iterations throughput: {:.3f} / second".format(iterations / duration))
    print()


def main():
    # Benchmark verify() method
    times = timeit.repeat(setup='print("Benchmarking verify() method...")', stmt="benchmark.verify()", repeat=5, number=iterations, globals=globals())
    duration = min(times)
    report("Verify (Final)", duration)

    # Benchmark serialize() method
    times = timeit.repeat(setup='print("Benchmarking serialize() method...")', stmt="benchmark.serialize()", repeat=5, number=iterations, globals=globals())
    duration = min(times)
    report("Serialize (Final)", duration)

    # Benchmark deserialize() method
    times = timeit.repeat(setup='print("Benchmarking deserialize() method...")', stmt="benchmark.deserialize()", repeat=5, number=iterations, globals=globals())
    duration = min(times)
    report("Deserialize (Final)", duration)


if __name__ == "__main__":
    main()
