package benchmarks

import "testing"
import "github.com/chronoxor/FastBinaryEncoding/projects/Go/proto/proto"

func SetupBenchmarkJson(tb testing.TB) (*proto.Account, []byte) {
	tb.Helper()

	// Create a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Serialize the account to the JSON string
	json, err := account.JSON()
	if err != nil {
		tb.Fatalf("serialization error: %v", err)
	}

	// Deserialize the account from the JSON string
	account, err = proto.NewAccountFromJSON(json)
	if err != nil {
		tb.Fatalf("deserialization error: %v", err)
	}

	// Return result JSON
	return account, json
}

// Benchmark: serialize the account to the JSON string
func BenchmarkJsonSerialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, _ := SetupBenchmarkJson(b)

	// Perform the benchmark
	for b.Loop() {
		json, _ := account.JSON()
		b.SetBytes(int64(len(json)))
	}
}

// Benchmark: deserialize the account from the JSON string
func BenchmarkJsonDeserialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	_, json := SetupBenchmarkJson(b)

	// Perform the benchmark
	for b.Loop() {
		_, _ = proto.NewAccountFromJSON(json)
		b.SetBytes(int64(len(json)))
	}
}
