package main

import (
	"../proto/fbe"
	"../proto/proto"
	"encoding/json"
	"fmt"
)

func main() {
	var s = proto.State_bad
	fmt.Println(s)
	j1, _ := json.Marshal(s)
	json.Unmarshal(j1, &s)
	fmt.Println(s)

	var os = proto.OrderSide_buy
	j, _ := json.Marshal(os)
	json.Unmarshal(j, &os)
	fmt.Println(os)

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
