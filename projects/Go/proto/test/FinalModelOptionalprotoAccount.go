//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: FBE
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package test

import "errors"
import "../fbe"
import "../proto"

// Workaround for Go unused imports issue
var _ = errors.New
var _ = fbe.Version
var _ = proto.Version

// Fast Binary Encoding optional protoAccount final model
type FinalModelOptionalprotoAccount struct {
    // Final model buffer
    buffer *fbe.Buffer
    // Final model buffer offset
    offset int

    // Base final model value
    value *proto.FinalModelAccount
}

// Create a new optional protoAccount final model
func NewFinalModelOptionalprotoAccount(buffer *fbe.Buffer, offset int) *FinalModelOptionalprotoAccount {
    fbeResult := FinalModelOptionalprotoAccount{buffer: buffer, offset: offset}
    fbeResult.value = proto.NewFinalModelAccount(buffer, 0)
    return &fbeResult
}

// Get the optional final model value
func (fm *FinalModelOptionalprotoAccount) Value() *proto.FinalModelAccount { return fm.value }

// Get the allocation size
func (fm *FinalModelOptionalprotoAccount) FBEAllocationSize(fbeValue *proto.Account) int {
    if fbeValue != nil {
        return 1 + fm.value.FBEAllocationSize(fbeValue)
    } else {
        return 1
    }
}

// Get the final offset
func (fm *FinalModelOptionalprotoAccount) FBEOffset() int { return fm.offset }
// Set the final offset
func (fm *FinalModelOptionalprotoAccount) SetFBEOffset(value int) { fm.offset = value }

// Shift the current final offset
func (fm *FinalModelOptionalprotoAccount) FBEShift(size int) { fm.offset += size }
// Unshift the current final offset
func (fm *FinalModelOptionalprotoAccount) FBEUnshift(size int) { fm.offset -= size }

// Check if the object contains a value
func (fm *FinalModelOptionalprotoAccount) HasValue() bool {
    if (fm.buffer.Offset() + fm.FBEOffset() + 1) > fm.buffer.Size() {
        return false
    }

    fbeHasValue := fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset())
    return fbeHasValue != 0
}

// Check if the optional value is valid
func (fm *FinalModelOptionalprotoAccount) Verify() int {
    if (fm.buffer.Offset() + fm.FBEOffset() + 1) > fm.buffer.Size() {
        return fbe.MaxInt
    }

    fbeHasValue := fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset())
    if fbeHasValue == 0 {
        return 1
    }

    fm.buffer.Shift(fm.FBEOffset() + 1)
    fbeResult := fm.value.Verify()
    fm.buffer.Unshift(fm.FBEOffset() + 1)
    return 1 + fbeResult
}

// Get the optional value
func (fm *FinalModelOptionalprotoAccount) Get() (*proto.Account, int, error) {
    var fbeValue *proto.Account = nil

    if (fm.buffer.Offset() + fm.FBEOffset() + 1) > fm.buffer.Size() {
        return fbeValue, 0, errors.New("model is broken")
    }

    if !fm.HasValue() {
        return fbeValue, 1, nil
    }

    var fbeResult int
    var err error

    fbeValue = proto.NewAccount()

    fm.buffer.Shift(fm.FBEOffset() + 1)
    fbeResult, err = fm.value.GetValue(fbeValue)
    fm.buffer.Unshift(fm.FBEOffset() + 1)
    return fbeValue, 1 + fbeResult, err
}

// Set the optional value
func (fm *FinalModelOptionalprotoAccount) Set(fbeValue *proto.Account) (int, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + 1) > fm.buffer.Size() {
        return 0, errors.New("model is broken")
    }

    fbeHasValue := uint8(0)
    if fbeValue != nil {
        fbeHasValue = uint8(1)
    }
    fbe.WriteUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), fbeHasValue)
    if fbeHasValue == 0 {
        return 1, nil
    }

    fm.buffer.Shift(fm.FBEOffset() + 1)
    fbeResult, err := fm.value.Set(fbeValue)
    fm.buffer.Unshift(fm.FBEOffset() + 1)
    return 1 + fbeResult, err
}
