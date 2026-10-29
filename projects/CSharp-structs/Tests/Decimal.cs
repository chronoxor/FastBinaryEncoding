// ReSharper disable CompareOfFloatsByEqualityOperator
// ReSharper disable RedundantAssignment

using System;
using Xunit;

namespace Tests
{
    public class TestDecimal
    {
        private decimal VerifyDecimal(int low, int mid, int high, bool negative, byte scale)
        {
            var value1 = new decimal(low, mid, high, negative, scale);
            int[] bits = System.Decimal.GetBits(value1);

            if ((bits[0] != low) || (bits[1] != mid) || (bits[2] != high) || (negative ? (bits[3] != (int)((scale << 16) | 0x80000000)) : (bits[3] != (scale << 16))))
                throw new Exception("Invalid decimal bits!");

            var model = new com.chronoxor.FBE.FieldModelDecimal(new com.chronoxor.FBE.Buffer(new byte[16]), 0);
            model.Set(value1);
            model.Get(out var value2);
            if (value1 != value2)
                throw new Exception("Invalid decimal serialization!");

            var final = new com.chronoxor.FBE.FinalModelDecimal(new com.chronoxor.FBE.Buffer(new byte[16]), 0);
            final.Set(value1);
            final.Get(out var value3);
            if (value1 != value3)
                throw new Exception("Invalid decimal final serialization!");

            return value1;
        }

        [Fact(DisplayName = "Decimal tests")]
        public void DecimalTests()
        {
            Assert.True(VerifyDecimal(0x00000000, 0x00000000, 0x00000000, false, 0x00000000) == 0M);
            Assert.True(VerifyDecimal(0x00000001, 0x00000000, 0x00000000, false, 0x00000000) == 1M);
            Assert.True(VerifyDecimal(0x107A4000, 0x00005AF3, 0x00000000, false, 0x00000000) == 100000000000000M);
            Assert.True(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x00000000) == 10000000000000000000000000000M);
            Assert.True(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x000E0000 >> 16) == 100000000000000.00000000000000M);
            Assert.True(VerifyDecimal(0x10000000, 0x3E250261, 0x204FCE5E, false, 0x001C0000 >> 16) == 1.0000000000000000000000000000M);
            Assert.True(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00000000) == 123456789M);
            Assert.True(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00090000 >> 16) == 0.123456789M);
            Assert.True(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x00120000 >> 16) == 0.000000000123456789M);
            Assert.True(VerifyDecimal(0x075BCD15, 0x00000000, 0x00000000, false, 0x001B0000 >> 16) == 0.000000000000000000123456789M);
            Assert.True(VerifyDecimal(unchecked((int)0xFFFFFFFF), 0x00000000, 0x00000000, false, 0x00000000) == 4294967295M);
            Assert.True(VerifyDecimal(unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), 0x00000000, false, 0x00000000) == 18446744073709551615M);
            Assert.True(VerifyDecimal(unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), false, 0x00000000) == decimal.MaxValue);
            Assert.True(VerifyDecimal(unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), true, 0x00000000) == decimal.MinValue);
            Assert.True(VerifyDecimal(unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), unchecked((int)0xFFFFFFFF), true, 0x001C0000 >> 16) == -7.9228162514264337593543950335M);
        }
    }
}
