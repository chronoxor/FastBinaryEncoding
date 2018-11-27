package main

import (
	"../proto/fbe"
	"../proto/proto"
	"../proto/protoex"
	"../proto/test"
	"encoding/json"
	"fmt"
	"github.com/deckarep/golang-set"
)

type MyTest struct {
	F1 mapset.Set
}

func main() {
	s := MyTest{F1:mapset.NewSet()}
	s.F1.Add(123)
	s.F1.Add(456)
	s.F1.Add(test.NewStructSimple())
	s.F1.Add(test.NewStructSimple())

	a := s.F1.Contains(123)
	println(a)

	jjj, _ := json.Marshal(s)
	fmt.Println(string(jjj))
	var s2 MyTest = MyTest{F1:mapset.NewSet()}
	_ = json.Unmarshal(jjj, &s2)
	fmt.Println(s)

	a = s2.F1.Contains(123)
	println(a)

	o1 := proto.NewOrder()
	o1.Symbol = "EURUSD"
	o1.Price = 123.456
	o1.Volume = 987.654
	j, _ := o1.JSON()
	fmt.Println(string(j))
	o2, _ := proto.NewOrderFromJSON(j)
	fmt.Println(o2)

	m := map[proto.OrderKey]string{}
	m[o1.Key()] = o1.String()

	b1 := protoex.NewBalance()
	b1.Currency = "EUR"
	b1.Amount = 123.456
	b1.Locked = 987.654
	j, _ = b1.JSON()
	fmt.Println(string(j))
	b2, _ := protoex.NewBalanceFromJSON(j)
	fmt.Println(b2)

	buffer := fbe.NewCapacityBuffer(10)
	buffer.Allocate(10)
	for i := 0; i < buffer.Size(); i++ {
		buffer.Data()[i] = byte(i)
	}
	buffer.Allocate(5)
	buffer.Remove(2, 3)
	fmt.Println(buffer.Capacity())
	fmt.Println(buffer.Size())
}
