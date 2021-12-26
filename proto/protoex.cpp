// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: protoex.fbe
// Version: 1.8.0.0

#include "protoex.h"

namespace protoex {

std::ostream& operator<<(std::ostream& stream, OrderSide value)
{
    if (value == OrderSide::buy) return stream << "buy";
    if (value == OrderSide::sell) return stream << "sell";
    if (value == OrderSide::tell) return stream << "tell";
    return stream << "<unknown>";
}

std::ostream& operator<<(std::ostream& stream, OrderType value)
{
    if (value == OrderType::market) return stream << "market";
    if (value == OrderType::limit) return stream << "limit";
    if (value == OrderType::stop) return stream << "stop";
    if (value == OrderType::stoplimit) return stream << "stoplimit";
    return stream << "<unknown>";
}

std::ostream& operator<<(std::ostream& stream, StateEx value)
{
    bool first = true;
    if ((value & StateEx::unknown) && ((value & StateEx::unknown) == StateEx::unknown))
    {
        stream << (first ? "" : "|") << "unknown";
        first = false;
    }
    if ((value & StateEx::invalid) && ((value & StateEx::invalid) == StateEx::invalid))
    {
        stream << (first ? "" : "|") << "invalid";
        first = false;
    }
    if ((value & StateEx::initialized) && ((value & StateEx::initialized) == StateEx::initialized))
    {
        stream << (first ? "" : "|") << "initialized";
        first = false;
    }
    if ((value & StateEx::calculated) && ((value & StateEx::calculated) == StateEx::calculated))
    {
        stream << (first ? "" : "|") << "calculated";
        first = false;
    }
    if ((value & StateEx::broken) && ((value & StateEx::broken) == StateEx::broken))
    {
        stream << (first ? "" : "|") << "broken";
        first = false;
    }
    if ((value & StateEx::happy) && ((value & StateEx::happy) == StateEx::happy))
    {
        stream << (first ? "" : "|") << "happy";
        first = false;
    }
    if ((value & StateEx::sad) && ((value & StateEx::sad) == StateEx::sad))
    {
        stream << (first ? "" : "|") << "sad";
        first = false;
    }
    if ((value & StateEx::good) && ((value & StateEx::good) == StateEx::good))
    {
        stream << (first ? "" : "|") << "good";
        first = false;
    }
    if ((value & StateEx::bad) && ((value & StateEx::bad) == StateEx::bad))
    {
        stream << (first ? "" : "|") << "bad";
        first = false;
    }
    return stream;
}

Order::Order()
    : id((int32_t)0ll)
    , symbol()
    , side()
    , type()
    , price((double)0.0)
    , volume((double)0.0)
    , tp((double)10.0)
    , sl((double)-10.0)
{}

Order::Order(int32_t arg_id, const std::string& arg_symbol, const ::protoex::OrderSide& arg_side, const ::protoex::OrderType& arg_type, double arg_price, double arg_volume, double arg_tp, double arg_sl)
    : id(arg_id)
    , symbol(arg_symbol)
    , side(arg_side)
    , type(arg_type)
    , price(arg_price)
    , volume(arg_volume)
    , tp(arg_tp)
    , sl(arg_sl)
{}

bool Order::operator==(const Order& other) const noexcept
{
    return (
        (id == other.id)
        );
}

bool Order::operator<(const Order& other) const noexcept
{
    if (id < other.id)
        return true;
    if (other.id < id)
        return false;
    return false;
}

void Order::swap(Order& other) noexcept
{
    using std::swap;
    swap(id, other.id);
    swap(symbol, other.symbol);
    swap(side, other.side);
    swap(type, other.type);
    swap(price, other.price);
    swap(volume, other.volume);
    swap(tp, other.tp);
    swap(sl, other.sl);
}

std::ostream& operator<<(std::ostream& stream, const Order& value)
{
    stream << "Order(";
    stream << "id="; stream << value.id;
    stream << ",symbol="; stream << "\"" << value.symbol << "\"";
    stream << ",side="; stream << value.side;
    stream << ",type="; stream << value.type;
    stream << ",price="; stream << value.price;
    stream << ",volume="; stream << value.volume;
    stream << ",tp="; stream << value.tp;
    stream << ",sl="; stream << value.sl;
    stream << ")";
    return stream;
}

Balance::Balance()
    : ::proto::Balance()
    , locked((double)0.0)
{}

Balance::Balance(const ::proto::Balance& base, double arg_locked)
    : ::proto::Balance(base)
    , locked(arg_locked)
{}

bool Balance::operator==(const Balance& other) const noexcept
{
    return (
        ::proto::Balance::operator==(other)
        && true
        );
}

bool Balance::operator<(const Balance& other) const noexcept
{
    if (::proto::Balance::operator<(other))
        return true;
    if (other.::proto::Balance::operator<(*this))
        return false;
    return false;
}

void Balance::swap(Balance& other) noexcept
{
    using std::swap;
    ::proto::Balance::swap(other);
    swap(locked, other.locked);
}

std::ostream& operator<<(std::ostream& stream, const Balance& value)
{
    stream << "Balance(";
    stream << (const ::proto::Balance&)value;
    stream << ",locked="; stream << value.locked;
    stream << ")";
    return stream;
}

Account::Account()
    : id((int32_t)0ll)
    , name()
    , state(StateEx::initialized  |  StateEx::bad  |  StateEx::sad)
    , wallet()
    , asset()
    , orders()
{}

Account::Account(int32_t arg_id, const std::string& arg_name, const ::protoex::StateEx& arg_state, const ::protoex::Balance& arg_wallet, const std::optional<::protoex::Balance>& arg_asset, const std::vector<::protoex::Order>& arg_orders)
    : id(arg_id)
    , name(arg_name)
    , state(arg_state)
    , wallet(arg_wallet)
    , asset(arg_asset)
    , orders(arg_orders)
{}

bool Account::operator==(const Account& other) const noexcept
{
    return (
        (id == other.id)
        );
}

bool Account::operator<(const Account& other) const noexcept
{
    if (id < other.id)
        return true;
    if (other.id < id)
        return false;
    return false;
}

void Account::swap(Account& other) noexcept
{
    using std::swap;
    swap(id, other.id);
    swap(name, other.name);
    swap(state, other.state);
    swap(wallet, other.wallet);
    swap(asset, other.asset);
    swap(orders, other.orders);
}

std::ostream& operator<<(std::ostream& stream, const Account& value)
{
    stream << "Account(";
    stream << "id="; stream << value.id;
    stream << ",name="; stream << "\"" << value.name << "\"";
    stream << ",state="; stream << value.state;
    stream << ",wallet="; stream << value.wallet;
    stream << ",asset="; if (value.asset) stream << *value.asset; else stream << "null";
    {
        bool first = true;
        stream << ",orders=[" << value.orders.size() << "][";
        for (const auto& it : value.orders)
        {
            stream << std::string(first ? "" : ",") << it;
            first = false;
        }
        stream << "]";
    }
    stream << ")";
    return stream;
}

OrderMessage::OrderMessage()
    : body()
{}

OrderMessage::OrderMessage(const ::protoex::Order& arg_body)
    : body(arg_body)
{}

bool OrderMessage::operator==(const OrderMessage& other) const noexcept
{
    return (
        true
        );
}

bool OrderMessage::operator<(const OrderMessage& other) const noexcept
{
    return false;
}

void OrderMessage::swap(OrderMessage& other) noexcept
{
    using std::swap;
    swap(body, other.body);
}

std::ostream& operator<<(std::ostream& stream, const OrderMessage& value)
{
    stream << "OrderMessage(";
    stream << "body="; stream << value.body;
    stream << ")";
    return stream;
}

BalanceMessage::BalanceMessage()
    : body()
{}

BalanceMessage::BalanceMessage(const ::protoex::Balance& arg_body)
    : body(arg_body)
{}

bool BalanceMessage::operator==(const BalanceMessage& other) const noexcept
{
    return (
        true
        );
}

bool BalanceMessage::operator<(const BalanceMessage& other) const noexcept
{
    return false;
}

void BalanceMessage::swap(BalanceMessage& other) noexcept
{
    using std::swap;
    swap(body, other.body);
}

std::ostream& operator<<(std::ostream& stream, const BalanceMessage& value)
{
    stream << "BalanceMessage(";
    stream << "body="; stream << value.body;
    stream << ")";
    return stream;
}

AccountMessage::AccountMessage()
    : body()
{}

AccountMessage::AccountMessage(const ::protoex::Account& arg_body)
    : body(arg_body)
{}

bool AccountMessage::operator==(const AccountMessage& other) const noexcept
{
    return (
        true
        );
}

bool AccountMessage::operator<(const AccountMessage& other) const noexcept
{
    return false;
}

void AccountMessage::swap(AccountMessage& other) noexcept
{
    using std::swap;
    swap(body, other.body);
}

std::ostream& operator<<(std::ostream& stream, const AccountMessage& value)
{
    stream << "AccountMessage(";
    stream << "body="; stream << value.body;
    stream << ")";
    return stream;
}

} // namespace protoex
