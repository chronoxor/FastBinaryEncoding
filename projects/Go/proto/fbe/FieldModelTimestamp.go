// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: FBE
// Version: 1.8.0.0

package fbe

import "errors"

// Fast Binary Encoding timestamp field model
type FieldModelTimestamp struct {
    // Field model buffer
    buffer *Buffer
    // Field model buffer offset
    offset int
}

// Create a new timestamp field model
func NewFieldModelTimestamp(buffer *Buffer, offset int) *FieldModelTimestamp {
    return &FieldModelTimestamp{buffer: buffer, offset: offset}
}

// Get the field size
func (fm *FieldModelTimestamp) FBESize() int { return 8 }
// Get the field extra size
func (fm *FieldModelTimestamp) FBEExtra() int { return 0 }

// Get the field offset
func (fm *FieldModelTimestamp) FBEOffset() int { return fm.offset }
// Set the field offset
func (fm *FieldModelTimestamp) SetFBEOffset(value int) { fm.offset = value }

// Shift the current field offset
func (fm *FieldModelTimestamp) FBEShift(size int) { fm.offset += size }
// Unshift the current field offset
func (fm *FieldModelTimestamp) FBEUnshift(size int) { fm.offset -= size }

// Check if the timestamp value is valid
func (fm *FieldModelTimestamp) Verify() bool { return true }

// Get the timestamp value
func (fm *FieldModelTimestamp) Get() (Timestamp, error) {
    return fm.GetDefault(TimestampEpoch())
}

// Get the timestamp value with provided default value
func (fm *FieldModelTimestamp) GetDefault(defaults Timestamp) (Timestamp, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return defaults, nil
    }

    return ReadTimestamp(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()), nil
}

// Set the timestamp value
func (fm *FieldModelTimestamp) Set(value Timestamp) error {
    if (fm.buffer.Offset() + fm.FBEOffset() + fm.FBESize()) > fm.buffer.Size() {
        return errors.New("model is broken")
    }

    WriteTimestamp(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), value)
    return nil
}
