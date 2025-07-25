//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package test

import "errors"
import "../fbe"

// Fast Binary Encoding EnumTyped final model
type FinalModelEnumTyped struct {
    // Final model buffer
    buffer *fbe.Buffer
    // Final model buffer offset
    offset int
}

// Create a new EnumTyped final model
func NewFinalModelEnumTyped(buffer *fbe.Buffer, offset int) *FinalModelEnumTyped {
    return &FinalModelEnumTyped{buffer: buffer, offset: offset}
}

// Get the allocation size
func (fm *FinalModelEnumTyped) FBEAllocationSize(value *EnumTyped) int { return fm.FBESize() }

// Get the final size
func (fm *FinalModelEnumTyped) FBESize() int { return 1 }

// Get the final offset
func (fm *FinalModelEnumTyped) FBEOffset() int { return fm.offset }
// Set the final offset
func (fm *FinalModelEnumTyped) SetFBEOffset(value int) { fm.offset = value }

// Shift the current final offset
func (fm *FinalModelEnumTyped) FBEShift(size int) { fm.offset += size }
// Unshift the current final offset
func (fm *FinalModelEnumTyped) FBEUnshift(size int) { fm.offset -= size }

// Check if the value is valid
func (fm *FinalModelEnumTyped) Verify() int {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return fbe.MaxInt
    }

    return fm.FBESize()
}

// Get the value
func (fm *FinalModelEnumTyped) Get() (*EnumTyped, int, error) {
    var value EnumTyped
    size, err := fm.GetValueDefault(&value, EnumTyped(0))
    return &value, size, err
}

// Get the value with provided default value
func (fm *FinalModelEnumTyped) GetDefault(defaults EnumTyped) (*EnumTyped, int, error) {
    var value EnumTyped
    size, err := fm.GetValueDefault(&value, defaults)
    return &value, size, err
}

// Get the value by the given pointer
func (fm *FinalModelEnumTyped) GetValue(value *EnumTyped) (int, error) {
    return fm.GetValueDefault(value, EnumTyped(0))
}

// Get the value by the given pointer with provided default value
func (fm *FinalModelEnumTyped) GetValueDefault(value *EnumTyped, defaults EnumTyped) (int, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        *value = defaults
        return 0, errors.New("model is broken")
    }

    *value = EnumTyped(fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))
    return fm.FBESize(), nil
}

// Set the value by the given pointer
func (fm *FinalModelEnumTyped) Set(value *EnumTyped) (int, error) {
    return fm.SetValue(*value)
}

// Set the value
func (fm *FinalModelEnumTyped) SetValue(value EnumTyped) (int, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return 0, errors.New("model is broken")
    }

    fbe.WriteUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), uint8(value))
    return fm.FBESize(), nil
}
