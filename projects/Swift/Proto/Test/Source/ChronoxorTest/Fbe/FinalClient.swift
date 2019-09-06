// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// Version: 1.3.0.0

import Foundation
import ChronoxorFbe
import ChronoxorProto

// Fast Binary Encoding Test final client
open class FinalClient: ChronoxorFbe.ClientProtocol {
    // Imported senders
    let ProtoSender: ChronoxorProto.FinalClient

    // Imported receivers
    let ProtoReceiver: ChronoxorProto.FinalClient?

    // Client sender models accessors

    // Client receiver values accessors

    // Client receiver models accessors

    public var sendBuffer: Buffer = Buffer()
    public var receiveBuffer: Buffer = Buffer()
    public var logging: Bool = false
    public var final: Bool = false

    public init() {
        ProtoSender = ChronoxorProto.FinalClient(sendBuffer: sendBuffer, receiveBuffer: receiveBuffer)
        ProtoReceiver = ChronoxorProto.FinalClient(sendBuffer: sendBuffer, receiveBuffer: receiveBuffer)
        build(with: true)
    }

    public init(sendBuffer: ChronoxorFbe.Buffer, receiveBuffer: ChronoxorFbe.Buffer) {
        ProtoSender = ChronoxorProto.FinalClient(sendBuffer: sendBuffer, receiveBuffer: receiveBuffer)
        ProtoReceiver = ChronoxorProto.FinalClient(sendBuffer: sendBuffer, receiveBuffer: receiveBuffer)
        build(with: sendBuffer, receiveBuffer: receiveBuffer, final: true)
    }

    public func send(obj: Any) throws -> Int {
        return try send(obj: obj, listener: self as? ChronoxorFbe.LogListener)
    }

    public func send(obj: Any, listener: ChronoxorFbe.LogListener?) throws -> Int {

        // Try to send using imported clients
        var result: Int = 0
        result = try ProtoSender.send(obj: obj, listener: listener)
        if result > 0 { return result }

        return 0
    }

    // Send message handler
    open func onSend(buffer: Data, offset: Int, size: Int) throws -> Int { throw NSError() }
    open func onReceive(type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        guard let listener = self as? FinalReceiverListener else { return false }
        return onReceiveListener(listener: listener, type: type, buffer: buffer, offset: offset, size: size)
    }

    open func onReceiveListener(listener: FinalReceiverListener, type: Int, buffer: Data, offset: Int, size: Int) -> Bool {
        switch type {
        default: break
        }

        if let ProtoReceiver = ProtoReceiver, ProtoReceiver.onReceiveListener(listener: listener, type: type, buffer: buffer, offset: offset, size: size) {
            return true
        }

        return false
    }
}
