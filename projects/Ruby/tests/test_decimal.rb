require 'test/unit'

require 'bigdecimal'
require_relative '../proto/fbe'

class TestDecimal < Test::Unit::TestCase
  def verify_decimal(low, mid, high, negative, scale)
    flags = negative ? ((scale << 16) | 0x80000000) : (scale << 16)

    buffer = [0].pack('C') * 16
    buffer[0, 4] = [low].pack('L<')
    buffer[4, 4] = [mid].pack('L<')
    buffer[8, 4] = [high].pack('L<')
    buffer[12, 4] = [flags].pack('L<')

    read_buffer = FBE::ReadBuffer.new
    read_buffer.attach_buffer(buffer)

    model = FBE::FieldModelDecimal.new(read_buffer, 0)
    value1 = model.get
    model.set(value1)
    value2 = model.get

    raise "Invalid decimal serialization!" if value1 != value2

    final_model = FBE::FinalModelDecimal.new(read_buffer, 0)
    value3 = final_model.get
    final_model.set(value3[0])
    value4 = final_model.get

    raise "Invalid decimal final serialization!" if (value1 != value3[0]) || (value2 != value4[0]) || (value3[1] != 16) || (value4[1] != 16)

    value1
  end

  def test_decimal
    # FBE decimal exponent ranging from 0 to 28
    BigDecimal.limit(29)
    assert_equal(verify_decimal(0x00000000, 0x00000000, 0x00000000, false, 0x00000000), BigDecimal('0'))
    assert_equal(verify_decimal(0x00000001, 0x00000000, 0x00000000, false, 0x00000000), BigDecimal('1'))
    assert_equal(verify_decimal(0x107A4000, 0x00005AF3, 0x00000000, false, 0x00000000), BigDecimal('100000000000000'))
    assert_equal(verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x000E0000 >> 16), BigDecimal('100000000000000.00000000000000'))
    assert_equal(verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x00000000), BigDecimal('10000000000000000000000000000'))
    assert_equal(verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x001C0000 >> 16), BigDecimal('1.0000000000000000000000000000'))
    assert_equal(verify_decimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00000000), BigDecimal('123456789'))
    assert_equal(verify_decimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00090000 >> 16), BigDecimal('0.123456789'))
    assert_equal(verify_decimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00120000 >> 16), BigDecimal('0.000000000123456789'))
    assert_equal(verify_decimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x001B0000 >> 16), BigDecimal('0.000000000000000000123456789'))
    assert_equal(verify_decimal(0xFFFFFFFF, 0x00000000, 0x00000000, false, 0x00000000), BigDecimal('4294967295'))
    assert_equal(verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, false, 0x00000000), BigDecimal('18446744073709551615'))
    assert_equal(verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, false, 0x00000000), BigDecimal('79228162514264337593543950335'))
    assert_equal(verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x00000000), BigDecimal('-79228162514264337593543950335'))
    assert_equal(verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, true, 0x001C0000 >> 16), BigDecimal('-7.9228162514264337593543950335'))
  end
end
