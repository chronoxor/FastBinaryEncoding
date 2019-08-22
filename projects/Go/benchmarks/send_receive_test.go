package benchmarks

import "testing"
import "../proto/proto"

type MySender1 struct {
	*proto.Sender
	size int
	logs int
}

func NewMySender1() *MySender1 {
	sender := &MySender1{proto.NewSender(), 0, 0}
	sender.SetupHandlers(sender)
	return sender
}

func (s *MySender1) OnSend(buffer []byte) (int, error) {
	s.size += len(buffer)
	return len(buffer), nil
}

func (s *MySender1) OnSendLog(message string) {
	s.logs += len(message)
}

type MySender2 struct {
	*proto.Sender
	size int
	logSize int
}

func NewMySender2() *MySender2 {
	sender := &MySender2{proto.NewSender(), 0, 0}
	sender.SetupHandlers(sender)
	return sender
}

func (s *MySender2) OnSend(buffer []byte) (int, error) {
	s.size += len(buffer)
	return 0, nil
}

func (s *MySender2) OnSendLog(message string) {
	s.logSize += len(message)
}

type MyReceiver struct {
	*proto.Receiver
	logs int
}

func NewMyReceiver() *MyReceiver {
	receiver := &MyReceiver{proto.NewReceiver(), 0}
	receiver.SetupHandlers(receiver)
	return receiver
}

func (r *MyReceiver) OnReceiveOrderMessage(value *proto.OrderMessage) {}
func (r *MyReceiver) OnReceiveBalanceMessage(value *proto.BalanceMessage) {}
func (r *MyReceiver) OnReceiveAccountMessage(value *proto.AccountMessage) {}

func (r *MyReceiver) OnReceiveLog(message string) {
	r.logs += len(message)
}

func SetupBenchmarkSender() (*proto.AccountMessage, *MySender1, *MySender2, *MyReceiver) {
	// Create a new account with some orders
	account := proto.AccountMessage{Body: *proto.NewAccountFromFieldValues(1, "Test", proto.State_good, proto.Balance{Currency: "USD", Amount: 1000.0}, &proto.Balance{Currency: "EUR", Amount: 100.0}, make([]proto.Order, 0))}
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 1, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_market, Price: 1.23456, Volume: 1000.0})
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 2, Symbol: "EURUSD", Side: proto.OrderSide_sell, Type: proto.OrderType_limit, Price: 1.0, Volume: 100.0})
	account.Body.Orders = append(account.Body.Orders, proto.Order{Id: 3, Symbol: "EURUSD", Side: proto.OrderSide_buy, Type: proto.OrderType_stop, Price: 1.5, Volume: 10.0})

	sender1 := NewMySender1()
	_, _ = sender1.Send(account)

	sender2 := NewMySender2()
	_, _ = sender2.Send(account)

	receiver := NewMyReceiver()
	_ = receiver.ReceiveBuffer(sender2.Buffer())

	// Return result
	return &account, sender1, sender2, receiver
}

// Benchmark: serialize and send the account
func BenchmarkSend(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, sender, _, _ := SetupBenchmarkSender()

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		size, _ := sender.Send(account)
		b.SetBytes(int64(size))
	}
}

// Benchmark: serialize and send the account with logs
func BenchmarkSendWithLogs(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	account, sender, _, _ := SetupBenchmarkSender()

	// Enable logging
	sender.SetLogging(true)

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		size, _ := sender.Send(account)
		b.SetBytes(int64(size))
	}
}

// Benchmark: receive the account from the sender
func BenchmarkReceive(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	_, _, sender, receiver := SetupBenchmarkSender()

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		_ = receiver.ReceiveBuffer(sender.Buffer())
		b.SetBytes(int64(sender.Buffer().Size()))
	}
}

// Benchmark: receive the account from the sender with logs
func BenchmarkReceiveWithLogs(b *testing.B) {
	// Setup the benchmark
	b.ReportAllocs()
	_, _, sender, receiver := SetupBenchmarkSender()

	// Enable logging
	receiver.SetLogging(true)

	// Perform the benchmark
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		_ = receiver.ReceiveBuffer(sender.Buffer())
		b.SetBytes(int64(sender.Buffer().Size()))
	}
}
