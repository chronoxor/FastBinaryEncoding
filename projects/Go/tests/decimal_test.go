package tests

import "testing"
import "github.com/shopspring/decimal"
import "github.com/stretchr/testify/assert"
import "../proto/fbe"

func VerifyDecimal(t *testing.T, low uint32, mid uint32, high uint32, negative bool, scale uint32, value string) {
	base, _ := decimal.NewFromString(value)

	flags := uint32(scale << 16)
	if negative {
		flags |= 0x80000000
	}

	buffer := make([]byte, 16)
	fbe.WriteUInt32(buffer, 0, low)
	fbe.WriteUInt32(buffer, 4, mid)
	fbe.WriteUInt32(buffer, 8, high)
	fbe.WriteUInt32(buffer, 12, flags)

	readBuffer := fbe.NewAttached(buffer)

	model := fbe.NewFieldModelDecimal(readBuffer, 0)
	value1, _ := model.Get()
	_ = model.Set(value1)
	value2, _ := model.Get()

	assert.True(t, value1.Equal(base) && value2.Equal(base), "Invalid decimal serialization!")

	finalModel := fbe.NewFinalModelDecimal(readBuffer, 0)
	value3, _, _ := finalModel.Get()
	_, _ = finalModel.Set(value3)
	value4, _, _ := finalModel.Get()

	assert.True(t, value3.Equal(base) && value4.Equal(base), "Invalid decimal final serialization!")
}

func TestDecimal(test *testing.T) {
	// FBE decimal exponent ranging from 0 to 28
	decimal.DivisionPrecision = 29
	VerifyDecimal(test, 0x00000000, 0x00000000, 0x00000000, false, 0x00000000, "0")
	VerifyDecimal(test, 0x00000001, 0x00000000, 0x00000000, false, 0x00000000, "1")
	VerifyDecimal(test, 0x107A4000, 0x00005AF3, 0x00000000, false, 0x00000000, "100000000000000")
	VerifyDecimal(test, 0x10000000, 0x3E250261, 0x204FCE5E, false, 0x000E0000>>16, "100000000000000.00000000000000")
	VerifyDecimal(test, 0x10000000, 0x3E250261, 0x204FCE5E, false, 0x00000000, "10000000000000000000000000000")
	VerifyDecimal(test, 0x10000000, 0x3E250261, 0x204FCE5E, false, 0x001C0000>>16, "1.0000000000000000000000000000")
	VerifyDecimal(test, 0x075BCD15, 0x00000000, 0x00000000, false, 0x00000000, "123456789")
	VerifyDecimal(test, 0x075BCD15, 0x00000000, 0x00000000, false, 0x00090000>>16, "0.123456789")
	VerifyDecimal(test, 0x075BCD15, 0x00000000, 0x00000000, false, 0x00120000>>16, "0.000000000123456789")
	VerifyDecimal(test, 0x075BCD15, 0x00000000, 0x00000000, false, 0x001B0000>>16, "0.000000000000000000123456789")
	VerifyDecimal(test, 0xFFFFFFFF, 0x00000000, 0x00000000, false, 0x00000000, "4294967295")
	VerifyDecimal(test, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, false, 0x00000000, "18446744073709551615")
	VerifyDecimal(test, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, false, 0x00000000, "79228162514264337593543950335")
	VerifyDecimal(test, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x00000000, "-79228162514264337593543950335")
	VerifyDecimal(test, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x001C0000>>16, "-7.9228162514264337593543950335")
}
