//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
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

// Fast Binary Encoding StructEmpty final model
type FinalModelStructEmpty struct {
    buffer *fbe.Buffer  // Final model buffer
    offset int          // Final model buffer offset
}

// Create a new StructEmpty final model
func NewFinalModelStructEmpty(buffer *fbe.Buffer, offset int) *FinalModelStructEmpty {
    fbeResult := FinalModelStructEmpty{buffer: buffer, offset: offset}
    return &fbeResult
}

// Get the allocation size
func (fm *FinalModelStructEmpty) FBEAllocationSize(fbeValue *StructEmpty) int {
    fbeResult := 0 +
        0
    return fbeResult
}

// Get the final size
func (fm *FinalModelStructEmpty) FBESize() int { return 0 }

// Get the final extra size
func (fm *FinalModelStructEmpty) FBEExtra() int { return 0 }

// Get the final type
func (fm *FinalModelStructEmpty) FBEType() int { return 143 }

// Get the final offset
func (fm *FinalModelStructEmpty) FBEOffset() int { return fm.offset }
// Set the final offset
func (fm *FinalModelStructEmpty) SetFBEOffset(value int) { fm.offset = value }

// Shift the current final offset
func (fm *FinalModelStructEmpty) FBEShift(size int) { fm.offset += size }
// Unshift the current final offset
func (fm *FinalModelStructEmpty) FBEUnshift(size int) { fm.offset -= size }

// Check if the struct value is valid
func (fm *FinalModelStructEmpty) Verify() int {
    fm.buffer.Shift(fm.FBEOffset())
    fbeResult := fm.VerifyFields()
    fm.buffer.Unshift(fm.FBEOffset())
    return fbeResult
}

// Check if the struct fields are valid
func (fm *FinalModelStructEmpty) VerifyFields() int {
    return 0
}

// Get the struct value
func (fm *FinalModelStructEmpty) Get() (*StructEmpty, int, error) {
    fbeResult := NewStructEmpty()
    fbeSize, err := fm.GetValue(fbeResult)
    return fbeResult, fbeSize, err
}

// Get the struct value by the given pointer
func (fm *FinalModelStructEmpty) GetValue(fbeValue *StructEmpty) (int, error) {
    fm.buffer.Shift(fm.FBEOffset())
    fbeSize, err := fm.GetFields(fbeValue)
    fm.buffer.Unshift(fm.FBEOffset())
    return fbeSize, err
}

// Get the struct fields values
func (fm *FinalModelStructEmpty) GetFields(fbeValue *StructEmpty) (int, error) {
    return 0, nil
}

// Set the struct value
func (fm *FinalModelStructEmpty) Set(fbeValue *StructEmpty) (int, error) {
    fm.buffer.Shift(fm.FBEOffset())
    fbeResult, err := fm.SetFields(fbeValue)
    fm.buffer.Unshift(fm.FBEOffset())
    return fbeResult, err
}

// Set the struct fields values
func (fm *FinalModelStructEmpty) SetFields(fbeValue *StructEmpty) (int, error) {
    return 0, nil
}
