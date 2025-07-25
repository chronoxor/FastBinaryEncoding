//------------------------------------------------------------------------------
// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: test.fbe
// FBE version: 1.15.0.0
//------------------------------------------------------------------------------

import ChronoxorFbe
import Foundation
import ChronoxorProto

// Fast Binary Encoding ChronoxorTest proxy listener
public protocol ProxyListener: ChronoxorProto.ProxyListener {
}

public extension ProxyListener {
    func onProxy(model: StructSimpleModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructOptionalModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructNestedModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructBytesModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructArrayModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructVectorModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructListModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructSetModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructMapModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructHashModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructHashExModel, type: Int, buffer: Data, offset: Int, size: Int) {}
    func onProxy(model: StructEmptyModel, type: Int, buffer: Data, offset: Int, size: Int) {}
}
