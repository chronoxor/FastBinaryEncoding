// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: enums.fbe
// Version: 1.8.0.0

import Foundation
import ChronoxorFbe

// Fast Binary Encoding Enums proxy
open class Proxy: ChronoxorFbe.ReceiverProtocol {
    // Proxy models accessors

    public var buffer: Buffer = Buffer()
    public var final: Bool = false

    public init() {
        build(final: false)
    }

    public init(buffer: ChronoxorFbe.Buffer) {
        build(with: buffer, final: false)
    }

    open func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        guard let listener = self as? ProxyListener else { return false }
        return onReceiveListener(listener: listener, type: type, buffer: buffer, offset: offset, size: size)
    }

    open func onReceiveListener(listener: ProxyListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {

        return false
    }
}
