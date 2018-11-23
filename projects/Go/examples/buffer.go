package main

import (
	"../proto/fbe"
	"../proto/proto"
	"encoding/json"
	"fmt"
)

func main() {
	jjj, _ := json.Marshal([]byte{49, 50, 51, 52, 53, 54, 55, 56})
	fmt.Println(string(jjj))
	var bbb []byte
	_ = json.Unmarshal(jjj, &bbb)
	fmt.Println(string(bbb))

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
