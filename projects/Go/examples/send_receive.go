package main

import "fmt"
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

func (s *MySender) OnSendLog(message string) {
	fmt.Printf("onSend: %s\n", message)
}

type MyReceiver struct {
	*proto.Receiver
}

func NewMyReceiver() *MyReceiver {
	receiver := &MyReceiver{proto.NewReceiver()}
	receiver.SetupHandlers(receiver)
	return receiver
}

func (r *MyReceiver) OnReceiveOrderMessage(value *proto.OrderMessage) {}
func (r *MyReceiver) OnReceiveBalanceMessage(value *proto.BalanceMessage) {}
func (r *MyReceiver) OnReceiveAccountMessage(value *proto.AccountMessage) {}

func (r *MyReceiver) OnReceiveLog(message string) {
	fmt.Printf("onReceive: %s\n", message)
}

func main() {
	sender := NewMySender()

	// Enable logging
	sender.SetLogging(true)

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

	// Enable logging
	receiver.SetLogging(true)

	// Receive all data from the sender
	_ = receiver.ReceiveBuffer(sender.Buffer())
}
