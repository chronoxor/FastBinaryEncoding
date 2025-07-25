//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: proto.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

#include "proto_final_models.h"

namespace FBE {

FinalModel<::proto::Order>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , id(buffer, 0)
    , symbol(buffer, 0)
    , side(buffer, 0)
    , type(buffer, 0)
    , price(buffer, 0)
    , volume(buffer, 0)
{}

size_t FinalModel<::proto::Order>::fbe_allocation_size(const ::proto::Order& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + id.fbe_allocation_size(fbe_value.id)
        + symbol.fbe_allocation_size(fbe_value.symbol)
        + side.fbe_allocation_size(fbe_value.side)
        + type.fbe_allocation_size(fbe_value.type)
        + price.fbe_allocation_size(fbe_value.price)
        + volume.fbe_allocation_size(fbe_value.volume)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::Order>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Order>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    symbol.fbe_offset(fbe_current_offset);
    fbe_field_size = symbol.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    side.fbe_offset(fbe_current_offset);
    fbe_field_size = side.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    type.fbe_offset(fbe_current_offset);
    fbe_field_size = type.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    price.fbe_offset(fbe_current_offset);
    fbe_field_size = price.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    volume.fbe_offset(fbe_current_offset);
    fbe_field_size = volume.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::Order>::get(::proto::Order& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Order>::get_fields(::proto::Order& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.get(fbe_value.id);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    symbol.fbe_offset(fbe_current_offset);
    fbe_field_size = symbol.get(fbe_value.symbol);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    side.fbe_offset(fbe_current_offset);
    fbe_field_size = side.get(fbe_value.side);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    type.fbe_offset(fbe_current_offset);
    fbe_field_size = type.get(fbe_value.type);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    price.fbe_offset(fbe_current_offset);
    fbe_field_size = price.get(fbe_value.price);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    volume.fbe_offset(fbe_current_offset);
    fbe_field_size = volume.get(fbe_value.volume);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::Order>::set(const ::proto::Order& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Order>::set_fields(const ::proto::Order& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.set(fbe_value.id);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    symbol.fbe_offset(fbe_current_offset);
    fbe_field_size = symbol.set(fbe_value.symbol);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    side.fbe_offset(fbe_current_offset);
    fbe_field_size = side.set(fbe_value.side);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    type.fbe_offset(fbe_current_offset);
    fbe_field_size = type.set(fbe_value.type);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    price.fbe_offset(fbe_current_offset);
    fbe_field_size = price.set(fbe_value.price);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    volume.fbe_offset(fbe_current_offset);
    fbe_field_size = volume.set(fbe_value.volume);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool OrderFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t OrderFinalModel::serialize(const ::proto::Order& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t OrderFinalModel::deserialize(::proto::Order& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

FinalModel<::proto::Balance>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , currency(buffer, 0)
    , amount(buffer, 0)
{}

size_t FinalModel<::proto::Balance>::fbe_allocation_size(const ::proto::Balance& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + currency.fbe_allocation_size(fbe_value.currency)
        + amount.fbe_allocation_size(fbe_value.amount)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::Balance>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Balance>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    currency.fbe_offset(fbe_current_offset);
    fbe_field_size = currency.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    amount.fbe_offset(fbe_current_offset);
    fbe_field_size = amount.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::Balance>::get(::proto::Balance& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Balance>::get_fields(::proto::Balance& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    currency.fbe_offset(fbe_current_offset);
    fbe_field_size = currency.get(fbe_value.currency);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    amount.fbe_offset(fbe_current_offset);
    fbe_field_size = amount.get(fbe_value.amount);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::Balance>::set(const ::proto::Balance& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Balance>::set_fields(const ::proto::Balance& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    currency.fbe_offset(fbe_current_offset);
    fbe_field_size = currency.set(fbe_value.currency);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    amount.fbe_offset(fbe_current_offset);
    fbe_field_size = amount.set(fbe_value.amount);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool BalanceFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t BalanceFinalModel::serialize(const ::proto::Balance& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t BalanceFinalModel::deserialize(::proto::Balance& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

FinalModel<::proto::Account>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , id(buffer, 0)
    , name(buffer, 0)
    , state(buffer, 0)
    , wallet(buffer, 0)
    , asset(buffer, 0)
    , orders(buffer, 0)
{}

size_t FinalModel<::proto::Account>::fbe_allocation_size(const ::proto::Account& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + id.fbe_allocation_size(fbe_value.id)
        + name.fbe_allocation_size(fbe_value.name)
        + state.fbe_allocation_size(fbe_value.state)
        + wallet.fbe_allocation_size(fbe_value.wallet)
        + asset.fbe_allocation_size(fbe_value.asset)
        + orders.fbe_allocation_size(fbe_value.orders)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::Account>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Account>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    name.fbe_offset(fbe_current_offset);
    fbe_field_size = name.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    state.fbe_offset(fbe_current_offset);
    fbe_field_size = state.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    wallet.fbe_offset(fbe_current_offset);
    fbe_field_size = wallet.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    asset.fbe_offset(fbe_current_offset);
    fbe_field_size = asset.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    orders.fbe_offset(fbe_current_offset);
    fbe_field_size = orders.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::Account>::get(::proto::Account& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Account>::get_fields(::proto::Account& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.get(fbe_value.id);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    name.fbe_offset(fbe_current_offset);
    fbe_field_size = name.get(fbe_value.name);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    state.fbe_offset(fbe_current_offset);
    fbe_field_size = state.get(fbe_value.state);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    wallet.fbe_offset(fbe_current_offset);
    fbe_field_size = wallet.get(fbe_value.wallet);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    asset.fbe_offset(fbe_current_offset);
    fbe_field_size = asset.get(fbe_value.asset);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    orders.fbe_offset(fbe_current_offset);
    fbe_field_size = orders.get(fbe_value.orders);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::Account>::set(const ::proto::Account& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::Account>::set_fields(const ::proto::Account& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    id.fbe_offset(fbe_current_offset);
    fbe_field_size = id.set(fbe_value.id);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    name.fbe_offset(fbe_current_offset);
    fbe_field_size = name.set(fbe_value.name);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    state.fbe_offset(fbe_current_offset);
    fbe_field_size = state.set(fbe_value.state);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    wallet.fbe_offset(fbe_current_offset);
    fbe_field_size = wallet.set(fbe_value.wallet);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    asset.fbe_offset(fbe_current_offset);
    fbe_field_size = asset.set(fbe_value.asset);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    orders.fbe_offset(fbe_current_offset);
    fbe_field_size = orders.set(fbe_value.orders);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool AccountFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t AccountFinalModel::serialize(const ::proto::Account& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t AccountFinalModel::deserialize(::proto::Account& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

FinalModel<::proto::OrderMessage>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , body(buffer, 0)
{}

size_t FinalModel<::proto::OrderMessage>::fbe_allocation_size(const ::proto::OrderMessage& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + body.fbe_allocation_size(fbe_value.body)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::OrderMessage>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::OrderMessage>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::OrderMessage>::get(::proto::OrderMessage& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::OrderMessage>::get_fields(::proto::OrderMessage& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.get(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::OrderMessage>::set(const ::proto::OrderMessage& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::OrderMessage>::set_fields(const ::proto::OrderMessage& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.set(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool OrderMessageFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t OrderMessageFinalModel::serialize(const ::proto::OrderMessage& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t OrderMessageFinalModel::deserialize(::proto::OrderMessage& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

FinalModel<::proto::BalanceMessage>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , body(buffer, 0)
{}

size_t FinalModel<::proto::BalanceMessage>::fbe_allocation_size(const ::proto::BalanceMessage& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + body.fbe_allocation_size(fbe_value.body)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::BalanceMessage>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::BalanceMessage>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::BalanceMessage>::get(::proto::BalanceMessage& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::BalanceMessage>::get_fields(::proto::BalanceMessage& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.get(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::BalanceMessage>::set(const ::proto::BalanceMessage& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::BalanceMessage>::set_fields(const ::proto::BalanceMessage& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.set(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool BalanceMessageFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t BalanceMessageFinalModel::serialize(const ::proto::BalanceMessage& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t BalanceMessageFinalModel::deserialize(::proto::BalanceMessage& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

FinalModel<::proto::AccountMessage>::FinalModel(FBEBuffer& buffer, size_t offset) noexcept : _buffer(buffer), _offset(offset)
    , body(buffer, 0)
{}

size_t FinalModel<::proto::AccountMessage>::fbe_allocation_size(const ::proto::AccountMessage& fbe_value) const noexcept
{
    size_t fbe_result = 0
        + body.fbe_allocation_size(fbe_value.body)
        ;
    return fbe_result;
}

size_t FinalModel<::proto::AccountMessage>::verify() const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = verify_fields();
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::AccountMessage>::verify_fields() const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.verify();
    if (fbe_field_size == std::numeric_limits<std::size_t>::max())
        return std::numeric_limits<std::size_t>::max();
    fbe_current_offset += fbe_field_size;

    return fbe_current_offset;
}

size_t FinalModel<::proto::AccountMessage>::get(::proto::AccountMessage& fbe_value) const noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = get_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::AccountMessage>::get_fields(::proto::AccountMessage& fbe_value) const noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.get(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

size_t FinalModel<::proto::AccountMessage>::set(const ::proto::AccountMessage& fbe_value) noexcept
{
    _buffer.shift(fbe_offset());
    size_t fbe_result = set_fields(fbe_value);
    _buffer.unshift(fbe_offset());
    return fbe_result;
}

size_t FinalModel<::proto::AccountMessage>::set_fields(const ::proto::AccountMessage& fbe_value) noexcept
{
    size_t fbe_current_offset = 0;
    size_t fbe_current_size = 0;
    size_t fbe_field_size;

    body.fbe_offset(fbe_current_offset);
    fbe_field_size = body.set(fbe_value.body);
    fbe_current_offset += fbe_field_size;
    fbe_current_size += fbe_field_size;

    return fbe_current_size;
}

namespace proto {

bool AccountMessageFinalModel::verify()
{
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return false;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return false;

    return ((8 + _model.verify()) == fbe_struct_size);
}

size_t AccountMessageFinalModel::serialize(const ::proto::AccountMessage& value)
{
    size_t fbe_initial_size = this->buffer().size();

    uint32_t fbe_struct_type = (uint32_t)fbe_type();
    uint32_t fbe_struct_size = (uint32_t)(8 + _model.fbe_allocation_size(value));
    uint32_t fbe_struct_offset = (uint32_t)(this->buffer().allocate(fbe_struct_size) - this->buffer().offset());
    assert(((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + fbe_struct_offset + fbe_struct_size) > this->buffer().size())
        return 0;

    fbe_struct_size = (uint32_t)(8 + _model.set(value));
    this->buffer().resize(fbe_initial_size + fbe_struct_size);

    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8)) = fbe_struct_size;
    *((uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4)) = fbe_struct_type;

    return fbe_struct_size;
}

size_t AccountMessageFinalModel::deserialize(::proto::AccountMessage& value) const noexcept
{
    assert(((this->buffer().offset() + _model.fbe_offset()) <= this->buffer().size()) && "Model is broken!");
    if ((this->buffer().offset() + _model.fbe_offset()) > this->buffer().size())
        return 0;

    size_t fbe_struct_size = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 8));
    size_t fbe_struct_type = *((const uint32_t*)(this->buffer().data() + this->buffer().offset() + _model.fbe_offset() - 4));
    assert(((fbe_struct_size > 0) && (fbe_struct_type == fbe_type())) && "Model is broken!");
    if ((fbe_struct_size == 0) || (fbe_struct_type != fbe_type()))
        return 8;

    return 8 + _model.get(value);
}

} // namespace proto

} // namespace FBE
