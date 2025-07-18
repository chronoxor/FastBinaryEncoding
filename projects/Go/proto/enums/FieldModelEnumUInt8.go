//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package enums

import "errors"
import "../fbe"

// Fast Binary Encoding EnumUInt8 field model
type FieldModelEnumUInt8 struct {
    // Field model buffer
    buffer *fbe.Buffer
    // Field model buffer offset
    offset int
}

// Create a new EnumUInt8 field model
func NewFieldModelEnumUInt8(buffer *fbe.Buffer, offset int) *FieldModelEnumUInt8 {
    return &FieldModelEnumUInt8{buffer: buffer, offset: offset}
}

// Get the field size
func (fm *FieldModelEnumUInt8) FBESize() int { return 1 }
// Get the field extra size
func (fm *FieldModelEnumUInt8) FBEExtra() int { return 0 }

// Get the field offset
func (fm *FieldModelEnumUInt8) FBEOffset() int { return fm.offset }
// Set the field offset
func (fm *FieldModelEnumUInt8) SetFBEOffset(value int) { fm.offset = value }

// Shift the current field offset
func (fm *FieldModelEnumUInt8) FBEShift(size int) { fm.offset += size }
// Unshift the current field offset
func (fm *FieldModelEnumUInt8) FBEUnshift(size int) { fm.offset -= size }

// Check if the value is valid
func (fm *FieldModelEnumUInt8) Verify() bool { return true }

// Get the value
func (fm *FieldModelEnumUInt8) Get() (*EnumUInt8, error) {
    var value EnumUInt8
    return &value, fm.GetValueDefault(&value, EnumUInt8(0))
}

// Get the value with provided default value
func (fm *FieldModelEnumUInt8) GetDefault(defaults EnumUInt8) (*EnumUInt8, error) {
    var value EnumUInt8
    err := fm.GetValueDefault(&value, defaults)
    return &value, err
}

// Get the value by the given pointer
func (fm *FieldModelEnumUInt8) GetValue(value *EnumUInt8) error {
    return fm.GetValueDefault(value, EnumUInt8(0))
}

// Get the value by the given pointer with provided default value
func (fm *FieldModelEnumUInt8) GetValueDefault(value *EnumUInt8, defaults EnumUInt8) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        *value = defaults
        return nil
    }

    *value = EnumUInt8(fbe.ReadUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))
    return nil
}

// Set the value by the given pointer
func (fm *FieldModelEnumUInt8) Set(value *EnumUInt8) error {
    return fm.SetValue(*value)
}

// Set the value
func (fm *FieldModelEnumUInt8) SetValue(value EnumUInt8) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return errors.New("model is broken")
    }

    fbe.WriteUInt8(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), uint8(value))
    return nil
}
