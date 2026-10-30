package benchmarks

import "testing"
import "github.com/chronoxor/FastBinaryEncoding/projects/Go/proto/fbe"
import "github.com/chronoxor/FastBinaryEncoding/projects/Go/proto/proto"

func SetupBenchmark(tb testing.TB) (*proto.Account, *proto.AccountModel, *proto.AccountModel) {
	tb.Helper()

	// Create a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Serialize the account to the FBE stream
	writer := proto.NewAccountModel(fbe.NewEmptyBuffer())
	_, err := writer.Serialize(account)
	if err != nil {
		tb.Fatalf("serialization error: %v", err)
	}
	if !writer.Verify() {
		tb.Fatal("verify error")
	}

	// Deserialize the account from the FBE stream
	reader := proto.NewAccountModel(writer.Buffer())
	if ok := reader.Verify(); !ok {
		tb.Fatal("verify error")
	}
	account, _, err = reader.Deserialize()
	if err != nil {
		tb.Fatalf("deserialization error: %v", err)
	}

	// Return result
	return account, writer, reader
}

// Benchmark: serialize the account to the FBE stream
func BenchmarkSerialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, writer, _ := SetupBenchmark(b)

	// Perform the benchmark
	for b.Loop() {
		// Reset FBE stream
		writer.Buffer().Reset()
		// Serialize the account to the FBE stream
		size, _ := writer.Serialize(account)
		b.SetBytes(int64(size))
	}
}

// Benchmark: deserialize the account from the FBE stream
func BenchmarkDeserialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, _, reader := SetupBenchmark(b)

	// Perform the benchmark
	for b.Loop() {
		// Deserialize the account from the FBE stream
		size, _ := reader.DeserializeValue(account)
		b.SetBytes(int64(size))
	}
}

// Benchmark: verify the FBE stream
func BenchmarkVerify(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	_, writer, _ := SetupBenchmark(b)

	// Perform the benchmark
	for b.Loop() {
		// Verify the account
		_ = writer.Verify()
		b.SetBytes(int64(writer.Buffer().Size()))
	}
}
