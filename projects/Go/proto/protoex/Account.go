//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: protoex.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

package protoex

import "fmt"
import "strconv"
import "strings"
import "errors"
import "../fbe"
import "../proto"

// Workaround for Go unused imports issue
var _ = errors.New
var _ = fbe.Version
var _ = proto.Version

// Workaround for Go unused imports issue
var _ = fmt.Print
var _ = strconv.FormatInt

// Account key
type AccountKey struct {
    Id int32
}

// Convert Account flags key to string
func (k *AccountKey) String() string {
    var sb strings.Builder
    sb.WriteString("AccountKey(")
    sb.WriteString("id=")
    sb.WriteString(strconv.FormatInt(int64(k.Id), 10))
    sb.WriteString(")")
    return sb.String()
}

// Account struct
type Account struct {
    Id int32 `json:"id"`
    Name string `json:"name"`
    State StateEx `json:"state"`
    Wallet Balance `json:"wallet"`
    Asset *Balance `json:"asset"`
    Orders []Order `json:"orders"`
}

// Create a new Account struct
func NewAccount() *Account {
    return &Account{
        Id: 0,
        Name: "",
        State: StateEx_initialized | StateEx_bad | StateEx_sad,
        Wallet: *NewBalance(),
        Asset: nil,
        Orders: make([]Order, 0),
    }
}

// Create a new Account struct from the given field values
func NewAccountFromFieldValues(Id int32, Name string, State StateEx, Wallet Balance, Asset *Balance, Orders []Order) *Account {
    return &Account{Id, Name, State, Wallet, Asset, Orders}
}

// Create a new Account struct from JSON
func NewAccountFromJSON(buffer []byte) (*Account, error) {
    result := *NewAccount()
    err := fbe.Json.Unmarshal(buffer, &result)
    if err != nil {
        return nil, err
    }
    return &result, nil
}

// Struct shallow copy
func (s *Account) Copy() *Account {
    var result = *s
    return &result
}

// Struct deep clone
func (s *Account) Clone() *Account {
    // Serialize the struct to the FBE stream
    writer := NewAccountModel(fbe.NewEmptyBuffer())
    _, _ = writer.Serialize(s)

    // Deserialize the struct from the FBE stream
    reader := NewAccountModel(writer.Buffer())
    result, _, _ := reader.Deserialize()
    return result
}

// Get the struct key
func (s *Account) Key() AccountKey {
    return AccountKey{
        Id: s.Id,
    }
}

// Convert struct to optional
func (s *Account) Optional() *Account {
    return s
}

// Get the FBE type
func (s *Account) FBEType() int { return 3 }

// Convert struct to string
func (s *Account) String() string {
    var sb strings.Builder
    sb.WriteString("Account(")
    sb.WriteString("id=")
    sb.WriteString(strconv.FormatInt(int64(s.Id), 10))
    sb.WriteString(",name=")
    sb.WriteString("\"" + s.Name + "\"")
    sb.WriteString(",state=")
    sb.WriteString(s.State.String())
    sb.WriteString(",wallet=")
    sb.WriteString(s.Wallet.String())
    sb.WriteString(",asset=")
    if s.Asset != nil { 
        sb.WriteString(s.Asset.String())
    } else {
        sb.WriteString("null")
    }
    sb.WriteString(",orders=")
    if s.Orders != nil {
        first := true
        sb.WriteString("[" + strconv.FormatInt(int64(len(s.Orders)), 10) + "][")
        for _, v := range s.Orders {
            if first { sb.WriteString("") } else { sb.WriteString(",") }
            sb.WriteString(v.String())
            first = false
        }
        sb.WriteString("]")
    } else {
        sb.WriteString(",orders=[0][]")
    }
    sb.WriteString(")")
    return sb.String()
}

// Convert struct to JSON
func (s *Account) JSON() ([]byte, error) {
    return fbe.Json.Marshal(s)
}
