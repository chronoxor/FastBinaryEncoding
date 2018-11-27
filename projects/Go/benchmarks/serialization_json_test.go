package benchmarks

import "testing"
import "../proto/proto"

func SetupBenchmark() (*proto.Account, []byte) {
	// Create a new account with some orders
	var account = proto.NewAccount()
	account.Uid = 1
	account.Name = "Test"
	account.State = proto.State_good
	account.Wallet = proto.Balance{Currency:"USD", Amount:1000.0}
	account.Asset = &proto.Balance{Currency:"EUR", Amount:100.0}
	account.Orders = append(account.Orders, proto.Order{Uid:1, Symbol:"EURUSD", Side:proto.OrderSide_buy, Type:proto.OrderType_market, Price:1.23456, Volume:1000.0})
	account.Orders = append(account.Orders, proto.Order{Uid:2, Symbol:"EURUSD", Side:proto.OrderSide_sell, Type:proto.OrderType_limit, Price:1.0, Volume:100.0})
	account.Orders = append(account.Orders, proto.Order{Uid:3, Symbol:"EURUSD", Side:proto.OrderSide_buy, Type:proto.OrderType_stop, Price:1.5, Volume:10.0})

	// Serialize the account to the JSON string
	json, _ := account.JSON()

	// Deserialize the account from the JSON string
	account, _ = proto.NewAccountFromJSON(json)

	// Return result JSON
	return account, json
}

// Benchmark: serialize the account to the JSON string
func BenchmarkJsonSerialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, _ := SetupBenchmark()

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		json, _ := account.JSON()
		b.SetBytes(int64(len(json)))
	}
}

// Benchmark: deserialize the account from the JSON string
func BenchmarkJsonDeserialize(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	_, json := SetupBenchmark()

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		_, _ = proto.NewAccountFromJSON(json)
		b.SetBytes(int64(len(json)))
	}
}
