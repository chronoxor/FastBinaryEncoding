package tests

import "testing"
import "github.com/stretchr/testify/assert"
import "../proto/proto"

func TestClone(t *testing.T) {
	// Create a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Clone the account
	account2 := account.Clone()

	// Clear the source account
	account = proto.NewAccount()

	assert.EqualValues(t, account2.Id, 1)
	assert.EqualValues(t, account2.Name, "Test")
	assert.True(t, account2.State.HasFlags(proto.State_good))
	assert.EqualValues(t, account2.Wallet.Currency, "USD")
	assert.EqualValues(t, account2.Wallet.Amount, 1000.0)
	assert.NotNil(t, account2.Asset)
	assert.EqualValues(t, account2.Asset.Currency, "EUR")
	assert.EqualValues(t, account2.Asset.Amount, 100.0)
	assert.EqualValues(t, len(account2.Orders), 3)
	assert.EqualValues(t, account2.Orders[0].Id, 1)
	assert.EqualValues(t, account2.Orders[0].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[0].Side, proto.OrderSide_buy)
	assert.EqualValues(t, account2.Orders[0].Type, proto.OrderType_market)
	assert.EqualValues(t, account2.Orders[0].Price, 1.23456)
	assert.EqualValues(t, account2.Orders[0].Volume, 1000.0)
	assert.EqualValues(t, account2.Orders[1].Id, 2)
	assert.EqualValues(t, account2.Orders[1].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[1].Side, proto.OrderSide_sell)
	assert.EqualValues(t, account2.Orders[1].Type, proto.OrderType_limit)
	assert.EqualValues(t, account2.Orders[1].Price, 1.0)
	assert.EqualValues(t, account2.Orders[1].Volume, 100.0)
	assert.EqualValues(t, account2.Orders[2].Id, 3)
	assert.EqualValues(t, account2.Orders[2].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[2].Side, proto.OrderSide_buy)
	assert.EqualValues(t, account2.Orders[2].Type, proto.OrderType_stop)
	assert.EqualValues(t, account2.Orders[2].Price, 1.5)
	assert.EqualValues(t, account2.Orders[2].Volume, 10.0)
}
