package tests

import "../proto/fbe"
import "testing"
import "github.com/shopspring/decimal"

func VerifyDecimal(test *testing.T, low uint32, mid uint32, high uint32, negative bool, scale uint32, value string) {
	flags := uint32(scale << 16)
	if negative {
		flags |= 0x80000000
	}

	buffer := make([]byte, 16)
	fbe.WriteUInt32(buffer, 0, low)
	fbe.WriteUInt32(buffer, 4, mid)
	fbe.WriteUInt32(buffer, 8, high)
	fbe.WriteUInt32(buffer, 12, flags)

	readBuffer := fbe.NewAttachedBuffer(buffer, 0, len(buffer))

	model := fbe.NewFieldModelDecimal(*readBuffer, 0)
	value1 := model.Get()
	model.Set(value1)
	value2 := model.Get()

	if !value1.Equal(value2) {
		test.Errorf("Invalid decimal serialization!")
	}

	value3, _ := decimal.NewFromString(value)
	if !value1.Equal(value3) {
		test.Errorf("Invalid decimal convertion!")
	}
}

func TestDecimal(test *testing.T) {
	// FBE decimal exponent ranging from 0 to 28
	decimal.DivisionPrecision = 29
	VerifyDecimal(test, 0x00000000, 0x00000000, 0x00000000, false, 0x00000000, "0")
}