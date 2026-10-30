package main

import "fmt"
import "github.com/chronoxor/FastBinaryEncoding/projects/Go/proto/test"

func main() {
	json, _ := test.NewStructSimple().JSON()
	fmt.Println(string(json))
	fmt.Println()

	json, _ = test.NewStructOptional().JSON()
	fmt.Println(string(json))
	fmt.Println()

	json, _ = test.NewStructNested().JSON()
	fmt.Println(string(json))
	fmt.Println()
}
