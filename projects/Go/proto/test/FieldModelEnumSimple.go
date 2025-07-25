//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package test

import "errors"
import "../fbe"

// Fast Binary Encoding EnumSimple field model
type FieldModelEnumSimple struct {
    // Field model buffer
    buffer *fbe.Buffer
    // Field model buffer offset
    offset int
}

// Create a new EnumSimple field model
func NewFieldModelEnumSimple(buffer *fbe.Buffer, offset int) *FieldModelEnumSimple {
    return &FieldModelEnumSimple{buffer: buffer, offset: offset}
}

// Get the field size
func (fm *FieldModelEnumSimple) FBESize() int { return 4 }
// Get the field extra size
func (fm *FieldModelEnumSimple) FBEExtra() int { return 0 }

// Get the field offset
func (fm *FieldModelEnumSimple) FBEOffset() int { return fm.offset }
// Set the field offset
func (fm *FieldModelEnumSimple) SetFBEOffset(value int) { fm.offset = value }

// Shift the current field offset
func (fm *FieldModelEnumSimple) FBEShift(size int) { fm.offset += size }
// Unshift the current field offset
func (fm *FieldModelEnumSimple) FBEUnshift(size int) { fm.offset -= size }

// Check if the value is valid
func (fm *FieldModelEnumSimple) Verify() bool { return true }

// Get the value
func (fm *FieldModelEnumSimple) Get() (*EnumSimple, error) {
    var value EnumSimple
    return &value, fm.GetValueDefault(&value, EnumSimple(0))
}

// Get the value with provided default value
func (fm *FieldModelEnumSimple) GetDefault(defaults EnumSimple) (*EnumSimple, error) {
    var value EnumSimple
    err := fm.GetValueDefault(&value, defaults)
    return &value, err
}

// Get the value by the given pointer
func (fm *FieldModelEnumSimple) GetValue(value *EnumSimple) error {
    return fm.GetValueDefault(value, EnumSimple(0))
}

// Get the value by the given pointer with provided default value
func (fm *FieldModelEnumSimple) GetValueDefault(value *EnumSimple, defaults EnumSimple) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        *value = defaults
        return nil
    }

    *value = EnumSimple(fbe.ReadInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))
    return nil
}

// Set the value by the given pointer
func (fm *FieldModelEnumSimple) Set(value *EnumSimple) error {
    return fm.SetValue(*value)
}

// Set the value
func (fm *FieldModelEnumSimple) SetValue(value EnumSimple) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return errors.New("model is broken")
    }

    fbe.WriteInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), int32(value))
    return nil
}
