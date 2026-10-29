using Xunit;

using com.chronoxor.test;

namespace Tests
{
    public class TestConstants
    {
        [Fact(DisplayName = "Constants: enum and flags constants stay unchanged")]
        public void ReadOnlyConstants()
        {
            // Combining flags from a constant returns the combination and leaves the constant as it was
            var flags1 = FlagsTyped.FLAG_VALUE_2.SetFlags(FlagsTyped.FLAG_VALUE_4);
            Assert.True(flags1.Value == 0x0A);
            Assert.True(FlagsTyped.FLAG_VALUE_2.Value == 0x02);

            var flags2 = FlagsTyped.FLAG_VALUE_9.RemoveFlags(FlagsTyped.FLAG_VALUE_4);
            Assert.True(flags2.Value == 0x22);
            Assert.True(FlagsTyped.FLAG_VALUE_9.Value == 0x2A);

            // A copy is the caller's own to change
            var flags3 = FlagsTyped.FLAG_VALUE_2;
            flags3.SetFlags(FlagsTyped.FLAG_VALUE_6);
            Assert.True(flags3.Value == 0x22);
            Assert.True(FlagsTyped.FLAG_VALUE_2.Value == 0x02);
        }
    }
}
