package tests

import java.math.*
import kotlin.test.*
import org.testng.annotations.*

import com.chronoxor.fbe.*

class TestDecimal
{
    private val _sign = 0x80000000u

    @Throws(Exception::class)
    private fun verifyDecimal(low: UInt, mid: UInt, high: UInt, negative: Boolean, scale: Byte): BigDecimal {
        val flags = if (negative) ((scale.toUInt() shl 16) or _sign) else (scale.toUInt() shl 16)

        val buffer = ByteArray(16)
        Buffer.write(buffer, 0, low)
        Buffer.write(buffer, 4, mid)
        Buffer.write(buffer, 8, high)
        Buffer.write(buffer, 12, flags)

        val model = FieldModelDecimal(Buffer(buffer), 0)
        val value1 = model.get()
        model.set(value1)
        if ((Buffer.readUInt32(buffer, 0) != low) ||
            (Buffer.readUInt32(buffer, 4) != mid) ||
            (Buffer.readUInt32(buffer, 8) != high) ||
            (Buffer.readUInt32(buffer, 12) != flags))
            throw Exception("Invalid decimal serialization!")

        val finalModel = FinalModelDecimal(Buffer(buffer), 0)
        val size = Size()
        val value2 = finalModel.get(size)
        finalModel.set(value2)
        if ((Buffer.readUInt32(buffer, 0) != low) ||
            (Buffer.readUInt32(buffer, 4) != mid) ||
            (Buffer.readUInt32(buffer, 8) != high) ||
            (Buffer.readUInt32(buffer, 12) != flags) ||
            (size.value != 16L) || (value1.compareTo(value2) != 0))
            throw Exception("Invalid decimal final serialization!")

        return value1
    }

    @Test
    @Throws(Exception::class)
    fun decimalTests() {
        assertEquals(verifyDecimal(0x00000000u, 0x00000000u, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("0"))
        assertEquals(verifyDecimal(0x00000001u, 0x00000000u, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("1"))
        assertEquals(verifyDecimal(0x107A4000u, 0x00005AF3u, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("100000000000000"))
        assertEquals(verifyDecimal(0x10000000u, 0x3E250261u, 0x204FCE5Eu, false, (0x000E0000 shr 16).toByte()), BigDecimal("100000000000000.00000000000000"))
        assertEquals(verifyDecimal(0x10000000u, 0x3E250261u, 0x204FCE5Eu, false, 0x00000000.toByte()), BigDecimal("10000000000000000000000000000"))
        assertEquals(verifyDecimal(0x10000000u, 0x3E250261u, 0x204FCE5Eu, false, (0x001C0000 shr 16).toByte()), BigDecimal("1.0000000000000000000000000000"))
        assertEquals(verifyDecimal(0x075BCD15u, 0x00000000u, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("123456789"))
        assertEquals(verifyDecimal(0x075BCD15u, 0x00000000u, 0x00000000u, false, (0x00090000 shr 16).toByte()), BigDecimal("0.123456789"))
        assertEquals(verifyDecimal(0x075BCD15u, 0x00000000u, 0x00000000u, false, (0x00120000 shr 16).toByte()), BigDecimal("0.000000000123456789"))
        assertEquals(verifyDecimal(0x075BCD15u, 0x00000000u, 0x00000000u, false, (0x001B0000 shr 16).toByte()), BigDecimal("0.000000000000000000123456789"))
        assertEquals(verifyDecimal(0xFFFFFFFFu, 0x00000000u, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("4294967295"))
        assertEquals(verifyDecimal(0xFFFFFFFFu, 0xFFFFFFFFu, 0x00000000u, false, 0x00000000.toByte()), BigDecimal("18446744073709551615"))
        assertEquals(verifyDecimal(0xFFFFFFFFu, 0xFFFFFFFFu, 0xFFFFFFFFu, false, 0x00000000.toByte()), BigDecimal("79228162514264337593543950335"))
        assertEquals(verifyDecimal(0xFFFFFFFFu, 0xFFFFFFFFu, 0xFFFFFFFFu, true, 0x00000000.toByte()), BigDecimal("-79228162514264337593543950335"))
        assertEquals(verifyDecimal(0xFFFFFFFFu, 0xFFFFFFFFu, 0xFFFFFFFFu, true, (0x001C0000 shr 16).toByte()), BigDecimal("-7.9228162514264337593543950335"))
    }
}
