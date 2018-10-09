package tests

import java.math.*
import kotlin.test.*
import org.testng.annotations.*

class TestDecimal
{
    private val _sign = java.lang.Integer.parseUnsignedInt("80000000", 16)

    @Throws(Exception::class)
    private fun verifyDecimal(low: Int, mid: Int, high: Int, negative: Boolean, scale: Byte): BigDecimal {
        val flags = if (negative) ((scale.toInt() shl 16) or _sign) else (scale.toInt() shl 16)

        val buffer = ByteArray(16)
        fbe.Buffer.write(buffer, 0, low)
        fbe.Buffer.write(buffer, 4, mid)
        fbe.Buffer.write(buffer, 8, high)
        fbe.Buffer.write(buffer, 12, flags)

        val model = fbe.FieldModelDecimal(fbe.Buffer(buffer), 0)
        val value1 = model.get()
        model.set(value1)
        if ((fbe.Buffer.readInt32(buffer, 0) != low) ||
            (fbe.Buffer.readInt32(buffer, 4) != mid) ||
            (fbe.Buffer.readInt32(buffer, 8) != high) ||
            (fbe.Buffer.readInt32(buffer, 12) != flags))
            throw Exception("Invalid decimal serialization!")

        val finalModel = fbe.FinalModelDecimal(fbe.Buffer(buffer), 0)
        val size = fbe.Size()
        val value2 = finalModel.get(size)
        finalModel.set(value2)
        if ((fbe.Buffer.readInt32(buffer, 0) != low) ||
            (fbe.Buffer.readInt32(buffer, 4) != mid) ||
            (fbe.Buffer.readInt32(buffer, 8) != high) ||
            (fbe.Buffer.readInt32(buffer, 12) != flags) ||
            (size.value != 16L) || (value1.compareTo(value2) != 0))
            throw Exception("Invalid decimal final serialization!")

        return value1
    }

    @Test
    @Throws(Exception::class)
    fun decimalTests() {
        assertEquals(verifyDecimal(0x00000000, 0x00000000, 0x00000000, false, 0x00000000.toByte()), BigDecimal("0"))
        assertEquals(verifyDecimal(0x00000001, 0x00000000, 0x00000000, false, 0x00000000.toByte()), BigDecimal("1"))
        assertEquals(verifyDecimal(0x107A4000, 0x00005AF3, 0x00000000, false, 0x00000000.toByte()), BigDecimal("100000000000000"))
        assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (0x000E0000 shr 16).toByte()), BigDecimal("100000000000000.00000000000000"))
        assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x00000000.toByte()), BigDecimal("10000000000000000000000000000"))
        assertEquals(verifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, (0x001C0000 shr 16).toByte()), BigDecimal("1.0000000000000000000000000000"))
        assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00000000.toByte()), BigDecimal("123456789"))
        assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (0x00090000 shr 16).toByte()), BigDecimal("0.123456789"))
        assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (0x00120000 shr 16).toByte()), BigDecimal("0.000000000123456789"))
        assertEquals(verifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, (0x001B0000 shr 16).toByte()), BigDecimal("0.000000000000000000123456789"))
        assertEquals(verifyDecimal(-0x1, 0x00000000, 0x00000000, false, 0x00000000.toByte()), BigDecimal("4294967295"))
        assertEquals(verifyDecimal(-0x1, -0x1, 0x00000000, false, 0x00000000.toByte()), BigDecimal("18446744073709551615"))
        assertEquals(verifyDecimal(-0x1, -0x1, 0x00000000, false, 0x00000000.toByte()), BigDecimal("18446744073709551615"))
        assertEquals(verifyDecimal(-0x1, -0x1, -0x1, false, 0x00000000.toByte()), BigDecimal("79228162514264337593543950335"))
        assertEquals(verifyDecimal(-0x1, -0x1, -0x1, true, 0x00000000.toByte()), BigDecimal("-79228162514264337593543950335"))
        assertEquals(verifyDecimal(-0x1, -0x1, -0x1, true, (0x001C0000 shr 16).toByte()), BigDecimal("-7.9228162514264337593543950335"))
    }
}
