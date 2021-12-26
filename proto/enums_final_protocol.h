// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.8.0.0

#pragma once

#if defined(__clang__)
#pragma clang system_header
#elif defined(__GNUC__)
#pragma GCC system_header
#elif defined(_MSC_VER)
#pragma system_header
#endif

#include "fbe_protocol.h"

#include "enums_final_models.h"

namespace FBE {

namespace enums {

// Fast Binary Encoding enums protocol version
struct ProtocolVersion
{
    // Protocol major version
    static const int major = 1;
    // Protocol minor version
    static const int minor = 0;
};

// Fast Binary Encoding enums final sender
class FinalSender : public virtual FBE::Sender
{
public:
    FinalSender()
    { this->final(true); }
    FinalSender(const FinalSender&) = delete;
    FinalSender(FinalSender&&) noexcept = delete;
    virtual ~FinalSender() = default;

    FinalSender& operator=(const FinalSender&) = delete;
    FinalSender& operator=(FinalSender&&) noexcept = delete;

public:
    // Sender models accessors
};

// Fast Binary Encoding enums final receiver
class FinalReceiver : public virtual FBE::Receiver
{
public:
    FinalReceiver() { this->final(true); }
    FinalReceiver(const FinalReceiver&) = delete;
    FinalReceiver(FinalReceiver&&) = delete;
    virtual ~FinalReceiver() = default;

    FinalReceiver& operator=(const FinalReceiver&) = delete;
    FinalReceiver& operator=(FinalReceiver&&) = delete;

protected:
    // Receive handlers

    // Receive message handler
    bool onReceive(size_t type, const void* data, size_t size) override;

private:
    // Receiver values accessors

    // Receiver models accessors
};

// Fast Binary Encoding enums final client
class FinalClient : public virtual FinalSender, protected virtual FinalReceiver
{
public:
    FinalClient() = default;
    FinalClient(const FinalClient&) = delete;
    FinalClient(FinalClient&&) = delete;
    virtual ~FinalClient() = default;

    FinalClient& operator=(const FinalClient&) = delete;
    FinalClient& operator=(FinalClient&&) = delete;

    // Reset client buffers
    void reset() { std::scoped_lock locker(this->_lock); reset_requests(); }

    // Watchdog for timeouts
    void watchdog(uint64_t utc) { std::scoped_lock locker(this->_lock); watchdog_requests(utc); }


protected:
    std::mutex _lock;
    uint64_t _timestamp{0};

    // Reset client requests
    virtual void reset_requests();

    // Watchdog client requests for timeouts
    virtual void watchdog_requests(uint64_t utc);
};

} // namespace enums

} // namespace FBE
