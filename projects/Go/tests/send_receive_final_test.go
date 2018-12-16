package tests

import (
	"testing"
)
import "github.com/stretchr/testify/assert"
import "../proto/proto"

type MyFinalSender struct {
	*proto.FinalSender
}

func NewMyFinalSender() *MyFinalSender {
	sender := &MyFinalSender{proto.NewFinalSender()}
	sender.SetupHandlers(sender)
	return sender
}

func (s *MyFinalSender) OnSend(buffer []byte) (int, error) {
	// Send nothing...
	return 0, nil
}

type MyFinalReceiver struct {
	*proto.FinalReceiver
	order bool
	balance bool
	account bool
}

func NewMyFinalReceiver() *MyFinalReceiver {
	receiver := &MyFinalReceiver{proto.NewFinalReceiver(), false, false, false}
	receiver.SetupHandlers(receiver)
	return receiver
}

func (r *MyFinalReceiver) Check() bool { return r.order && r.balance && r.account }

func (r *MyFinalReceiver) OnReceiveOrder(value *proto.Order) { r.order = true }
func (r *MyFinalReceiver) OnReceiveBalance(value *proto.Balance) { r.balance = true }
func (r *MyFinalReceiver) OnReceiveAccount(value *proto.Account) { r.account = true }

func SendAndReceiveFinal(index int) bool {
	sender := NewMyFinalSender()

	// Create and send a new order
	order := proto.Order{Uid: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0}
	_, _ = sender.Send(&order)

	// Create and send a new balance wallet
	balance := proto.Balance{Currency: "USD", Amount: 1000.0}
	_, _ = sender.Send(&balance)

	// Create and send a new account with some orders
	var account = proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))
	account.Orders = append(account.Orders, proto.Order{Uid: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Orders = append(account.Orders, proto.Order{Uid: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Orders = append(account.Orders, proto.Order{Uid: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})
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
