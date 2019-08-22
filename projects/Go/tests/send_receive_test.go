package tests

import (
	"testing"
)
import "github.com/stretchr/testify/assert"
import "../proto/proto"

type MySender struct {
	*proto.Sender
}

func NewMySender() *MySender {
	sender := &MySender{proto.NewSender()}
	sender.SetupHandlers(sender)
	return sender
}

func (s *MySender) OnSend(buffer []byte) (int, error) {
	// Send nothing...
	return 0, nil
}

type MyReceiver struct {
	*proto.Receiver
	order bool
	balance bool
	account bool
}

func NewMyReceiver() *MyReceiver {
	receiver := &MyReceiver{proto.NewReceiver(), false, false, false}
	receiver.SetupHandlers(receiver)
	return receiver
}

func (r *MyReceiver) Check() bool { return r.order && r.balance && r.account }

func (r *MyReceiver) OnReceiveOrderMessage(value *proto.OrderMessage) { r.order = true }
func (r *MyReceiver) OnReceiveBalanceMessage(value *proto.BalanceMessage) { r.balance = true }
func (r *MyReceiver) OnReceiveAccountMessage(value *proto.AccountMessage) { r.account = true }

func SendAndReceive(index1 int, index2 int) bool {
	sender := NewMySender()

	// Create and send a new order
	order := proto.OrderMessage{Body: proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0}}
	_, _ = sender.Send(&order)

	// Create and send a new balance wallet
	balance := proto.BalanceMessage{Body: proto.Balance{Currency: "USD", Amount: 1000.0}}
	_, _ = sender.Send(&balance)

	// Create and send a new account with some orders
	account := proto.AccountMessage{Body: *proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))}
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})
	_, _ = sender.Send(&account)

	receiver := NewMyReceiver()

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

func TestSendAndReceive(t *testing.T) {
	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++ {
			assert.True(t, SendAndReceive(i, j))
		}
	}
}
