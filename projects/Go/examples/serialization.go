package main

import "fmt"
import "../proto/fbe"
import "../proto/proto"

func main() {
	// Create a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Serialize the account to the FBE stream
	writer := proto.NewAccountModel(fbe.NewEmptyBuffer())
	if _, err := writer.Serialize(account); err != nil {
		panic("serialization error")
	}
	if ok := writer.Verify(); !ok {
		panic("verify error")
	}

	// Show the serialized FBE size
	fmt.Printf("FBE size: %d\n", writer.Buffer().Size())

	// Deserialize the account from the FBE stream
	reader := proto.NewAccountModel(writer.Buffer())
	if ok := reader.Verify(); !ok {
		panic("verify error")
	}
	account, _, err := reader.Deserialize()
	if err != nil {
		panic("deserialization error")
	}

	// Show account content
	fmt.Println()
	fmt.Println(account)
}
