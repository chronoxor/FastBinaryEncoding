require 'test/unit'

require_relative '../proto/test'

class TestSerializationJson < Test::Unit::TestCase
  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_json_domain
    # Define a source JSON string
    json = '{"id":1,"name":"Test","state":6,"wallet":{"currency":"USD","amount":1000.0},"asset":{"currency":"EUR","amount":100.0},"orders":[{"id":1,"symbol":"EURUSD","side":0,"type":0,"price":1.23456,"volume":1000.0},{"id":2,"symbol":"EURUSD","side":1,"type":1,"price":1.0,"volume":100.0},{"id":3,"symbol":"EURUSD","side":0,"type":2,"price":1.5,"volume":10.0}]}'

    # Create a new account from the source JSON string
    account1 = Proto::Account.from_json(json)

    # Serialize the account to the JSON string
    json = account1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the account from the JSON string
    account2 = Proto::Account.from_json(json)

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
  def test_serialization_json_struct_simple
    # Define a source JSON string
    json = '{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145597933463000,"f36":"00000000-0000-0000-0000-000000000000","f37":"e7854072-f0a5-11e8-8f69-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructSimple.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructSimple.from_json(json)

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
  def test_serialization_json_struct_optional
    # Define a source JSON string
    json = '{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145860677797000,"f36":"00000000-0000-0000-0000-000000000000","f37":"8420d1c6-f0a6-11e8-80fc-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]},"f100":null,"f101":true,"f102":null,"f103":null,"f104":255,"f105":null,"f106":null,"f107":33,"f108":null,"f109":null,"f110":1092,"f111":null,"f112":null,"f113":127,"f114":null,"f115":null,"f116":255,"f117":null,"f118":null,"f119":32767,"f120":null,"f121":null,"f122":65535,"f123":null,"f124":null,"f125":2147483647,"f126":null,"f127":null,"f128":4294967295,"f129":null,"f130":null,"f131":9223372036854775807,"f132":null,"f133":null,"f134":18446744073709551615,"f135":null,"f136":null,"f137":123.456,"f138":null,"f139":null,"f140":-1.23456e+125,"f141":null,"f142":null,"f143":"123456.123456","f144":null,"f145":null,"f146":"Initial string!","f147":null,"f148":null,"f149":1543145860678429000,"f150":null,"f151":null,"f152":"123e4567-e89b-12d3-a456-426655440000","f153":null,"f154":null,"f155":null,"f156":null,"f157":null,"f158":null,"f159":null,"f160":null,"f161":null,"f162":null,"f163":null,"f164":null,"f165":null}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructOptional.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructOptional.from_json(json)

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
  def test_serialization_json_struct_nested
    # Define a source JSON string
    json = '{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145901646321000,"f36":"00000000-0000-0000-0000-000000000000","f37":"9c8c268e-f0a6-11e8-a777-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]},"f100":null,"f101":true,"f102":null,"f103":null,"f104":255,"f105":null,"f106":null,"f107":33,"f108":null,"f109":null,"f110":1092,"f111":null,"f112":null,"f113":127,"f114":null,"f115":null,"f116":255,"f117":null,"f118":null,"f119":32767,"f120":null,"f121":null,"f122":65535,"f123":null,"f124":null,"f125":2147483647,"f126":null,"f127":null,"f128":4294967295,"f129":null,"f130":null,"f131":9223372036854775807,"f132":null,"f133":null,"f134":18446744073709551615,"f135":null,"f136":null,"f137":123.456,"f138":null,"f139":null,"f140":-1.23456e+125,"f141":null,"f142":null,"f143":"123456.123456","f144":null,"f145":null,"f146":"Initial string!","f147":null,"f148":null,"f149":1543145901647155000,"f150":null,"f151":null,"f152":"123e4567-e89b-12d3-a456-426655440000","f153":null,"f154":null,"f155":null,"f156":null,"f157":null,"f158":null,"f159":null,"f160":null,"f161":null,"f162":null,"f163":null,"f164":null,"f165":null,"f1000":0,"f1001":null,"f1002":50,"f1003":null,"f1004":0,"f1005":null,"f1006":42,"f1007":null,"f1008":{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145901647367000,"f36":"00000000-0000-0000-0000-000000000000","f37":"9c8c54c4-f0a6-11e8-a777-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},"f1009":null,"f1010":{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145901648310000,"f36":"00000000-0000-0000-0000-000000000000","f37":"9c8c6b76-f0a6-11e8-a777-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]},"f100":null,"f101":true,"f102":null,"f103":null,"f104":255,"f105":null,"f106":null,"f107":33,"f108":null,"f109":null,"f110":1092,"f111":null,"f112":null,"f113":127,"f114":null,"f115":null,"f116":255,"f117":null,"f118":null,"f119":32767,"f120":null,"f121":null,"f122":65535,"f123":null,"f124":null,"f125":2147483647,"f126":null,"f127":null,"f128":4294967295,"f129":null,"f130":null,"f131":9223372036854775807,"f132":null,"f133":null,"f134":18446744073709551615,"f135":null,"f136":null,"f137":123.456,"f138":null,"f139":null,"f140":-1.23456e+125,"f141":null,"f142":null,"f143":"123456.123456","f144":null,"f145":null,"f146":"Initial string!","f147":null,"f148":null,"f149":1543145901648871000,"f150":null,"f151":null,"f152":"123e4567-e89b-12d3-a456-426655440000","f153":null,"f154":null,"f155":null,"f156":null,"f157":null,"f158":null,"f159":null,"f160":null,"f161":null,"f162":null,"f163":null,"f164":null,"f165":null},"f1011":null}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructNested.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructNested.from_json(json)

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
  def test_serialization_json_struct_bytes
    # Define a source JSON string
    json = '{"f1":"QUJD","f2":"dGVzdA==","f3":null}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructBytes.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructBytes.from_json(json)

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
  def test_serialization_json_struct_array
    # Define a source JSON string
    json = '{"f1":[48,65],"f2":[97,null],"f3":["MDAw","QUFB"],"f4":["YWFh",null],"f5":[1,2],"f6":[1,null],"f7":[3,7],"f8":[3,null],"f9":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145986060361000,"f36":"00000000-0000-0000-0000-000000000000","f37":"cedcad98-f0a6-11e8-9f47-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145986060910000,"f36":"00000000-0000-0000-0000-000000000000","f37":"cedcc274-f0a6-11e8-9f47-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}],"f10":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543145986061436000,"f36":"00000000-0000-0000-0000-000000000000","f37":"cedcd714-f0a6-11e8-9f47-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},null]}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructArray.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructArray.from_json(json)

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
  def test_serialization_json_struct_vector
    # Define a source JSON string
    json = '{"f1":[48,65],"f2":[97,null],"f3":["MDAw","QUFB"],"f4":["YWFh",null],"f5":[1,2],"f6":[1,null],"f7":[3,7],"f8":[3,null],"f9":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146157127964000,"f36":"00000000-0000-0000-0000-000000000000","f37":"34d38702-f0a7-11e8-b30e-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146157128572000,"f36":"00000000-0000-0000-0000-000000000000","f37":"34d39c88-f0a7-11e8-b30e-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}],"f10":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146157129063000,"f36":"00000000-0000-0000-0000-000000000000","f37":"34d3b038-f0a7-11e8-b30e-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},null]}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructVector.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructVector.from_json(json)

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
  def test_serialization_json_struct_list
    # Define a source JSON string
    json = '{"f1":[48,65],"f2":[97,null],"f3":["MDAw","QUFB"],"f4":["YWFh",null],"f5":[1,2],"f6":[1,null],"f7":[3,7],"f8":[3,null],"f9":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146220253760000,"f36":"00000000-0000-0000-0000-000000000000","f37":"5a73e7fe-f0a7-11e8-89e6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146220255725000,"f36":"00000000-0000-0000-0000-000000000000","f37":"5a741990-f0a7-11e8-89e6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}],"f10":[{"id":0,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146220256802000,"f36":"00000000-0000-0000-0000-000000000000","f37":"5a74e4b0-f0a7-11e8-89e6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},null]}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructList.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructList.from_json(json)

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
  def test_serialization_json_struct_set
    # Define a source JSON string
    json = '{"f1":[48,65,97],"f2":[1,2],"f3":[3,7],"f4":[{"id":48,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146299848353000,"f36":"00000000-0000-0000-0000-000000000000","f37":"89e4edd0-f0a7-11e8-9dde-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},{"id":65,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146299848966000,"f36":"00000000-0000-0000-0000-000000000000","f37":"89e503f6-f0a7-11e8-9dde-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}]}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructSet.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructSet.from_json(json)

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
    s1 = Test::StructSimple.new
    s1.id = 48
    assert_true(struct2.f4.include?(s1))
    s2 = Test::StructSimple.new
    s2.id = 65
    assert_true(struct2.f4.include?(s2))
  end

  # noinspection RubyInstanceMethodNamingConvention
  def test_serialization_json_struct_map
    # Define a source JSON string
    json = '{"f1":{"10":48,"20":65},"f2":{"10":97,"20":null},"f3":{"10":"MDAw","20":"QUFB"},"f4":{"10":"YWFh","20":null},"f5":{"10":1,"20":2},"f6":{"10":1,"20":null},"f7":{"10":3,"20":7},"f8":{"10":3,"20":null},"f9":{"10":{"id":48,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146345803483000,"f36":"00000000-0000-0000-0000-000000000000","f37":"a549215e-f0a7-11e8-90f6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},"20":{"id":65,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146345804184000,"f36":"00000000-0000-0000-0000-000000000000","f37":"a54942ce-f0a7-11e8-90f6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}},"f10":{"10":{"id":48,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146345803483000,"f36":"00000000-0000-0000-0000-000000000000","f37":"a549215e-f0a7-11e8-90f6-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},"20":null}}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructMap.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructMap.from_json(json)

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
  def test_serialization_json_struct_hash
    # Define a source JSON string
    json = '{"f1":{"10":48,"20":65},"f2":{"10":97,"20":null},"f3":{"10":"MDAw","20":"QUFB"},"f4":{"10":"YWFh","20":null},"f5":{"10":1,"20":2},"f6":{"10":1,"20":null},"f7":{"10":3,"20":7},"f8":{"10":3,"20":null},"f9":{"10":{"id":48,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146381450913000,"f36":"00000000-0000-0000-0000-000000000000","f37":"ba8885d2-f0a7-11e8-81fa-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},"20":{"id":65,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146381452825000,"f36":"00000000-0000-0000-0000-000000000000","f37":"ba88ced4-f0a7-11e8-81fa-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}}},"f10":{"10":{"id":48,"f1":false,"f2":true,"f3":0,"f4":255,"f5":0,"f6":33,"f7":0,"f8":1092,"f9":0,"f10":127,"f11":0,"f12":255,"f13":0,"f14":32767,"f15":0,"f16":65535,"f17":0,"f18":2147483647,"f19":0,"f20":4294967295,"f21":0,"f22":9223372036854775807,"f23":0,"f24":18446744073709551615,"f25":0.0,"f26":123.456,"f27":0.0,"f28":-1.23456e+125,"f29":"0.0","f30":"123456.123456","f31":"","f32":"Initial string!","f33":0,"f34":0,"f35":1543146381450913000,"f36":"00000000-0000-0000-0000-000000000000","f37":"ba8885d2-f0a7-11e8-81fa-ac220bcdd8e0","f38":"123e4567-e89b-12d3-a456-426655440000","f39":0,"f40":0,"f41":{"id":0,"symbol":"","side":0,"type":0,"price":0.0,"volume":0.0},"f42":{"currency":"","amount":0.0},"f43":0,"f44":{"id":0,"name":"","state":11,"wallet":{"currency":"","amount":0.0},"asset":null,"orders":[]}},"20":null}}'

    # Create a new struct from the source JSON string
    struct1 = Test::StructHash.from_json(json)

    # Serialize the struct to the JSON string
    json = struct1.to_json

    # Check the serialized JSON size
    assert_true(json.length > 0)

    # Deserialize the struct from the JSON string
    struct2 = Test::StructHash.from_json(json)

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
end
