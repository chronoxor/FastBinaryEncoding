require 'test/unit'

require_relative '../proto/test'

class TestSerialization < Test::Unit::TestCase
  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_domain
    # Create a new account with some orders
    account1 = Proto::Account.new(1, 'Test', Proto::State.good, Proto::Balance.new('USD', 1000.0), Proto::Balance.new('EUR', 100.0))
    account1.orders.push(Proto::Order.new(1, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.market, 1.23456, 1000.0))
    account1.orders.push(Proto::Order.new(2, 'EURUSD', Proto::OrderSide.sell, Proto::OrderType.limit, 1.0, 100.0))
    account1.orders.push(Proto::Order.new(3, 'EURUSD', Proto::OrderSide.buy, Proto::OrderType.stop, 1.5, 10.0))

    # Serialize the account to the FBE stream
    writer = Proto::AccountModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(account1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 252)

    # Deserialize the account from the FBE stream
    # noinspection RubyUnusedLocalVariable
    account2 = Proto::Account.new
    reader = Proto::AccountModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    account2, deserialized = reader.deserialize(account2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(account2.id, 1)
    assert_equal(account2.name, 'Test')
    assert_true(account2.state.has_flags(Proto::State.good))
    assert_equal(account2.wallet.currency, 'USD')
    assert_equal(account2.wallet.amount, 1000.0)
    assert_false(account2.asset.nil?)
    assert_equal(account2.asset.currency, 'EUR')
    assert_equal(account2.asset.amount, 100.0)
    assert_equal(account2.orders.length, 3)
    assert_equal(account2.orders[0].id, 1)
    assert_equal(account2.orders[0].symbol, 'EURUSD')
    assert_equal(account2.orders[0].side, Proto::OrderSide.buy)
    assert_equal(account2.orders[0].type, Proto::OrderType.market)
    assert_equal(account2.orders[0].price, 1.23456)
    assert_equal(account2.orders[0].volume, 1000.0)
    assert_equal(account2.orders[1].id, 2)
    assert_equal(account2.orders[1].symbol, 'EURUSD')
    assert_equal(account2.orders[1].side, Proto::OrderSide.sell)
    assert_equal(account2.orders[1].type, Proto::OrderType.limit)
    assert_equal(account2.orders[1].price, 1.0)
    assert_equal(account2.orders[1].volume, 100.0)
    assert_equal(account2.orders[2].id, 3)
    assert_equal(account2.orders[2].symbol, 'EURUSD')
    assert_equal(account2.orders[2].side, Proto::OrderSide.buy)
    assert_equal(account2.orders[2].type, Proto::OrderType.stop)
    assert_equal(account2.orders[2].price, 1.5)
    assert_equal(account2.orders[2].volume, 10.0)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_simple
    # Create a new struct
    struct1 = Test::StructSimple.new

    # Serialize the struct to the FBE stream
    writer = Test::StructSimpleModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 110)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 392)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructSimple.new
    reader = Test::StructSimpleModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 110)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1, false)
    assert_equal(struct2.f2, true)
    assert_equal(struct2.f3, 0)
    assert_equal(struct2.f4, 0xFF)
    assert_equal(struct2.f5, "\0")
    assert_equal(struct2.f6, '!')
    assert_equal(struct2.f7, 0.chr)
    # noinspection RubyResolve
    assert_equal(struct2.f8, 0x0444.chr(Encoding::UTF_8))
    assert_equal(struct2.f9, 0)
    assert_equal(struct2.f10, 127)
    assert_equal(struct2.f11, 0)
    assert_equal(struct2.f12, 0xFF)
    assert_equal(struct2.f13, 0)
    assert_equal(struct2.f14, 32767)
    assert_equal(struct2.f15, 0)
    assert_equal(struct2.f16, 0xFFFF)
    assert_equal(struct2.f17, 0)
    assert_equal(struct2.f18, 2147483647)
    assert_equal(struct2.f19, 0)
    assert_equal(struct2.f20, 0xFFFFFFFF)
    assert_equal(struct2.f21, 0)
    assert_equal(struct2.f22, 9223372036854775807)
    assert_equal(struct2.f23, 0)
    assert_equal(struct2.f24, 0xFFFFFFFFFFFFFFFF)
    assert_equal(struct2.f25, 0.0)
    assert_true((struct2.f26 - 123.456).abs < 0.0001)
    assert_equal(struct2.f27, 0.0)
    assert_true((struct2.f28 - -123.567e+123).abs < 1e+123)
    assert_equal(struct2.f29, BigDecimal('0'))
    assert_equal(struct2.f30, BigDecimal('123456.123456'))
    assert_equal(struct2.f31, '')
    assert_equal(struct2.f32, 'Initial string!')
    assert_equal(struct2.f33, Time.utc(1970))
    assert_equal(struct2.f34, Time.utc(1970))
    assert_true(struct2.f35 > Time.utc(2018))
    assert_equal(struct2.f36, UUIDTools::UUID.parse_int(0))
    assert_not_equal(struct2.f37, UUIDTools::UUID.parse_int(0))
    assert_equal(struct2.f38, UUIDTools::UUID.parse('123e4567-e89b-12d3-a456-426655440000'))

    assert_equal(struct2.f1, struct1.f1)
    assert_equal(struct2.f2, struct1.f2)
    assert_equal(struct2.f3, struct1.f3)
    assert_equal(struct2.f4, struct1.f4)
    assert_equal(struct2.f5, struct1.f5)
    assert_equal(struct2.f6, struct1.f6)
    assert_equal(struct2.f7, struct1.f7)
    assert_equal(struct2.f8, struct1.f8)
    assert_equal(struct2.f9, struct1.f9)
    assert_equal(struct2.f10, struct1.f10)
    assert_equal(struct2.f11, struct1.f11)
    assert_equal(struct2.f12, struct1.f12)
    assert_equal(struct2.f13, struct1.f13)
    assert_equal(struct2.f14, struct1.f14)
    assert_equal(struct2.f15, struct1.f15)
    assert_equal(struct2.f16, struct1.f16)
    assert_equal(struct2.f17, struct1.f17)
    assert_equal(struct2.f18, struct1.f18)
    assert_equal(struct2.f19, struct1.f19)
    assert_equal(struct2.f20, struct1.f20)
    assert_equal(struct2.f21, struct1.f21)
    assert_equal(struct2.f22, struct1.f22)
    assert_equal(struct2.f23, struct1.f23)
    assert_equal(struct2.f24, struct1.f24)
    assert_equal(struct2.f25, struct1.f25)
    assert_true((struct2.f26 - struct1.f26).abs < 0.0001)
    assert_equal(struct2.f27, struct1.f27)
    assert_true((struct2.f28 - struct1.f28).abs < 1e+123)
    assert_equal(struct2.f29, struct1.f29)
    assert_equal(struct2.f30, struct1.f30)
    assert_equal(struct2.f31, struct1.f31)
    assert_equal(struct2.f32, struct1.f32)
    assert_equal(struct2.f33, struct1.f33)
    assert_equal(struct2.f34, struct1.f34)
    assert_equal(struct2.f35, struct1.f35)
    assert_equal(struct2.f36, struct1.f36)
    assert_equal(struct2.f37, struct1.f37)
    assert_equal(struct2.f38, struct1.f38)
    assert_equal(struct2.f39, struct1.f39)
    assert_equal(struct2.f40, struct1.f40)
  end

  # noinspection RubyInstanceMethodNamingConvention, RubyScope
  def test_serialization_struct_optional
    # Create a new struct
    struct1 = Test::StructOptional.new

    # Serialize the struct to the FBE stream
    writer = Test::StructOptionalModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 111)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 834)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructOptional.new
    reader = Test::StructOptionalModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 111)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1, false)
    assert_equal(struct2.f2, true)
    assert_equal(struct2.f3, 0)
    assert_equal(struct2.f4, 0xFF)
    assert_equal(struct2.f5, "\0")
    assert_equal(struct2.f6, '!')
    assert_equal(struct2.f7, 0.chr)
    # noinspection RubyResolve
    assert_equal(struct2.f8, 0x0444.chr(Encoding::UTF_8))
    assert_equal(struct2.f9, 0)
    assert_equal(struct2.f10, 127)
    assert_equal(struct2.f11, 0)
    assert_equal(struct2.f12, 0xFF)
    assert_equal(struct2.f13, 0)
    assert_equal(struct2.f14, 32767)
    assert_equal(struct2.f15, 0)
    assert_equal(struct2.f16, 0xFFFF)
    assert_equal(struct2.f17, 0)
    assert_equal(struct2.f18, 2147483647)
    assert_equal(struct2.f19, 0)
    assert_equal(struct2.f20, 0xFFFFFFFF)
    assert_equal(struct2.f21, 0)
    assert_equal(struct2.f22, 9223372036854775807)
    assert_equal(struct2.f23, 0)
    assert_equal(struct2.f24, 0xFFFFFFFFFFFFFFFF)
    assert_equal(struct2.f25, 0.0)
    assert_true((struct2.f26 - 123.456).abs < 0.0001)
    assert_equal(struct2.f27, 0.0)
    assert_true((struct2.f28 - -123.567e+123).abs < 1e+123)
    assert_equal(struct2.f29, BigDecimal('0'))
    assert_equal(struct2.f30, BigDecimal('123456.123456'))
    assert_equal(struct2.f31, '')
    assert_equal(struct2.f32, 'Initial string!')
    assert_equal(struct2.f33, Time.utc(1970))
    assert_equal(struct2.f34, Time.utc(1970))
    assert_true(struct2.f35 > Time.utc(2018))
    assert_equal(struct2.f36, UUIDTools::UUID.parse_int(0))
    assert_not_equal(struct2.f37, UUIDTools::UUID.parse_int(0))
    assert_equal(struct2.f38, UUIDTools::UUID.parse('123e4567-e89b-12d3-a456-426655440000'))

    assert_true(struct2.f100.nil?)
    assert_false(struct2.f101.nil?)
    assert_equal(struct2.f101, true)
    assert_true(struct2.f102.nil?)
    assert_true(struct2.f103.nil?)
    assert_false(struct2.f104.nil?)
    assert_equal(struct2.f104, 0xFF)
    assert_true(struct2.f105.nil?)
    assert_true(struct2.f106.nil?)
    assert_false(struct2.f107.nil?)
    assert_equal(struct2.f107, '!')
    assert_true(struct2.f108.nil?)
    assert_true(struct2.f109.nil?)
    assert_false(struct2.f110.nil?)
    # noinspection RubyResolve
    assert_equal(struct2.f110, 0x0444.chr(Encoding::UTF_8))
    assert_true(struct2.f111.nil?)
    assert_true(struct2.f112.nil?)
    assert_false(struct2.f113.nil?)
    assert_equal(struct2.f113, 127)
    assert_true(struct2.f114.nil?)
    assert_true(struct2.f115.nil?)
    assert_false(struct2.f116.nil?)
    assert_equal(struct2.f116, 0xFF)
    assert_true(struct2.f117.nil?)
    assert_true(struct2.f118.nil?)
    assert_false(struct2.f119.nil?)
    assert_equal(struct2.f119, 32767)
    assert_true(struct2.f120.nil?)
    assert_true(struct2.f121.nil?)
    assert_false(struct2.f122.nil?)
    assert_equal(struct2.f122, 0xFFFF)
    assert_true(struct2.f123.nil?)
    assert_true(struct2.f124.nil?)
    assert_false(struct2.f125.nil?)
    assert_equal(struct2.f125, 2147483647)
    assert_true(struct2.f126.nil?)
    assert_true(struct2.f127.nil?)
    assert_false(struct2.f128.nil?)
    assert_equal(struct2.f128, 0xFFFFFFFF)
    assert_true(struct2.f129.nil?)
    assert_true(struct2.f130.nil?)
    assert_false(struct2.f131.nil?)
    assert_equal(struct2.f131, 9223372036854775807)
    assert_true(struct2.f132.nil?)
    assert_true(struct2.f133.nil?)
    assert_false(struct2.f131.nil?)
    assert_equal(struct2.f134, 0xFFFFFFFFFFFFFFFF)
    assert_true(struct2.f135.nil?)
    assert_true(struct2.f136.nil?)
    assert_false(struct2.f137.nil?)
    assert_true((struct2.f137 - 123.456).abs < 0.0001)
    assert_true(struct2.f138.nil?)
    assert_true(struct2.f139.nil?)
    assert_false(struct2.f140.nil?)
    assert_true((struct2.f140 - -123.567e+123).abs < 1e+123)
    assert_true(struct2.f141.nil?)
    assert_true(struct2.f142.nil?)
    assert_false(struct2.f143.nil?)
    assert_equal(struct2.f143, BigDecimal('123456.123456'))
    assert_true(struct2.f144.nil?)
    assert_true(struct2.f145.nil?)
    assert_false(struct2.f146.nil?)
    assert_equal(struct2.f146, 'Initial string!')
    assert_true(struct2.f147.nil?)
    assert_true(struct2.f148.nil?)
    assert_false(struct2.f149.nil?)
    assert_true(struct2.f149 > Time.utc(2018))
    assert_true(struct2.f150.nil?)
    assert_true(struct2.f151.nil?)
    assert_false(struct2.f152.nil?)
    assert_equal(struct2.f152, UUIDTools::UUID.parse('123e4567-e89b-12d3-a456-426655440000'))
    assert_true(struct2.f153.nil?)
    assert_true(struct2.f154.nil?)
    assert_true(struct2.f155.nil?)
    assert_true(struct2.f156.nil?)
    assert_true(struct2.f157.nil?)
    assert_true(struct2.f158.nil?)
    assert_true(struct2.f159.nil?)
    assert_true(struct2.f160.nil?)
    assert_true(struct2.f161.nil?)
    assert_true(struct2.f162.nil?)
    assert_true(struct2.f163.nil?)
    assert_true(struct2.f164.nil?)
    assert_true(struct2.f165.nil?)

    assert_equal(struct2.f1, struct1.f1)
    assert_equal(struct2.f2, struct1.f2)
    assert_equal(struct2.f3, struct1.f3)
    assert_equal(struct2.f4, struct1.f4)
    assert_equal(struct2.f5, struct1.f5)
    assert_equal(struct2.f6, struct1.f6)
    assert_equal(struct2.f7, struct1.f7)
    assert_equal(struct2.f8, struct1.f8)
    assert_equal(struct2.f9, struct1.f9)
    assert_equal(struct2.f10, struct1.f10)
    assert_equal(struct2.f11, struct1.f11)
    assert_equal(struct2.f12, struct1.f12)
    assert_equal(struct2.f13, struct1.f13)
    assert_equal(struct2.f14, struct1.f14)
    assert_equal(struct2.f15, struct1.f15)
    assert_equal(struct2.f16, struct1.f16)
    assert_equal(struct2.f17, struct1.f17)
    assert_equal(struct2.f18, struct1.f18)
    assert_equal(struct2.f19, struct1.f19)
    assert_equal(struct2.f20, struct1.f20)
    assert_equal(struct2.f21, struct1.f21)
    assert_equal(struct2.f22, struct1.f22)
    assert_equal(struct2.f23, struct1.f23)
    assert_equal(struct2.f24, struct1.f24)
    assert_equal(struct2.f25, struct1.f25)
    assert_true((struct2.f26 - struct1.f26).abs < 0.0001)
    assert_equal(struct2.f27, struct1.f27)
    assert_true((struct2.f28 - struct1.f28).abs < 1e+123)
    assert_equal(struct2.f29, struct1.f29)
    assert_equal(struct2.f30, struct1.f30)
    assert_equal(struct2.f31, struct1.f31)
    assert_equal(struct2.f32, struct1.f32)
    assert_equal(struct2.f33, struct1.f33)
    assert_equal(struct2.f34, struct1.f34)
    assert_equal(struct2.f35, struct1.f35)
    assert_equal(struct2.f36, struct1.f36)
    assert_equal(struct2.f37, struct1.f37)
    assert_equal(struct2.f38, struct1.f38)
    assert_equal(struct2.f39, struct1.f39)
    assert_equal(struct2.f40, struct1.f40)

    assert_equal(struct2.f100, struct1.f100)
    assert_equal(struct2.f101, struct1.f101)
    assert_equal(struct2.f102, struct1.f102)
    assert_equal(struct2.f103, struct1.f103)
    assert_equal(struct2.f104, struct1.f104)
    assert_equal(struct2.f105, struct1.f105)
    assert_equal(struct2.f106, struct1.f106)
    assert_equal(struct2.f107, struct1.f107)
    assert_equal(struct2.f108, struct1.f108)
    assert_equal(struct2.f109, struct1.f109)
    assert_equal(struct2.f110, struct1.f110)
    assert_equal(struct2.f111, struct1.f111)
    assert_equal(struct2.f112, struct1.f112)
    assert_equal(struct2.f113, struct1.f113)
    assert_equal(struct2.f114, struct1.f114)
    assert_equal(struct2.f115, struct1.f115)
    assert_equal(struct2.f116, struct1.f116)
    assert_equal(struct2.f117, struct1.f117)
    assert_equal(struct2.f118, struct1.f118)
    assert_equal(struct2.f119, struct1.f119)
    assert_equal(struct2.f120, struct1.f120)
    assert_equal(struct2.f121, struct1.f121)
    assert_equal(struct2.f122, struct1.f122)
    assert_equal(struct2.f123, struct1.f123)
    assert_equal(struct2.f124, struct1.f124)
    assert_equal(struct2.f125, struct1.f125)
    assert_equal(struct2.f126, struct1.f126)
    assert_equal(struct2.f127, struct1.f127)
    assert_equal(struct2.f128, struct1.f128)
    assert_equal(struct2.f129, struct1.f129)
    assert_equal(struct2.f130, struct1.f130)
    assert_equal(struct2.f131, struct1.f131)
    assert_equal(struct2.f132, struct1.f132)
    assert_equal(struct2.f133, struct1.f133)
    assert_equal(struct2.f134, struct1.f134)
    assert_equal(struct2.f135, struct1.f135)
    assert_equal(struct2.f136, struct1.f136)
    assert_true((struct2.f137 - struct1.f137).abs < 0.0001)
    assert_equal(struct2.f138, struct1.f138)
    assert_equal(struct2.f139, struct1.f139)
    assert_true((struct2.f140 - struct1.f140).abs < 1e+123)
    assert_equal(struct2.f141, struct1.f141)
    assert_equal(struct2.f142, struct1.f142)
    assert_equal(struct2.f143, struct1.f143)
    assert_equal(struct2.f144, struct1.f144)
    assert_equal(struct2.f145, struct1.f145)
    assert_equal(struct2.f146, struct1.f146)
    assert_equal(struct2.f147, struct1.f147)
    assert_equal(struct2.f148, struct1.f148)
    assert_equal(struct2.f149, struct1.f149)
    assert_equal(struct2.f150, struct1.f150)
    assert_equal(struct2.f151, struct1.f151)
    assert_equal(struct2.f152, struct1.f152)
    assert_equal(struct2.f153, struct1.f153)
    assert_equal(struct2.f154, struct1.f154)
    assert_equal(struct2.f155, struct1.f155)
    assert_equal(struct2.f156, struct1.f156)
    assert_equal(struct2.f157, struct1.f157)
  end

  # noinspection RubyInstanceMethodNamingConvention, RubyScope
  def test_serialization_struct_nested
    # Create a new struct
    struct1 = Test::StructNested.new

    # Serialize the struct to the FBE stream
    writer = Test::StructNestedModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 112)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 2099)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructNested.new
    reader = Test::StructNestedModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 112)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_true(struct2.f100.nil?)
    assert_false(struct2.f101.nil?)
    assert_equal(struct2.f101, true)
    assert_true(struct2.f102.nil?)
    assert_true(struct2.f103.nil?)
    assert_false(struct2.f104.nil?)
    assert_equal(struct2.f104, 0xFF)
    assert_true(struct2.f105.nil?)
    assert_true(struct2.f106.nil?)
    assert_false(struct2.f107.nil?)
    assert_equal(struct2.f107, '!')
    assert_true(struct2.f108.nil?)
    assert_true(struct2.f109.nil?)
    assert_false(struct2.f110.nil?)
    # noinspection RubyResolve
    assert_equal(struct2.f110, 0x0444.chr(Encoding::UTF_8))
    assert_true(struct2.f111.nil?)
    assert_true(struct2.f112.nil?)
    assert_false(struct2.f113.nil?)
    assert_equal(struct2.f113, 127)
    assert_true(struct2.f114.nil?)
    assert_true(struct2.f115.nil?)
    assert_false(struct2.f116.nil?)
    assert_equal(struct2.f116, 0xFF)
    assert_true(struct2.f117.nil?)
    assert_true(struct2.f118.nil?)
    assert_false(struct2.f119.nil?)
    assert_equal(struct2.f119, 32767)
    assert_true(struct2.f120.nil?)
    assert_true(struct2.f121.nil?)
    assert_false(struct2.f122.nil?)
    assert_equal(struct2.f122, 0xFFFF)
    assert_true(struct2.f123.nil?)
    assert_true(struct2.f124.nil?)
    assert_false(struct2.f125.nil?)
    assert_equal(struct2.f125, 2147483647)
    assert_true(struct2.f126.nil?)
    assert_true(struct2.f127.nil?)
    assert_false(struct2.f128.nil?)
    assert_equal(struct2.f128, 0xFFFFFFFF)
    assert_true(struct2.f129.nil?)
    assert_true(struct2.f130.nil?)
    assert_false(struct2.f131.nil?)
    assert_equal(struct2.f131, 9223372036854775807)
    assert_true(struct2.f132.nil?)
    assert_true(struct2.f133.nil?)
    assert_false(struct2.f131.nil?)
    assert_equal(struct2.f134, 0xFFFFFFFFFFFFFFFF)
    assert_true(struct2.f135.nil?)
    assert_true(struct2.f136.nil?)
    assert_false(struct2.f137.nil?)
    assert_true((struct2.f137 - 123.456).abs < 0.0001)
    assert_true(struct2.f138.nil?)
    assert_true(struct2.f139.nil?)
    assert_false(struct2.f140.nil?)
    assert_true((struct2.f140 - -123.567e+123).abs < 1e+123)
    assert_true(struct2.f141.nil?)
    assert_true(struct2.f142.nil?)
    assert_false(struct2.f143.nil?)
    assert_equal(struct2.f143, BigDecimal('123456.123456'))
    assert_true(struct2.f144.nil?)
    assert_true(struct2.f145.nil?)
    assert_false(struct2.f146.nil?)
    assert_equal(struct2.f146, 'Initial string!')
    assert_true(struct2.f147.nil?)
    assert_true(struct2.f148.nil?)
    assert_false(struct2.f149.nil?)
    assert_true(struct2.f149 > Time.utc(2018))
    assert_true(struct2.f150.nil?)
    assert_true(struct2.f151.nil?)
    assert_false(struct2.f152.nil?)
    assert_equal(struct2.f152, UUIDTools::UUID.parse('123e4567-e89b-12d3-a456-426655440000'))
    assert_true(struct2.f153.nil?)
    assert_true(struct2.f154.nil?)
    assert_true(struct2.f155.nil?)
    assert_true(struct2.f156.nil?)
    assert_true(struct2.f157.nil?)
    assert_true(struct2.f158.nil?)
    assert_true(struct2.f159.nil?)
    assert_true(struct2.f160.nil?)
    assert_true(struct2.f161.nil?)
    assert_true(struct2.f162.nil?)
    assert_true(struct2.f163.nil?)
    assert_true(struct2.f164.nil?)
    assert_true(struct2.f165.nil?)

    assert_equal(struct2.f1000, Test::EnumSimple.ENUM_VALUE_0)
    assert_true(struct2.f1001.nil?)
    assert_equal(struct2.f1002, Test::EnumTyped.ENUM_VALUE_2)
    assert_true(struct2.f1003.nil?)
    assert_equal(struct2.f1004, Test::FlagsSimple.FLAG_VALUE_0)
    assert_true(struct2.f1005.nil?)
    assert_equal(struct2.f1006, Test::FlagsTyped.FLAG_VALUE_2 | Test::FlagsTyped.FLAG_VALUE_4 | Test::FlagsTyped.FLAG_VALUE_6)
    assert_true(struct2.f1007.nil?)
    assert_true(struct2.f1009.nil?)
    assert_true(struct2.f1011.nil?)

    assert_equal(struct2.f1, struct1.f1)
    assert_equal(struct2.f2, struct1.f2)
    assert_equal(struct2.f3, struct1.f3)
    assert_equal(struct2.f4, struct1.f4)
    assert_equal(struct2.f5, struct1.f5)
    assert_equal(struct2.f6, struct1.f6)
    assert_equal(struct2.f7, struct1.f7)
    assert_equal(struct2.f8, struct1.f8)
    assert_equal(struct2.f9, struct1.f9)
    assert_equal(struct2.f10, struct1.f10)
    assert_equal(struct2.f11, struct1.f11)
    assert_equal(struct2.f12, struct1.f12)
    assert_equal(struct2.f13, struct1.f13)
    assert_equal(struct2.f14, struct1.f14)
    assert_equal(struct2.f15, struct1.f15)
    assert_equal(struct2.f16, struct1.f16)
    assert_equal(struct2.f17, struct1.f17)
    assert_equal(struct2.f18, struct1.f18)
    assert_equal(struct2.f19, struct1.f19)
    assert_equal(struct2.f20, struct1.f20)
    assert_equal(struct2.f21, struct1.f21)
    assert_equal(struct2.f22, struct1.f22)
    assert_equal(struct2.f23, struct1.f23)
    assert_equal(struct2.f24, struct1.f24)
    assert_equal(struct2.f25, struct1.f25)
    assert_true((struct2.f26 - struct1.f26).abs < 0.0001)
    assert_equal(struct2.f27, struct1.f27)
    assert_true((struct2.f28 - struct1.f28).abs < 1e+123)
    assert_equal(struct2.f29, struct1.f29)
    assert_equal(struct2.f30, struct1.f30)
    assert_equal(struct2.f31, struct1.f31)
    assert_equal(struct2.f32, struct1.f32)
    assert_equal(struct2.f33, struct1.f33)
    assert_equal(struct2.f34, struct1.f34)
    assert_equal(struct2.f35, struct1.f35)
    assert_equal(struct2.f36, struct1.f36)
    assert_equal(struct2.f37, struct1.f37)
    assert_equal(struct2.f38, struct1.f38)
    assert_equal(struct2.f39, struct1.f39)
    assert_equal(struct2.f40, struct1.f40)

    assert_equal(struct2.f100, struct1.f100)
    assert_equal(struct2.f101, struct1.f101)
    assert_equal(struct2.f102, struct1.f102)
    assert_equal(struct2.f103, struct1.f103)
    assert_equal(struct2.f104, struct1.f104)
    assert_equal(struct2.f105, struct1.f105)
    assert_equal(struct2.f106, struct1.f106)
    assert_equal(struct2.f107, struct1.f107)
    assert_equal(struct2.f108, struct1.f108)
    assert_equal(struct2.f109, struct1.f109)
    assert_equal(struct2.f110, struct1.f110)
    assert_equal(struct2.f111, struct1.f111)
    assert_equal(struct2.f112, struct1.f112)
    assert_equal(struct2.f113, struct1.f113)
    assert_equal(struct2.f114, struct1.f114)
    assert_equal(struct2.f115, struct1.f115)
    assert_equal(struct2.f116, struct1.f116)
    assert_equal(struct2.f117, struct1.f117)
    assert_equal(struct2.f118, struct1.f118)
    assert_equal(struct2.f119, struct1.f119)
    assert_equal(struct2.f120, struct1.f120)
    assert_equal(struct2.f121, struct1.f121)
    assert_equal(struct2.f122, struct1.f122)
    assert_equal(struct2.f123, struct1.f123)
    assert_equal(struct2.f124, struct1.f124)
    assert_equal(struct2.f125, struct1.f125)
    assert_equal(struct2.f126, struct1.f126)
    assert_equal(struct2.f127, struct1.f127)
    assert_equal(struct2.f128, struct1.f128)
    assert_equal(struct2.f129, struct1.f129)
    assert_equal(struct2.f130, struct1.f130)
    assert_equal(struct2.f131, struct1.f131)
    assert_equal(struct2.f132, struct1.f132)
    assert_equal(struct2.f133, struct1.f133)
    assert_equal(struct2.f134, struct1.f134)
    assert_equal(struct2.f135, struct1.f135)
    assert_equal(struct2.f136, struct1.f136)
    assert_true((struct2.f137 - struct1.f137).abs < 0.0001)
    assert_equal(struct2.f138, struct1.f138)
    assert_equal(struct2.f139, struct1.f139)
    assert_true((struct2.f140 - struct1.f140).abs < 1e+123)
    assert_equal(struct2.f141, struct1.f141)
    assert_equal(struct2.f142, struct1.f142)
    assert_equal(struct2.f143, struct1.f143)
    assert_equal(struct2.f144, struct1.f144)
    assert_equal(struct2.f145, struct1.f145)
    assert_equal(struct2.f146, struct1.f146)
    assert_equal(struct2.f147, struct1.f147)
    assert_equal(struct2.f148, struct1.f148)
    assert_equal(struct2.f149, struct1.f149)
    assert_equal(struct2.f150, struct1.f150)
    assert_equal(struct2.f151, struct1.f151)
    assert_equal(struct2.f152, struct1.f152)
    assert_equal(struct2.f153, struct1.f153)
    assert_equal(struct2.f154, struct1.f154)
    assert_equal(struct2.f155, struct1.f155)
    assert_equal(struct2.f156, struct1.f156)
    assert_equal(struct2.f157, struct1.f157)

    assert_equal(struct2.f1000, struct1.f1000)
    assert_equal(struct2.f1001, struct1.f1001)
    assert_equal(struct2.f1002, struct1.f1002)
    assert_equal(struct2.f1003, struct1.f1003)
    assert_equal(struct2.f1004, struct1.f1004)
    assert_equal(struct2.f1005, struct1.f1005)
    assert_equal(struct2.f1006, struct1.f1006)
    assert_equal(struct2.f1007, struct1.f1007)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_bytes
    # Create a new struct
    struct1 = Test::StructBytes.new
    struct1.f1 = 'ABC'
    struct1.f2 = 'test'

    # Serialize the struct to the FBE stream
    writer = Test::StructBytesModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 120)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 49)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructBytes.new
    reader = Test::StructBytesModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 120)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 3)
    assert_equal(struct2.f1[0].chr, 'A')
    assert_equal(struct2.f1[1].chr, 'B')
    assert_equal(struct2.f1[2].chr, 'C')
    assert_false(struct2.f2.nil?)
    assert_equal(struct2.f2.length, 4)
    assert_equal(struct2.f2[0].chr, 't')
    assert_equal(struct2.f2[1].chr, 'e')
    assert_equal(struct2.f2[2].chr, 's')
    assert_equal(struct2.f2[3].chr, 't')
    assert_true(struct2.f3.nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_array
    # Create a new struct
    struct1 = Test::StructArray.new
    struct1.f1[0] = 48
    struct1.f1[1] = 65
    struct1.f2[0] = 97
    struct1.f2[1] = nil
    struct1.f3[0] = '000'
    struct1.f3[1] = 'AAA'
    struct1.f4[0] = 'aaa'
    struct1.f4[1] = nil
    struct1.f5[0] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f5[1] = Test::EnumSimple.ENUM_VALUE_2
    struct1.f6[0] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f6[1] = nil
    struct1.f7[0] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f7[1] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
    struct1.f8[0] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f8[1] = nil
    struct1.f9[0] = Test::StructSimple.new
    struct1.f9[1] = Test::StructSimple.new
    struct1.f10[0] = Test::StructSimple.new
    struct1.f10[1] = nil

    # Serialize the struct to the FBE stream
    writer = Test::StructArrayModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 125)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 1290)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructArray.new
    reader = Test::StructArrayModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 125)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    (struct2, deserialized) = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1[0], 48)
    assert_equal(struct2.f1[1], 65)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2[0], 97)
    assert_true(struct2.f2[1].nil?)
    assert_equal(struct2.f3.length, 2)
    assert_equal(struct2.f3[0].length, 3)
    assert_equal(struct2.f3[0][0].ord, 48)
    assert_equal(struct2.f3[0][1].ord, 48)
    assert_equal(struct2.f3[0][2].ord, 48)
    assert_equal(struct2.f3[1].length, 3)
    assert_equal(struct2.f3[1][0].ord, 65)
    assert_equal(struct2.f3[1][1].ord, 65)
    assert_equal(struct2.f3[1][2].ord, 65)
    assert_equal(struct2.f4.length, 2)
    assert_false(struct2.f4[0].nil?)
    assert_equal(struct2.f4[0].length, 3)
    assert_equal(struct2.f4[0][0].ord, 97)
    assert_equal(struct2.f4[0][1].ord, 97)
    assert_equal(struct2.f4[0][2].ord, 97)
    assert_true(struct2.f4[1].nil?)
    assert_equal(struct2.f5.length, 2)
    assert_equal(struct2.f5[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_equal(struct2.f5[1], Test::EnumSimple.ENUM_VALUE_2)
    assert_equal(struct2.f6.length, 2)
    assert_equal(struct2.f6[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_true(struct2.f6[1].nil?)
    assert_equal(struct2.f7.length, 2)
    assert_equal(struct2.f7[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_equal(struct2.f7[1], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    assert_equal(struct2.f8.length, 2)
    assert_equal(struct2.f8[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_true(struct2.f8[1].nil?)
    assert_equal(struct2.f9.length, 2)
    assert_equal(struct2.f9[0].f2, true)
    assert_equal(struct2.f9[0].f12, 0xFF)
    assert_equal(struct2.f9[0].f32, 'Initial string!')
    assert_equal(struct2.f9[1].f2, true)
    assert_equal(struct2.f9[1].f12, 0xFF)
    assert_equal(struct2.f9[1].f32, 'Initial string!')
    assert_equal(struct2.f10.length, 2)
    assert_false(struct2.f10[0].nil?)
    assert_equal(struct2.f10[0].f2, true)
    assert_equal(struct2.f10[0].f12, 0xFF)
    assert_equal(struct2.f10[0].f32, 'Initial string!')
    assert_true(struct2.f10[1].nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_vector
    # Create a new struct
    struct1 = Test::StructVector.new
    struct1.f1.push(48)
    struct1.f1.push(65)
    struct1.f2.push(97)
    struct1.f2.push(nil)
    struct1.f3.push('000')
    struct1.f3.push('AAA')
    struct1.f4.push('aaa')
    struct1.f4.push(nil)
    struct1.f5.push(Test::EnumSimple.ENUM_VALUE_1)
    struct1.f5.push(Test::EnumSimple.ENUM_VALUE_2)
    struct1.f6.push(Test::EnumSimple.ENUM_VALUE_1)
    struct1.f6.push(nil)
    struct1.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    struct1.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    struct1.f8.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    struct1.f8.push(nil)
    struct1.f9.push(Test::StructSimple.new)
    struct1.f9.push(Test::StructSimple.new)
    struct1.f10.push(Test::StructSimple.new)
    struct1.f10.push(nil)

    # Serialize the struct to the FBE stream
    writer = Test::StructVectorModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 130)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 1370)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructVector.new
    reader = Test::StructVectorModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 130)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1[0], 48)
    assert_equal(struct2.f1[1], 65)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2[0], 97)
    assert_true(struct2.f2[1].nil?)
    assert_equal(struct2.f3.length, 2)
    assert_equal(struct2.f3[0].length, 3)
    assert_equal(struct2.f3[0][0].ord, 48)
    assert_equal(struct2.f3[0][1].ord, 48)
    assert_equal(struct2.f3[0][2].ord, 48)
    assert_equal(struct2.f3[1].length, 3)
    assert_equal(struct2.f3[1][0].ord, 65)
    assert_equal(struct2.f3[1][1].ord, 65)
    assert_equal(struct2.f3[1][2].ord, 65)
    assert_equal(struct2.f4.length, 2)
    assert_false(struct2.f4[0].nil?)
    assert_equal(struct2.f4[0].length, 3)
    assert_equal(struct2.f4[0][0].ord, 97)
    assert_equal(struct2.f4[0][1].ord, 97)
    assert_equal(struct2.f4[0][2].ord, 97)
    assert_true(struct2.f4[1].nil?)
    assert_equal(struct2.f5.length, 2)
    assert_equal(struct2.f5[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_equal(struct2.f5[1], Test::EnumSimple.ENUM_VALUE_2)
    assert_equal(struct2.f6.length, 2)
    assert_equal(struct2.f6[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_true(struct2.f6[1].nil?)
    assert_equal(struct2.f7.length, 2)
    assert_equal(struct2.f7[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_equal(struct2.f7[1], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    assert_equal(struct2.f8.length, 2)
    assert_equal(struct2.f8[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_true(struct2.f8[1].nil?)
    assert_equal(struct2.f9.length, 2)
    assert_equal(struct2.f9[0].f2, true)
    assert_equal(struct2.f9[0].f12, 0xFF)
    assert_equal(struct2.f9[0].f32, 'Initial string!')
    assert_equal(struct2.f9[1].f2, true)
    assert_equal(struct2.f9[1].f12, 0xFF)
    assert_equal(struct2.f9[1].f32, 'Initial string!')
    assert_equal(struct2.f10.length, 2)
    assert_false(struct2.f10[0].nil?)
    assert_equal(struct2.f10[0].f2, true)
    assert_equal(struct2.f10[0].f12, 0xFF)
    assert_equal(struct2.f10[0].f32, 'Initial string!')
    assert_true(struct2.f10[1].nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_list
    # Create a new struct
    struct1 = Test::StructList.new
    struct1.f1.push(48)
    struct1.f1.push(65)
    struct1.f2.push(97)
    struct1.f2.push(nil)
    struct1.f3.push('000')
    struct1.f3.push('AAA')
    struct1.f4.push('aaa')
    struct1.f4.push(nil)
    struct1.f5.push(Test::EnumSimple.ENUM_VALUE_1)
    struct1.f5.push(Test::EnumSimple.ENUM_VALUE_2)
    struct1.f6.push(Test::EnumSimple.ENUM_VALUE_1)
    struct1.f6.push(nil)
    struct1.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    struct1.f7.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    struct1.f8.push(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    struct1.f8.push(nil)
    struct1.f9.push(Test::StructSimple.new)
    struct1.f9.push(Test::StructSimple.new)
    struct1.f10.push(Test::StructSimple.new)
    struct1.f10.push(nil)

    # Serialize the struct to the FBE stream
    writer = Test::StructListModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 131)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 1370)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructList.new
    reader = Test::StructListModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 131)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1[0], 48)
    assert_equal(struct2.f1[1], 65)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2[0], 97)
    assert_true(struct2.f2[1].nil?)
    assert_equal(struct2.f3.length, 2)
    assert_equal(struct2.f3[0].length, 3)
    assert_equal(struct2.f3[0][0].ord, 48)
    assert_equal(struct2.f3[0][1].ord, 48)
    assert_equal(struct2.f3[0][2].ord, 48)
    assert_equal(struct2.f3[1].length, 3)
    assert_equal(struct2.f3[1][0].ord, 65)
    assert_equal(struct2.f3[1][1].ord, 65)
    assert_equal(struct2.f3[1][2].ord, 65)
    assert_equal(struct2.f4.length, 2)
    assert_false(struct2.f4[0].nil?)
    assert_equal(struct2.f4[0].length, 3)
    assert_equal(struct2.f4[0][0].ord, 97)
    assert_equal(struct2.f4[0][1].ord, 97)
    assert_equal(struct2.f4[0][2].ord, 97)
    assert_true(struct2.f4[1].nil?)
    assert_equal(struct2.f5.length, 2)
    assert_equal(struct2.f5[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_equal(struct2.f5[1], Test::EnumSimple.ENUM_VALUE_2)
    assert_equal(struct2.f6.length, 2)
    assert_equal(struct2.f6[0], Test::EnumSimple.ENUM_VALUE_1)
    assert_true(struct2.f6[1].nil?)
    assert_equal(struct2.f7.length, 2)
    assert_equal(struct2.f7[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_equal(struct2.f7[1], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    assert_equal(struct2.f8.length, 2)
    assert_equal(struct2.f8[0], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_true(struct2.f8[1].nil?)
    assert_equal(struct2.f9.length, 2)
    assert_equal(struct2.f9[0].f2, true)
    assert_equal(struct2.f9[0].f12, 0xFF)
    assert_equal(struct2.f9[0].f32, 'Initial string!')
    assert_equal(struct2.f9[1].f2, true)
    assert_equal(struct2.f9[1].f12, 0xFF)
    assert_equal(struct2.f9[1].f32, 'Initial string!')
    assert_equal(struct2.f10.length, 2)
    assert_false(struct2.f10[0].nil?)
    assert_equal(struct2.f10[0].f2, true)
    assert_equal(struct2.f10[0].f12, 0xFF)
    assert_equal(struct2.f10[0].f32, 'Initial string!')
    assert_true(struct2.f10[1].nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_set
    # Create a new struct
    struct1 = Test::StructSet.new
    struct1.f1.add(48)
    struct1.f1.add(65)
    struct1.f1.add(97)
    struct1.f2.add(Test::EnumSimple.ENUM_VALUE_1)
    struct1.f2.add(Test::EnumSimple.ENUM_VALUE_2)
    struct1.f3.add(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    struct1.f3.add(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    s1 = Test::StructSimple.new
    s1.id = 48
    struct1.f4.add(s1)
    s2 = Test::StructSimple.new
    s2.id = 65
    struct1.f4.add(s2)

    # Serialize the struct to the FBE stream
    writer = Test::StructSetModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 132)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 843)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructSet.new
    reader = Test::StructSetModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 132)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    (struct2, deserialized) = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 3)
    assert_true(struct2.f1.include?(48))
    assert_true(struct2.f1.include?(65))
    assert_true(struct2.f1.include?(97))
    assert_equal(struct2.f2.length, 2)
    assert_true(struct2.f2.include?(Test::EnumSimple.ENUM_VALUE_1))
    assert_true(struct2.f2.include?(Test::EnumSimple.ENUM_VALUE_2))
    assert_equal(struct2.f3.length, 2)
    assert_true(struct2.f3.include?(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2))
    assert_true(struct2.f3.include?(Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3))
    assert_equal(struct2.f4.length, 2)
    assert_true(struct2.f4.include?(s1))
    assert_true(struct2.f4.include?(s2))
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_map
    # Create a new struct
    struct1 = Test::StructMap.new
    struct1.f1[10] = 48
    struct1.f1[20] = 65
    struct1.f2[10] = 97
    struct1.f2[20] = nil
    struct1.f3[10] = '000'
    struct1.f3[20] = 'AAA'
    struct1.f4[10] = 'aaa'
    struct1.f4[20] = nil
    struct1.f5[10] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f5[20] = Test::EnumSimple.ENUM_VALUE_2
    struct1.f6[10] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f6[20] = nil
    struct1.f7[10] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f7[20] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
    struct1.f8[10] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f8[20] = nil
    s1 = Test::StructSimple.new
    s1.id = 48
    struct1.f9[10] = s1
    s2 = Test::StructSimple.new
    s2.id = 65
    struct1.f9[20] = s2
    struct1.f10[10] = s1
    struct1.f10[20] = nil

    # Serialize the struct to the FBE stream
    writer = Test::StructMapModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 140)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 1450)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructMap.new
    reader = Test::StructMapModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 140)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1[10], 48)
    assert_equal(struct2.f1[20], 65)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2[10], 97)
    assert_true(struct2.f2[20].nil?)
    assert_equal(struct2.f3.length, 2)
    assert_equal(struct2.f3[10].length, 3)
    assert_equal(struct2.f3[20].length, 3)
    assert_equal(struct2.f4.length, 2)
    assert_equal(struct2.f4[10].length, 3)
    assert_true(struct2.f4[20].nil?)
    assert_equal(struct2.f5.length, 2)
    assert_equal(struct2.f5[10], Test::EnumSimple.ENUM_VALUE_1)
    assert_equal(struct2.f5[20], Test::EnumSimple.ENUM_VALUE_2)
    assert_equal(struct2.f6.length, 2)
    assert_equal(struct2.f6[10], Test::EnumSimple.ENUM_VALUE_1)
    assert_true(struct2.f6[20].nil?)
    assert_equal(struct2.f7.length, 2)
    assert_equal(struct2.f7[10], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_equal(struct2.f7[20], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    assert_equal(struct2.f8.length, 2)
    assert_equal(struct2.f8[10], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_true(struct2.f8[20].nil?)
    assert_equal(struct2.f9.length, 2)
    assert_equal(struct2.f9[10].id, 48)
    assert_equal(struct2.f9[20].id, 65)
    assert_equal(struct2.f10.length, 2)
    assert_equal(struct2.f10[10].id, 48)
    assert_true(struct2.f10[20].nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_hash
    # Create a new struct
    struct1 = Test::StructHash.new
    struct1.f1['10'] = 48
    struct1.f1['20'] = 65
    struct1.f2['10'] = 97
    struct1.f2['20'] = nil
    struct1.f3['10'] = '000'
    struct1.f3['20'] = 'AAA'
    struct1.f4['10'] = 'aaa'
    struct1.f4['20'] = nil
    struct1.f5['10'] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f5['20'] = Test::EnumSimple.ENUM_VALUE_2
    struct1.f6['10'] = Test::EnumSimple.ENUM_VALUE_1
    struct1.f6['20'] = nil
    struct1.f7['10'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f7['20'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3
    struct1.f8['10'] = Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2
    struct1.f8['20'] = nil
    s1 = Test::StructSimple.new
    s1.id = 48
    struct1.f9['10'] = s1
    s2 = Test::StructSimple.new
    s2.id = 65
    struct1.f9['20'] = s2
    struct1.f10['10'] = s1
    struct1.f10['20'] = nil

    # Serialize the struct to the FBE stream
    writer = Test::StructHashModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 141)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 1570)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructHash.new
    reader = Test::StructHashModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 141)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1['10'], 48)
    assert_equal(struct2.f1['20'], 65)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2['10'], 97)
    assert_true(struct2.f2['20'].nil?)
    assert_equal(struct2.f3.length, 2)
    assert_equal(struct2.f3['10'].length, 3)
    assert_equal(struct2.f3['20'].length, 3)
    assert_equal(struct2.f4.length, 2)
    assert_equal(struct2.f4['10'].length, 3)
    assert_true(struct2.f4['20'].nil?)
    assert_equal(struct2.f5.length, 2)
    assert_equal(struct2.f5['10'], Test::EnumSimple.ENUM_VALUE_1)
    assert_equal(struct2.f5['20'], Test::EnumSimple.ENUM_VALUE_2)
    assert_equal(struct2.f6.length, 2)
    assert_equal(struct2.f6['10'], Test::EnumSimple.ENUM_VALUE_1)
    assert_true(struct2.f6['20'].nil?)
    assert_equal(struct2.f7.length, 2)
    assert_equal(struct2.f7['10'], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_equal(struct2.f7['20'], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2 | Test::FlagsSimple.FLAG_VALUE_3)
    assert_equal(struct2.f8.length, 2)
    assert_equal(struct2.f8['10'], Test::FlagsSimple.FLAG_VALUE_1 | Test::FlagsSimple.FLAG_VALUE_2)
    assert_true(struct2.f8['20'].nil?)
    assert_equal(struct2.f9.length, 2)
    assert_equal(struct2.f9['10'].id, 48)
    assert_equal(struct2.f9['20'].id, 65)
    assert_equal(struct2.f10.length, 2)
    assert_equal(struct2.f10['10'].id, 48)
    assert_true(struct2.f10['20'].nil?)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_struct_hash_extended
    # Create a new struct
    struct1 = Test::StructHashEx.new
    s1 = Test::StructSimple.new
    s1.id = 48
    struct1.f1[s1] = Test::StructNested.new
    s2 = Test::StructSimple.new
    s2.id = 65
    struct1.f1[s2] = Test::StructNested.new
    struct1.f2[s1] = Test::StructNested.new
    struct1.f2[s2] = nil

    # Serialize the struct to the FBE stream
    writer = Test::StructHashExModel.new(FBE::WriteBuffer.new)
    assert_equal(writer.model.fbe_type, 142)
    assert_equal(writer.model.fbe_offset, 4)
    serialized = writer.serialize(struct1)
    assert_equal(serialized, writer.buffer.size)
    assert_true(writer.verify)
    writer.next(serialized)
    assert_equal(writer.model.fbe_offset, (4 + writer.buffer.size))

    # Check the serialized FBE size
    assert_equal(writer.buffer.size, 7879)

    # Deserialize the struct from the FBE stream
    # noinspection RubyUnusedLocalVariable
    struct2 = Test::StructHashEx.new
    reader = Test::StructHashExModel.new(FBE::ReadBuffer.new)
    assert_equal(reader.model.fbe_type, 142)
    assert_equal(reader.model.fbe_offset, 4)
    reader.attach_buffer(writer.buffer)
    assert_true(reader.verify)
    struct2, deserialized = reader.deserialize(struct2)
    assert_equal(deserialized, reader.buffer.size)
    reader.next(deserialized)
    assert_equal(reader.model.fbe_offset, (4 + reader.buffer.size))

    assert_equal(struct2.f1.length, 2)
    assert_equal(struct2.f1[s1].f1002, Test::EnumTyped.ENUM_VALUE_2)
    assert_equal(struct2.f1[s2].f1002, Test::EnumTyped.ENUM_VALUE_2)
    assert_equal(struct2.f2.length, 2)
    assert_equal(struct2.f2[s1].f1002, Test::EnumTyped.ENUM_VALUE_2)
    assert_true(struct2.f2[s2].nil?)
  end
end
