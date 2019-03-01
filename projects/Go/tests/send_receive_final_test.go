package tests

import (
	"testing"
)
import "github.com/stretchr/testify/assert"
import "../proto/proto"
import "../proto/protoex"

type MyFinalSender struct {
	*protoex.FinalSender
}

func NewMyFinalSender() *MyFinalSender {
	sender := &MyFinalSender{protoex.NewFinalSender()}
	sender.SetupHandlers(sender)
	return sender
}

func (s *MyFinalSender) OnSend(buffer []byte) (int, error) {
	// Send nothing...
	return 0, nil
}

type MyFinalReceiver struct {
	*protoex.FinalReceiver
	order bool
	balance bool
	account bool
}

func NewMyFinalReceiver() *MyFinalReceiver {
	receiver := &MyFinalReceiver{protoex.NewFinalReceiver(), false, false, false}
	receiver.SetupHandlers(receiver)
	return receiver
}

func (r *MyFinalReceiver) Check() bool { return r.order && r.balance && r.account }

func (r *MyFinalReceiver) OnReceiveOrder(value *protoex.Order) { r.order = true }
func (r *MyFinalReceiver) OnReceiveBalance(value *protoex.Balance) { r.balance = true }
func (r *MyFinalReceiver) OnReceiveAccount(value *protoex.Account) { r.account = true }

func SendAndReceiveFinal(index int) bool {
	sender := NewMyFinalSender()

	// Create and send a new order
	order := protoex.Order{Id: 1, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_market, Price: 1.23456, Volume: 1000.0, Sl: 0.0, Tp: 0.0}
	_, _ = sender.Send(&order)

	// Create and send a new balance wallet
	balance := protoex.Balance{Balance: &proto.Balance{Currency: "USD", Amount: 1000.0}, Locked: 100.0}
	_, _ = sender.Send(&balance)

	// Create and send a new account with some orders
	var account = protoex.NewAccountFromFieldValues(1, "Test", protoex.StateEx_good, protoex.Balance{Balance: &proto.Balance{Currency: "USD", Amount: 1000.0}, Locked: 100.0}, &protoex.Balance{Balance: &proto.Balance{Currency: "EUR", Amount: 100.0}, Locked: 0.0}, make([]protoex.Order, 0))
	account.Orders = append(account.Orders, protoex.Order{Id: 1, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_market, Price: 1.23456, Volume: 1000.0, Sl: 0.0, Tp: 0.0})
	account.Orders = append(account.Orders, protoex.Order{Id: 2, Symbol: "EURUSD", Side: protoex.OrderSide_sell, Type: protoex.OrderType_limit, Price: 1.0, Volume: 100.0, Sl: 0.0, Tp: 0.0})
	account.Orders = append(account.Orders, protoex.Order{Id: 3, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_stop, Price: 1.5, Volume: 10.0, Sl: 0.0, Tp: 0.0})
	_, _ = sender.Send(account)

	receiver := NewMyFinalReceiver()

	// Receive data from the sender
	index %= sender.Buffer().Size()
	_ = receiver.Receive(sender.Buffer().Data()[:index])
	_ = receiver.Receive(sender.Buffer().Data()[index:])
	return receiver.Check()
}

func TestSendAndReceiveFinal(t *testing.T) {
	for i := 0; i < 1000; i++ {
		assert.True(t, SendAndReceiveFinal(i))
	}
}
