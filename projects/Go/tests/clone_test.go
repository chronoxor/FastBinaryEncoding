package tests

import "testing"
import "github.com/stretchr/testify/require"
import "github.com/chronoxor/FastBinaryEncoding/projects/Go/proto/proto"

func TestClone(t *testing.T) {
	t.Parallel()
	// Create a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Clone the account
	account2 := account.Clone()

	// Clear the source account
	account = proto.NewAccount()

	require.EqualValues(t, account2.Id, 1)
	require.EqualValues(t, account2.Name, "Test")
	require.True(t, account2.State.HasFlags(proto.State_good))
	require.EqualValues(t, account2.Wallet.Currency, "USD")
	require.EqualValues(t, account2.Wallet.Amount, 1000.0)
	require.NotNil(t, account2.Asset)
	require.EqualValues(t, account2.Asset.Currency, "EUR")
	require.EqualValues(t, account2.Asset.Amount, 100.0)
	require.EqualValues(t, len(account2.Orders), 3)
	require.EqualValues(t, account2.Orders[0].Id, 1)
	require.EqualValues(t, account2.Orders[0].Symbol, "EURUSD")
	require.EqualValues(t, account2.Orders[0].Side, proto.OrderSide_buy)
	require.EqualValues(t, account2.Orders[0].Type, proto.OrderType_market)
	require.EqualValues(t, account2.Orders[0].Price, 1.23456)
	require.EqualValues(t, account2.Orders[0].Volume, 1000.0)
	require.EqualValues(t, account2.Orders[1].Id, 2)
	require.EqualValues(t, account2.Orders[1].Symbol, "EURUSD")
	require.EqualValues(t, account2.Orders[1].Side, proto.OrderSide_sell)
	require.EqualValues(t, account2.Orders[1].Type, proto.OrderType_limit)
	require.EqualValues(t, account2.Orders[1].Price, 1.0)
	require.EqualValues(t, account2.Orders[1].Volume, 100.0)
	require.EqualValues(t, account2.Orders[2].Id, 3)
	require.EqualValues(t, account2.Orders[2].Symbol, "EURUSD")
	require.EqualValues(t, account2.Orders[2].Side, proto.OrderSide_buy)
	require.EqualValues(t, account2.Orders[2].Type, proto.OrderType_stop)
	require.EqualValues(t, account2.Orders[2].Price, 1.5)
	require.EqualValues(t, account2.Orders[2].Volume, 10.0)
}
