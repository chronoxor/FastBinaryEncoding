// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: proto.fbe
// Version: 1.3.0.0

import ChronoxorFbe
import Foundation

// Fast Binary Encoding ChronoxorProto sender
open class Sender: ChronoxorFbe.SenderProtocol {
    // Sender models accessors
    private let OrderMessageModel: OrderMessageModel
    private let BalanceMessageModel: BalanceMessageModel
    private let AccountMessageModel: AccountMessageModel

    public var buffer: Buffer = Buffer()
    public var logging: Bool = false
    public var final: Bool = false

    public init() {
        OrderMessageModel = ChronoxorProto.OrderMessageModel(buffer: buffer)
        BalanceMessageModel = ChronoxorProto.BalanceMessageModel(buffer: buffer)
        AccountMessageModel = ChronoxorProto.AccountMessageModel(buffer: buffer)
        build(with: false)
    }

    public init(buffer: ChronoxorFbe.Buffer) {
        OrderMessageModel = ChronoxorProto.OrderMessageModel(buffer: buffer)
        BalanceMessageModel = ChronoxorProto.BalanceMessageModel(buffer: buffer)
        AccountMessageModel = ChronoxorProto.AccountMessageModel(buffer: buffer)
        build(with: buffer, final: false)
    }

    public func send(obj: Any) throws -> Int {
        return try send(obj: obj, listener: self as? ChronoxorFbe.LogListener)
    }

    public func send(obj: Any, listener: ChronoxorFbe.LogListener?) throws -> Int {
        switch obj {
        case is ChronoxorProto.OrderMessage: return try send(value: obj as! ChronoxorProto.OrderMessage, listener: listener)
        case is ChronoxorProto.BalanceMessage: return try send(value: obj as! ChronoxorProto.BalanceMessage, listener: listener)
        case is ChronoxorProto.AccountMessage: return try send(value: obj as! ChronoxorProto.AccountMessage, listener: listener)
        default: break
        }

        return 0
    }

    public func send(value: ChronoxorProto.OrderMessage) throws -> Int {
        return try send(value: value, listener: self as? ChronoxorFbe.LogListener)
    }

    public func send(value: ChronoxorProto.OrderMessage, listener: ChronoxorFbe.LogListener?) throws -> Int {
        // Serialize the value into the FBE stream
        let serialized = try OrderMessageModel.serialize(value: value)
        assert(serialized > 0, "ChronoxorProto.OrderMessage serialization failed!")
        assert(OrderMessageModel.verify(), "ChronoxorProto.OrderMessage validation failed!")

        // Log the value
        if logging {
            let message = value.description
            listener?.onSendLog(message: message)
        }

        // Send the serialized value
        return try sendSerialized(serialized: serialized)
    }

    public func send(value: ChronoxorProto.BalanceMessage) throws -> Int {
        return try send(value: value, listener: self as? ChronoxorFbe.LogListener)
    }

    public func send(value: ChronoxorProto.BalanceMessage, listener: ChronoxorFbe.LogListener?) throws -> Int {
        // Serialize the value into the FBE stream
        let serialized = try BalanceMessageModel.serialize(value: value)
        assert(serialized > 0, "ChronoxorProto.BalanceMessage serialization failed!")
        assert(BalanceMessageModel.verify(), "ChronoxorProto.BalanceMessage validation failed!")

        // Log the value
        if logging {
            let message = value.description
            listener?.onSendLog(message: message)
        }

        // Send the serialized value
        return try sendSerialized(serialized: serialized)
    }

    public func send(value: ChronoxorProto.AccountMessage) throws -> Int {
        return try send(value: value, listener: self as? ChronoxorFbe.LogListener)
    }

    public func send(value: ChronoxorProto.AccountMessage, listener: ChronoxorFbe.LogListener?) throws -> Int {
        // Serialize the value into the FBE stream
        let serialized = try AccountMessageModel.serialize(value: value)
        assert(serialized > 0, "ChronoxorProto.AccountMessage serialization failed!")
        assert(AccountMessageModel.verify(), "ChronoxorProto.AccountMessage validation failed!")

        // Log the value
        if logging {
            let message = value.description
            listener?.onSendLog(message: message)
        }

        // Send the serialized value
        return try sendSerialized(serialized: serialized)
    }

    // Send message handler
    open func onSend(buffer: Data, offset: Int, size: Int) throws -> Int { throw NSError() }
}
