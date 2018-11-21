package main

import (
	"../proto/fbe"
	"fmt"
)

func main() {
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
