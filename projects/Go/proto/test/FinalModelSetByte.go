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

// Fast Binary Encoding Byte set final model
type FinalModelSetByte struct {
    // Final model buffer
    buffer *fbe.Buffer
    // Final model buffer offset
    offset int

    // Set item final model
    model *fbe.FinalModelByte
}

// Create a new Byte set final model
func NewFinalModelSetByte(buffer *fbe.Buffer, offset int) *FinalModelSetByte {
    fbeResult := FinalModelSetByte{buffer: buffer, offset: offset}
    fbeResult.model = fbe.NewFinalModelByte(buffer, offset)
    return &fbeResult
}

// Get the allocation size
func (fm *FinalModelSetByte) FBEAllocationSize(values map[byte]byte) int {
    size := 4
    for _, value := range values {
        size += fm.model.FBEAllocationSize(value)
    }
    return size
}

// Get the final offset
func (fm *FinalModelSetByte) FBEOffset() int { return fm.offset }
// Set the final offset
func (fm *FinalModelSetByte) SetFBEOffset(value int) { fm.offset = value }

// Shift the current final offset
func (fm *FinalModelSetByte) FBEShift(size int) { fm.offset += size }
// Unshift the current final offset
func (fm *FinalModelSetByte) FBEUnshift(size int) { fm.offset -= size }

// Check if the set value is valid
func (fm *FinalModelSetByte) Verify() int {
    if (fm.buffer.Offset() + fm.FBEOffset() + 4) > fm.buffer.Size() {
        return fbe.MaxInt
    }

    fbeSetSize := int(fbe.ReadUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))

    size := 4
    fm.model.SetFBEOffset(fm.FBEOffset() + 4)
    for i := fbeSetSize; i > 0; i-- {
        offset := fm.model.Verify()
        if offset == fbe.MaxInt {
            return fbe.MaxInt
        }
        fm.model.FBEShift(offset)
        size += offset
    }
    return size
}

// Get the set value
func (fm *FinalModelSetByte) Get() (map[byte]byte, int, error) {
    values := make(map[byte]byte)

    if (fm.buffer.Offset() + fm.FBEOffset() + 4) > fm.buffer.Size() {
        return values, 0, errors.New("model is broken")
    }

    fbeSetSize := int(fbe.ReadUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset()))
    if fbeSetSize == 0 {
        return values, 4, nil
    }

    size := 4
    fm.model.SetFBEOffset(fm.FBEOffset() + 4)
    for i := 0; i < fbeSetSize; i++ {
        value, offset, err := fm.model.Get()
        if err != nil {
            return values, size, err
        }
        values[value] = value
        fm.model.FBEShift(offset)
        size += offset
    }
    return values, size, nil
}

// Set the set value
func (fm *FinalModelSetByte) Set(values map[byte]byte) (int, error) {
    if (fm.buffer.Offset() + fm.FBEOffset() + 4) > fm.buffer.Size() {
        return 0, errors.New("model is broken")
    }

    fbe.WriteUInt32(fm.buffer.Data(), fm.buffer.Offset() + fm.FBEOffset(), uint32(len(values)))

    size := 4
    fm.model.SetFBEOffset(fm.FBEOffset() + 4)
    for _, value := range values {
        offset, err := fm.model.Set(value)
        if err != nil {
            return size, err
        }
        fm.model.FBEShift(offset)
        size += offset
    }
    return size, nil
}
