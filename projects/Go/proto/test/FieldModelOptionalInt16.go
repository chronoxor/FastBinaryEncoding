// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: FBE
// Version: 1.8.0.0

package test

import "errors"
import "../fbe"
import "../proto"

// Workaround for Go unused imports issue
var _ = errors.New
var _ = fbe.Version
var _ = proto.Version

// Fast Binary Encoding optional Int16 field model
type FieldModelOptionalInt16 struct {
    // Field model buffer
    buffer *fbe.Buffer
    // Field model buffer offset
    offset int

    // Base field model value
    value *fbe.FieldModelInt16
}

// Create a new optional Int16 field model
func NewFieldModelOptionalInt16(buffer *fbe.Buffer, offset int) *FieldModelOptionalInt16 {
    fbeResult := FieldModelOptionalInt16{buffer: buffer, offset: offset}
    fbeResult.value = fbe.NewFieldModelInt16(buffer, 0)
    return &fbeResult
}

// Get the optional field model value
func (fm *FieldModelOptionalInt16) Value() *fbe.FieldModelInt16 { return fm.value }

// Get the field size
func (fm *FieldModelOptionalInt16) FBESize() int { return 1 + 4 }

// Get the field extra size
func (fm *FieldModelOptionalInt16) FBEExtra() int {
    if !fm.HasValue() {
        return 0
    }

    fbeOptionalOffset := int(fbe.ReadUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset() + 1))
    if (fbeOptionalOffset == 0) || ((fm.buffer.Offset() + fbeOptionalOffset + 4) > fm.buffer.Size()) {
        return 0
    }

    fm.buffer.Shift(fbeOptionalOffset)
    fbeResult := fm.value.FBESize() + fm.value.FBEExtra()
    fm.buffer.Unshift(fbeOptionalOffset)
    return fbeResult
}

// Get the field offset
func (fm *FieldModelOptionalInt16) FBEOffset() int { return fm.offset }
// Set the field offset
func (fm *FieldModelOptionalInt16) SetFBEOffset(value int) { fm.offset = value }

// Shift the current field offset
func (fm *FieldModelOptionalInt16) FBEShift(size int) { fm.offset += size }
// Unshift the current field offset
func (fm *FieldModelOptionalInt16) FBEUnshift(size int) { fm.offset -= size }

// Check if the object contains a value
func (fm *FieldModelOptionalInt16) HasValue() bool {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return false
    }

    fbeHasValue := fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset())
    return fbeHasValue != 0
}

// Check if the optional value is valid
func (fm *FieldModelOptionalInt16) Verify() bool {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return true
    }

    fbeHasValue := fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset())
    if fbeHasValue == 0 {
        return true
    }

    fbeOptionalOffset := int(fbe.ReadUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset() + 1))
    if fbeOptionalOffset == 0 {
        return false
    }

    fm.buffer.Shift(fbeOptionalOffset)
    fbeResult := fm.value.Verify()
    fm.buffer.Unshift(fbeOptionalOffset)
    return fbeResult
}

// Get the optional value (being phase)
func (fm *FieldModelOptionalInt16) GetBegin() (int, error) {
    if !fm.HasValue() {
        return 0, nil
    }

    fbeOptionalOffset := int(fbe.ReadUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset() + 1))
    if fbeOptionalOffset <= 0 {
        return 0, errors.New("model is broken")
    }

    fm.buffer.Shift(fbeOptionalOffset)
    return fbeOptionalOffset, nil
}

// Get the optional value (end phase)
func (fm *FieldModelOptionalInt16) GetEnd(fbeBegin int) {
    fm.buffer.Unshift(fbeBegin)
}

// Get the optional value
func (fm *FieldModelOptionalInt16) Get() (*int16, error) {
    var fbeValue *int16 = nil

    fbeBegin, err := fm.GetBegin()
    if fbeBegin == 0 {
        return fbeValue, err
    }

    fbeValue = fbe.OptionalInt16(0)

    *fbeValue, err = fm.value.Get()
    fm.GetEnd(fbeBegin)
    return fbeValue, err
}

// Set the optional value (begin phase)
func (fm *FieldModelOptionalInt16) SetBegin(hasValue bool) (int, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return 0, nil
    }

    fbeHasValue := uint8(0)
    if hasValue {
        fbeHasValue = uint8(1)
    }
    fbe.WriteUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), fbeHasValue)
    if fbeHasValue == 0 {
        return 0, nil
    }

    fbeOptionalSize := fm.value.FBESize()
    fbeOptionalOffset := fm.buffer.Allocate(fbeOptionalSize) - fm.buffer.Offset()
    if (fbeOptionalOffset <= 0) || ((fm.buffer.Offset() + fbeOptionalOffset + fbeOptionalSize) > fm.buffer.Size()) {
        return 0, errors.New("model is broken")
    }

    fbe.WriteUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset() + 1, uint32(fbeOptionalOffset))

    fm.buffer.Shift(fbeOptionalOffset)
    return fbeOptionalOffset, nil
}

// Set the optional value (end phase)
func (fm *FieldModelOptionalInt16) SetEnd(fbeBegin int) {
    fm.buffer.Unshift(fbeBegin)
}

// Set the optional value
func (fm *FieldModelOptionalInt16) Set(fbeValue *int16) error {
    fbeBegin, err := fm.SetBegin(fbeValue != nil)
    if fbeBegin == 0 {
        return err
    }

    err = fm.value.Set(*fbeValue)
    fm.SetEnd(fbeBegin)
    return err
}
