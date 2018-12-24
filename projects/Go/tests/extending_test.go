package tests

import "testing"
import "github.com/stretchr/testify/assert"
import "../proto/fbe"
import "../proto/proto"
import "../proto/protoex"

func TestExtendingOldNew(t *testing.T) {
	// Create a new account with some orders
	var account1 = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account1.Orders = append(account1.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account1.Orders = append(account1.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account1.Orders = append(account1.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	// Serialize the struct to the FBE stream
	writer := proto.NewAccountModel(fbe.NewEmptyBuffer())
	assert.EqualValues(t, writer.Model().FBEOffset(), 4)
	serialized, err := writer.Serialize(account1)
	assert.Nil(t, err)
	assert.EqualValues(t, serialized, writer.Buffer().Size())
	assert.True(t, writer.Verify())
	writer.Next(serialized)
	assert.EqualValues(t, writer.Model().FBEOffset(), 4+writer.Buffer().Size())

	// Check the serialized FBE size
	assert.EqualValues(t, writer.Buffer().Size(), 252)

	// Deserialize the struct from the FBE stream
	reader := protoex.NewAccountModel(writer.Buffer())
	assert.EqualValues(t, reader.Model().FBEOffset(), 4)
	assert.True(t, reader.Verify())
	account2, deserialized, err := reader.Deserialize()
	assert.Nil(t, err)
	assert.EqualValues(t, deserialized, reader.Buffer().Size())
	reader.Next(deserialized)
	assert.EqualValues(t, reader.Model().FBEOffset(), 4+reader.Buffer().Size())

	assert.EqualValues(t, account2.Id, 1)
	assert.EqualValues(t, account2.Name, "Test")
	assert.True(t, account2.State.HasFlags(protoex.StateEx_good))
	assert.EqualValues(t, account2.Wallet.Currency, "USD")
	assert.EqualValues(t, account2.Wallet.Amount, 1000.0)
	assert.EqualValues(t, account2.Wallet.Locked, 0.0)
	assert.NotNil(t, account2.Asset)
	assert.EqualValues(t, account2.Asset.Currency, "EUR")
	assert.EqualValues(t, account2.Asset.Amount, 100.0)
	assert.EqualValues(t, account2.Asset.Locked, 0.0)
	assert.EqualValues(t, len(account2.Orders), 3)
	assert.EqualValues(t, account2.Orders[0].Id, 1)
	assert.EqualValues(t, account2.Orders[0].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[0].Side, protoex.OrderSide_buy)
	assert.EqualValues(t, account2.Orders[0].Type, protoex.OrderType_market)
	assert.EqualValues(t, account2.Orders[0].Price, 1.23456)
	assert.EqualValues(t, account2.Orders[0].Volume, 1000.0)
	assert.EqualValues(t, account2.Orders[0].Tp, 10.0)
	assert.EqualValues(t, account2.Orders[0].Sl, -10.0)
	assert.EqualValues(t, account2.Orders[1].Id, 2)
	assert.EqualValues(t, account2.Orders[1].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[1].Side, protoex.OrderSide_sell)
	assert.EqualValues(t, account2.Orders[1].Type, protoex.OrderType_limit)
	assert.EqualValues(t, account2.Orders[1].Price, 1.0)
	assert.EqualValues(t, account2.Orders[1].Volume, 100.0)
	assert.EqualValues(t, account2.Orders[1].Tp, 10.0)
	assert.EqualValues(t, account2.Orders[1].Sl, -10.0)
	assert.EqualValues(t, account2.Orders[2].Id, 3)
	assert.EqualValues(t, account2.Orders[2].Symbol, "EURUSD")
	assert.EqualValues(t, account2.Orders[2].Side, protoex.OrderSide_buy)
	assert.EqualValues(t, account2.Orders[2].Type, protoex.OrderType_stop)
	assert.EqualValues(t, account2.Orders[2].Price, 1.5)
	assert.EqualValues(t, account2.Orders[2].Volume, 10.0)
	assert.EqualValues(t, account2.Orders[2].Tp, 10.0)
	assert.EqualValues(t, account2.Orders[2].Sl, -10.0)
}

func TestExtendingNewOld(t *testing.T) {
	// Create a new account with some orders
	var account1 = protoex.NewAccountFromFieldValues(1, "Test", protoex.StateEx_good | protoex.StateEx_happy, protoex.Balance{Balance: &proto.Balance{Currency: "USD", Amount: 1000.0}, Locked: 123.456}, &protoex.Balance{Balance: &proto.Balance{Currency: "EUR", Amount: 100.0}, Locked: 12.34}, make([]protoex.Order, 0))
	account1.Orders = append(account1.Orders, protoex.Order{Id: 1, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_market, Price: 1.23456, Volume: 1000.0, Tp: 0.0, Sl: 0.0})
	account1.Orders = append(account1.Orders, protoex.Order{Id: 2, Symbol: "EURUSD", Side: protoex.OrderSide_sell, Type: protoex.OrderType_limit, Price: 1.0, Volume: 100.0, Tp: 0.1, Sl: -0.1})
	account1.Orders = append(account1.Orders, protoex.Order{Id: 3, Symbol: "EURUSD", Side: protoex.OrderSide_tell, Type: protoex.OrderType_stoplimit, Price: 1.5, Volume: 10.0, Tp: 1.1, Sl: -1.1})

	// Serialize the struct to the FBE stream
	writer := protoex.NewAccountModel(fbe.NewEmptyBuffer())
	assert.EqualValues(t, writer.Model().FBEOffset(), 4)
	serialized, err := writer.Serialize(account1)
	assert.Nil(t, err)
	assert.EqualValues(t, serialized, writer.Buffer().Size())
	assert.True(t, writer.Verify())
	writer.Next(serialized)
	assert.EqualValues(t, writer.Model().FBEOffset(), 4+writer.Buffer().Size())

	// Check the serialized FBE size
	assert.EqualValues(t, writer.Buffer().Size(), 316)

	// Deserialize the struct from the FBE stream
	reader := proto.NewAccountModel(writer.Buffer())
	assert.EqualValues(t, reader.Model().FBEOffset(), 4)
	assert.True(t, reader.Verify())
	account2, deserialized, err := reader.Deserialize()
	assert.Nil(t, err)
	assert.EqualValues(t, deserialized, reader.Buffer().Size())
	reader.Next(deserialized)
	assert.EqualValues(t, reader.Model().FBEOffset(), 4+reader.Buffer().Size())

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
	assert.NotEqual(t, account2.Orders[2].Side, proto.OrderSide_buy)
	assert.NotEqual(t, account2.Orders[2].Type, proto.OrderType_stop)
	assert.EqualValues(t, account2.Orders[2].Price, 1.5)
	assert.EqualValues(t, account2.Orders[2].Volume, 10.0)
}
