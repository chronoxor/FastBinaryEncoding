//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: proto.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package proto

import "errors"
import "../fbe"

// Fast Binary Encoding OrderType field model
type FieldModelOrderType struct {
    // Field model buffer
    buffer *fbe.Buffer
    // Field model buffer offset
    offset int
}

// Create a new OrderType field model
func NewFieldModelOrderType(buffer *fbe.Buffer, offset int) *FieldModelOrderType {
    return &FieldModelOrderType{buffer: buffer, offset: offset}
}

// Get the field size
func (fm *FieldModelOrderType) FBESize() int { return 1 }
// Get the field extra size
func (fm *FieldModelOrderType) FBEExtra() int { return 0 }

// Get the field offset
func (fm *FieldModelOrderType) FBEOffset() int { return fm.offset }
// Set the field offset
func (fm *FieldModelOrderType) SetFBEOffset(value int) { fm.offset = value }

// Shift the current field offset
func (fm *FieldModelOrderType) FBEShift(size int) { fm.offset += size }
// Unshift the current field offset
func (fm *FieldModelOrderType) FBEUnshift(size int) { fm.offset -= size }

// Check if the value is valid
func (fm *FieldModelOrderType) Verify() bool { return true }

// Get the value
func (fm *FieldModelOrderType) Get() (*OrderType, error) {
    var value OrderType
    return &value, fm.GetValueDefault(&value, OrderType(0))
}

// Get the value with provided default value
func (fm *FieldModelOrderType) GetDefault(defaults OrderType) (*OrderType, error) {
    var value OrderType
    err := fm.GetValueDefault(&value, defaults)
    return &value, err
}

// Get the value by the given pointer
func (fm *FieldModelOrderType) GetValue(value *OrderType) error {
    return fm.GetValueDefault(value, OrderType(0))
}

// Get the value by the given pointer with provided default value
func (fm *FieldModelOrderType) GetValueDefault(value *OrderType, defaults OrderType) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        *value = defaults
        return nil
    }

    *value = OrderType(fbe.ReadByte(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))
    return nil
}

// Set the value by the given pointer
func (fm *FieldModelOrderType) Set(value *OrderType) error {
    return fm.SetValue(*value)
}

// Set the value
func (fm *FieldModelOrderType) SetValue(value OrderType) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return errors.New("model is broken")
    }

    fbe.WriteByte(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), byte(value))
    return nil
}
