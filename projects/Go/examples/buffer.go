package main

import (
	"../proto/fbe"
	"../proto/proto"
	"../proto/protoex"
	"encoding/json"
	"fmt"
)

func main() {
	var StringSet map[string]bool
	StringSet = make(map[string]bool)
	StringSet["Test1"] = true
	StringSet["Test2"] = true
	StringSet["Test3"] = true
	jjj, _ := json.Marshal(StringSet)
	fmt.Println(string(jjj))
	_ = json.Unmarshal(jjj, &StringSet)
	fmt.Println(StringSet)

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
