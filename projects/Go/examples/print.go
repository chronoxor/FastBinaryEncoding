package main

import "fmt"
import "../proto/test"

func main() {
	fmt.Println(test.NewStructSimple())
	fmt.Println()

	fmt.Println(test.NewStructOptional())
	fmt.Println()

	fmt.Println(test.NewStructNested())
	fmt.Println()
}
