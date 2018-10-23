import proto
import timeit
from proto import proto


class BenchmarkSerializationJson(object):

    def __init__(self):
        # Create a new account with some orders
        self.account = proto.Account(1, "Test", proto.State.good, proto.Balance("USD", 1000.0), proto.Balance("EUR", 100.0))
        self.account.orders.append(proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0))
        self.account.orders.append(proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0))
        self.account.orders.append(proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0))

        # Serialize the account to the JSON string
        self.json = self.account.to_json()

        # Deserialize the account from the JSON string
        self.account = proto.Account.from_json(self.json)

    def serialize(self):
        # Serialize the account to the JSON string
        self.json = self.account.to_json()

    def deserialize(self):
        # Deserialize the account from the JSON string
        self.account = proto.Account.from_json(self.json)


benchmark = BenchmarkSerializationJson()
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
    # Benchmark serialize() method
    times = timeit.repeat(setup='print("Benchmarking serialize() method...")', stmt="benchmark.serialize()", repeat=5, number=iterations, globals=globals())
    duration = min(times)
    report("Serialize (JSON)", duration)

    # Benchmark deserialize() method
    times = timeit.repeat(setup='print("Benchmarking deserialize() method...")', stmt="benchmark.deserialize()", repeat=5, number=iterations, globals=globals())
    duration = min(times)
    report("Deserialize (JSON)", duration)


if __name__ == "__main__":
    main()
