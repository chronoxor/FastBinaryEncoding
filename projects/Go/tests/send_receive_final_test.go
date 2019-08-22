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

func (r *MyFinalReceiver) OnReceiveOrderMessage(value *protoex.OrderMessage) { r.order = true }
func (r *MyFinalReceiver) OnReceiveBalanceMessage(value *protoex.BalanceMessage) { r.balance = true }
func (r *MyFinalReceiver) OnReceiveAccountMessage(value *protoex.AccountMessage) { r.account = true }

func SendAndReceiveFinal(index1 int, index2 int) bool {
	sender := NewMyFinalSender()

	// Create and send a new order
	order := protoex.OrderMessage{Body: protoex.Order{Id: 1, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_market, Price: 1.23456, Volume: 1000.0, Sl: 0.0, Tp: 0.0}}
	_, _ = sender.Send(&order)

	// Create and send a new balance wallet
	balance := protoex.BalanceMessage{Body: protoex.Balance{Balance: &proto.Balance{Currency: "USD", Amount: 1000.0}, Locked: 100.0}}
	_, _ = sender.Send(&balance)

	// Create and send a new account with some orders
	account := protoex.AccountMessage{Body: *protoex.NewAccountFromFieldValues(1, "Test", protoex.StateEx_good, protoex.Balance{Balance: &proto.Balance{Currency: "USD", Amount: 1000.0}, Locked: 100.0}, &protoex.Balance{Balance: &proto.Balance{Currency: "EUR", Amount: 100.0}, Locked: 0.0}, make([]protoex.Order, 0))}
	account.Body.Orders = append(account.Body.Orders, protoex.Order{Id: 1, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_market, Price: 1.23456, Volume: 1000.0, Sl: 0.0, Tp: 0.0})
	account.Body.Orders = append(account.Body.Orders, protoex.Order{Id: 2, Symbol: "EURUSD", Side: protoex.OrderSide_sell, Type: protoex.OrderType_limit, Price: 1.0, Volume: 100.0, Sl: 0.0, Tp: 0.0})
	account.Body.Orders = append(account.Body.Orders, protoex.Order{Id: 3, Symbol: "EURUSD", Side: protoex.OrderSide_buy, Type: protoex.OrderType_stop, Price: 1.5, Volume: 10.0, Sl: 0.0, Tp: 0.0})
	_, _ = sender.Send(&account)

	receiver := NewMyFinalReceiver()

	// Receive data from the sender
	index1 %= sender.Buffer().Size()
	index2 %= sender.Buffer().Size()
	if index2 < index1 {
		index2 = index1
	}
	_ = receiver.Receive(sender.Buffer().Data()[:index1])
	_ = receiver.Receive(sender.Buffer().Data()[index1:index2])
	_ = receiver.Receive(sender.Buffer().Data()[index2:])
	return receiver.Check()
}

func TestSendAndReceiveFinal(t *testing.T) {
	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++ {
			assert.True(t, SendAndReceiveFinal(i, j))
		}
	}
}
