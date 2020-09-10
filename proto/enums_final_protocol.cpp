// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.4.0.0

#if defined(_MSC_VER)
#pragma warning(push)
#pragma warning(disable:4065) // C4065: switch statement contains 'default' but no 'case' labels
#endif

#include "enums_final_protocol.h"

namespace FBE {

namespace enums {

bool FinalReceiver::onReceive(size_t type, const void* data, size_t size)
{
    switch (type)
    {
        default: break;
    }

    return false;
}

void FinalClient::reset_requests()
{
    Sender::reset();
    Receiver::reset();
}

void FinalClient::watchdog_requests(uint64_t utc)
{
}

} // namespace enums

} // namespace FBE

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#elif defined(_MSC_VER)
#pragma warning(pop)
#endif
