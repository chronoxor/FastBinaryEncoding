import decimal
import fbe
import struct
from unittest import TestCase


class TestDecimal(TestCase):

    @staticmethod
    def verify_decimal(low, mid, high, negative, scale):
        flags = (scale << 16) | 0x80000000 if negative else (scale << 16)

        buffer = bytearray(16)
        struct.pack_into("<I", buffer, 0, low)
        struct.pack_into("<I", buffer, 4, mid)
        struct.pack_into("<I", buffer, 8, high)
        struct.pack_into("<I", buffer, 12, flags)

        read_buffer = fbe.ReadBuffer()
        read_buffer.attach_buffer(buffer)

        model = fbe.FieldModelDecimal(read_buffer, 0)
        value1 = model.get()
        model.set(value1)
        value2 = model.get()

        if value1 != value2:
            raise Exception("Invalid decimal serialization!")

        final_model = fbe.FinalModelDecimal(read_buffer, 0)
        value3 = final_model.get()
        final_model.set(value3[0])
        value4 = final_model.get()

        if (value1 != value3[0]) or (value2 != value4[0]) or (value3[1] != 16) or (value4[1] != 16):
            raise Exception("Invalid decimal final serialization!")

        return value1

    def test_decimal(self):
        # FBE decimal exponent ranging from 0 to 28
        decimal.getcontext().prec = 29
        self.assertEqual(self.verify_decimal(0x00000000, 0x00000000, 0x00000000, False, 0x00000000), decimal.Decimal("0"))
        self.assertEqual(self.verify_decimal(0x00000001, 0x00000000, 0x00000000, False, 0x00000000), decimal.Decimal("1"))
        self.assertEqual(self.verify_decimal(0x107A4000, 0x00005AF3, 0x00000000, False, 0x00000000), decimal.Decimal("100000000000000"))
        self.assertEqual(self.verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, False, 0x000E0000 >> 16), decimal.Decimal("100000000000000.00000000000000"))
        self.assertEqual(self.verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, False, 0x00000000), decimal.Decimal("10000000000000000000000000000"))
        self.assertEqual(self.verify_decimal(0x10000000, 0x3E250261, 0x204FCE5E, False, 0x001C0000 >> 16), decimal.Decimal("1.0000000000000000000000000000"))
        self.assertEqual(self.verify_decimal(0x075BCD15, 0x00000000, 0x00000000, False, 0x00000000), decimal.Decimal("123456789"))
        self.assertEqual(self.verify_decimal(0x075BCD15, 0x00000000, 0x00000000, False, 0x00090000 >> 16), decimal.Decimal("0.123456789"))
        self.assertEqual(self.verify_decimal(0x075BCD15, 0x00000000, 0x00000000, False, 0x00120000 >> 16), decimal.Decimal("0.000000000123456789"))
        self.assertEqual(self.verify_decimal(0x075BCD15, 0x00000000, 0x00000000, False, 0x001B0000 >> 16), decimal.Decimal("0.000000000000000000123456789"))
        self.assertEqual(self.verify_decimal(0xFFFFFFFF, 0x00000000, 0x00000000, False, 0x00000000), decimal.Decimal("4294967295"))
        self.assertEqual(self.verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, False, 0x00000000), decimal.Decimal("18446744073709551615"))
        self.assertEqual(self.verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, False, 0x00000000), decimal.Decimal("79228162514264337593543950335"))
        self.assertEqual(self.verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, True, 0x00000000), decimal.Decimal("-79228162514264337593543950335"))
        self.assertEqual(self.verify_decimal(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, True, 0x001C0000 >> 16), decimal.Decimal("-7.9228162514264337593543950335"))
