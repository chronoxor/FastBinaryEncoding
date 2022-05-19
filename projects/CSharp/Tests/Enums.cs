using Xunit;

using com.chronoxor.enums;
using com.chronoxor.enums.FBE;

namespace Tests
{
    public class TestEnums
    {
        [Fact(DisplayName = "Serialization: enums")]
        public void SerializationEnums()
        {
            var enums1 = Enums.Default;

            // Serialize enums to the FBE stream
            var writer = new EnumsModel();
            Assert.True(writer.model.FBEOffset == 4);
            long serialized = writer.Serialize(enums1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);
            Assert.True(writer.model.FBEOffset == (4 + writer.Buffer.Size));

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 232);

            // Deserialize enums from the FBE stream
            var reader = new EnumsModel();
            Assert.True(reader.model.FBEOffset == 4);
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var enums2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);
            Assert.True(reader.model.FBEOffset == (4 + reader.Buffer.Size));

            Assert.True(enums2.byte0 == EnumByte.ENUM_VALUE_0);
            Assert.True(enums2.byte1 == EnumByte.ENUM_VALUE_1);
            Assert.True(enums2.byte2 == EnumByte.ENUM_VALUE_2);
            Assert.True(enums2.byte3 == EnumByte.ENUM_VALUE_3);
            Assert.True(enums2.byte4 == EnumByte.ENUM_VALUE_4);
            Assert.True(enums2.byte5 == enums1.byte3);

            Assert.True(enums2.char0 == EnumChar.ENUM_VALUE_0);
            Assert.True(enums2.char1 == EnumChar.ENUM_VALUE_1);
            Assert.True(enums2.char2 == EnumChar.ENUM_VALUE_2);
            Assert.True(enums2.char3 == EnumChar.ENUM_VALUE_3);
            Assert.True(enums2.char4 == EnumChar.ENUM_VALUE_4);
            Assert.True(enums2.char5 == enums1.char3);

            Assert.True(enums2.wchar0 == EnumWChar.ENUM_VALUE_0);
            Assert.True(enums2.wchar1 == EnumWChar.ENUM_VALUE_1);
            Assert.True(enums2.wchar2 == EnumWChar.ENUM_VALUE_2);
            Assert.True(enums2.wchar3 == EnumWChar.ENUM_VALUE_3);
            Assert.True(enums2.wchar4 == EnumWChar.ENUM_VALUE_4);
            Assert.True(enums2.wchar5 == enums1.wchar3);

            Assert.True(enums2.int8b0 == EnumInt8.ENUM_VALUE_0);
            Assert.True(enums2.int8b1 == EnumInt8.ENUM_VALUE_1);
            Assert.True(enums2.int8b2 == EnumInt8.ENUM_VALUE_2);
            Assert.True(enums2.int8b3 == EnumInt8.ENUM_VALUE_3);
            Assert.True(enums2.int8b4 == EnumInt8.ENUM_VALUE_4);
            Assert.True(enums2.int8b5 == enums1.int8b3);

            Assert.True(enums2.uint8b0 == EnumUInt8.ENUM_VALUE_0);
            Assert.True(enums2.uint8b1 == EnumUInt8.ENUM_VALUE_1);
            Assert.True(enums2.uint8b2 == EnumUInt8.ENUM_VALUE_2);
            Assert.True(enums2.uint8b3 == EnumUInt8.ENUM_VALUE_3);
            Assert.True(enums2.uint8b4 == EnumUInt8.ENUM_VALUE_4);
            Assert.True(enums2.uint8b5 == enums1.uint8b3);

            Assert.True(enums2.int16b0 == EnumInt16.ENUM_VALUE_0);
            Assert.True(enums2.int16b1 == EnumInt16.ENUM_VALUE_1);
            Assert.True(enums2.int16b2 == EnumInt16.ENUM_VALUE_2);
            Assert.True(enums2.int16b3 == EnumInt16.ENUM_VALUE_3);
            Assert.True(enums2.int16b4 == EnumInt16.ENUM_VALUE_4);
            Assert.True(enums2.int16b5 == enums1.int16b3);

            Assert.True(enums2.uint16b0 == EnumUInt16.ENUM_VALUE_0);
            Assert.True(enums2.uint16b1 == EnumUInt16.ENUM_VALUE_1);
            Assert.True(enums2.uint16b2 == EnumUInt16.ENUM_VALUE_2);
            Assert.True(enums2.uint16b3 == EnumUInt16.ENUM_VALUE_3);
            Assert.True(enums2.uint16b4 == EnumUInt16.ENUM_VALUE_4);
            Assert.True(enums2.uint16b5 == enums1.uint16b3);

            Assert.True(enums2.int32b0 == EnumInt32.ENUM_VALUE_0);
            Assert.True(enums2.int32b1 == EnumInt32.ENUM_VALUE_1);
            Assert.True(enums2.int32b2 == EnumInt32.ENUM_VALUE_2);
            Assert.True(enums2.int32b3 == EnumInt32.ENUM_VALUE_3);
            Assert.True(enums2.int32b4 == EnumInt32.ENUM_VALUE_4);
            Assert.True(enums2.int32b5 == enums1.int32b3);

            Assert.True(enums2.uint32b0 == EnumUInt32.ENUM_VALUE_0);
            Assert.True(enums2.uint32b1 == EnumUInt32.ENUM_VALUE_1);
            Assert.True(enums2.uint32b2 == EnumUInt32.ENUM_VALUE_2);
            Assert.True(enums2.uint32b3 == EnumUInt32.ENUM_VALUE_3);
            Assert.True(enums2.uint32b4 == EnumUInt32.ENUM_VALUE_4);
            Assert.True(enums2.uint32b5 == enums1.uint32b3);

            Assert.True(enums2.int64b0 == EnumInt64.ENUM_VALUE_0);
            Assert.True(enums2.int64b1 == EnumInt64.ENUM_VALUE_1);
            Assert.True(enums2.int64b2 == EnumInt64.ENUM_VALUE_2);
            Assert.True(enums2.int64b3 == EnumInt64.ENUM_VALUE_3);
            Assert.True(enums2.int64b4 == EnumInt64.ENUM_VALUE_4);
            Assert.True(enums2.int64b5 == enums1.int64b3);

            Assert.True(enums2.uint64b0 == EnumUInt64.ENUM_VALUE_0);
            Assert.True(enums2.uint64b1 == EnumUInt64.ENUM_VALUE_1);
            Assert.True(enums2.uint64b2 == EnumUInt64.ENUM_VALUE_2);
            Assert.True(enums2.uint64b3 == EnumUInt64.ENUM_VALUE_3);
            Assert.True(enums2.uint64b4 == EnumUInt64.ENUM_VALUE_4);
            Assert.True(enums2.uint64b5 == enums1.uint64b3);
        }

        [Fact(DisplayName = "Serialization (Final): enums")]
        public void SerializationFinalEnums()
        {
            var enums1 = Enums.Default;

            // Serialize enums to the FBE stream
            var writer = new EnumsFinalModel();
            long serialized = writer.Serialize(enums1);
            Assert.True(serialized == writer.Buffer.Size);
            Assert.True(writer.Verify());
            writer.Next(serialized);

            // Check the serialized FBE size
            Assert.True(writer.Buffer.Size == 224);

            // Deserialize enums from the FBE stream
            var reader = new EnumsFinalModel();
            reader.Attach(writer.Buffer);
            Assert.True(reader.Verify());
            long deserialized = reader.Deserialize(out var enums2);
            Assert.True(deserialized == reader.Buffer.Size);
            reader.Next(deserialized);

            Assert.True(enums2.byte0 == EnumByte.ENUM_VALUE_0);
            Assert.True(enums2.byte1 == EnumByte.ENUM_VALUE_1);
            Assert.True(enums2.byte2 == EnumByte.ENUM_VALUE_2);
            Assert.True(enums2.byte3 == EnumByte.ENUM_VALUE_3);
            Assert.True(enums2.byte4 == EnumByte.ENUM_VALUE_4);
            Assert.True(enums2.byte5 == enums1.byte3);

            Assert.True(enums2.char0 == EnumChar.ENUM_VALUE_0);
            Assert.True(enums2.char1 == EnumChar.ENUM_VALUE_1);
            Assert.True(enums2.char2 == EnumChar.ENUM_VALUE_2);
            Assert.True(enums2.char3 == EnumChar.ENUM_VALUE_3);
            Assert.True(enums2.char4 == EnumChar.ENUM_VALUE_4);
            Assert.True(enums2.char5 == enums1.char3);

            Assert.True(enums2.wchar0 == EnumWChar.ENUM_VALUE_0);
            Assert.True(enums2.wchar1 == EnumWChar.ENUM_VALUE_1);
            Assert.True(enums2.wchar2 == EnumWChar.ENUM_VALUE_2);
            Assert.True(enums2.wchar3 == EnumWChar.ENUM_VALUE_3);
            Assert.True(enums2.wchar4 == EnumWChar.ENUM_VALUE_4);
            Assert.True(enums2.wchar5 == enums1.wchar3);

            Assert.True(enums2.int8b0 == EnumInt8.ENUM_VALUE_0);
            Assert.True(enums2.int8b1 == EnumInt8.ENUM_VALUE_1);
            Assert.True(enums2.int8b2 == EnumInt8.ENUM_VALUE_2);
            Assert.True(enums2.int8b3 == EnumInt8.ENUM_VALUE_3);
            Assert.True(enums2.int8b4 == EnumInt8.ENUM_VALUE_4);
            Assert.True(enums2.int8b5 == enums1.int8b3);

            Assert.True(enums2.uint8b0 == EnumUInt8.ENUM_VALUE_0);
            Assert.True(enums2.uint8b1 == EnumUInt8.ENUM_VALUE_1);
            Assert.True(enums2.uint8b2 == EnumUInt8.ENUM_VALUE_2);
            Assert.True(enums2.uint8b3 == EnumUInt8.ENUM_VALUE_3);
            Assert.True(enums2.uint8b4 == EnumUInt8.ENUM_VALUE_4);
            Assert.True(enums2.uint8b5 == enums1.uint8b3);

            Assert.True(enums2.int16b0 == EnumInt16.ENUM_VALUE_0);
            Assert.True(enums2.int16b1 == EnumInt16.ENUM_VALUE_1);
            Assert.True(enums2.int16b2 == EnumInt16.ENUM_VALUE_2);
            Assert.True(enums2.int16b3 == EnumInt16.ENUM_VALUE_3);
            Assert.True(enums2.int16b4 == EnumInt16.ENUM_VALUE_4);
            Assert.True(enums2.int16b5 == enums1.int16b3);

            Assert.True(enums2.uint16b0 == EnumUInt16.ENUM_VALUE_0);
            Assert.True(enums2.uint16b1 == EnumUInt16.ENUM_VALUE_1);
            Assert.True(enums2.uint16b2 == EnumUInt16.ENUM_VALUE_2);
            Assert.True(enums2.uint16b3 == EnumUInt16.ENUM_VALUE_3);
            Assert.True(enums2.uint16b4 == EnumUInt16.ENUM_VALUE_4);
            Assert.True(enums2.uint16b5 == enums1.uint16b3);

            Assert.True(enums2.int32b0 == EnumInt32.ENUM_VALUE_0);
            Assert.True(enums2.int32b1 == EnumInt32.ENUM_VALUE_1);
            Assert.True(enums2.int32b2 == EnumInt32.ENUM_VALUE_2);
            Assert.True(enums2.int32b3 == EnumInt32.ENUM_VALUE_3);
            Assert.True(enums2.int32b4 == EnumInt32.ENUM_VALUE_4);
            Assert.True(enums2.int32b5 == enums1.int32b3);

            Assert.True(enums2.uint32b0 == EnumUInt32.ENUM_VALUE_0);
            Assert.True(enums2.uint32b1 == EnumUInt32.ENUM_VALUE_1);
            Assert.True(enums2.uint32b2 == EnumUInt32.ENUM_VALUE_2);
            Assert.True(enums2.uint32b3 == EnumUInt32.ENUM_VALUE_3);
            Assert.True(enums2.uint32b4 == EnumUInt32.ENUM_VALUE_4);
            Assert.True(enums2.uint32b5 == enums1.uint32b3);

            Assert.True(enums2.int64b0 == EnumInt64.ENUM_VALUE_0);
            Assert.True(enums2.int64b1 == EnumInt64.ENUM_VALUE_1);
            Assert.True(enums2.int64b2 == EnumInt64.ENUM_VALUE_2);
            Assert.True(enums2.int64b3 == EnumInt64.ENUM_VALUE_3);
            Assert.True(enums2.int64b4 == EnumInt64.ENUM_VALUE_4);
            Assert.True(enums2.int64b5 == enums1.int64b3);

            Assert.True(enums2.uint64b0 == EnumUInt64.ENUM_VALUE_0);
            Assert.True(enums2.uint64b1 == EnumUInt64.ENUM_VALUE_1);
            Assert.True(enums2.uint64b2 == EnumUInt64.ENUM_VALUE_2);
            Assert.True(enums2.uint64b3 == EnumUInt64.ENUM_VALUE_3);
            Assert.True(enums2.uint64b4 == EnumUInt64.ENUM_VALUE_4);
            Assert.True(enums2.uint64b5 == enums1.uint64b3);
        }

        [Fact(DisplayName = "Serialization (JSON): enums")]
        public void SerializationJsonEnums()
        {
            // Define a source JSON string
            var json = @"{""byte0"":0,""byte1"":0,""byte2"":1,""byte3"":254,""byte4"":255,""byte5"":254,""char0"":0,""char1"":49,""char2"":50,""char3"":51,""char4"":52,""char5"":51,""wchar0"":0,""wchar1"":1092,""wchar2"":1093,""wchar3"":1365,""wchar4"":1366,""wchar5"":1365,""int8b0"":0,""int8b1"":-128,""int8b2"":-127,""int8b3"":126,""int8b4"":127,""int8b5"":126,""uint8b0"":0,""uint8b1"":0,""uint8b2"":1,""uint8b3"":254,""uint8b4"":255,""uint8b5"":254,""int16b0"":0,""int16b1"":-32768,""int16b2"":-32767,""int16b3"":32766,""int16b4"":32767,""int16b5"":32766,""uint16b0"":0,""uint16b1"":0,""uint16b2"":1,""uint16b3"":65534,""uint16b4"":65535,""uint16b5"":65534,""int32b0"":0,""int32b1"":-2147483648,""int32b2"":-2147483647,""int32b3"":2147483646,""int32b4"":2147483647,""int32b5"":2147483646,""uint32b0"":0,""uint32b1"":0,""uint32b2"":1,""uint32b3"":4294967294,""uint32b4"":4294967295,""uint32b5"":4294967294,""int64b0"":0,""int64b1"":-9223372036854775807,""int64b2"":-9223372036854775806,""int64b3"":9223372036854775806,""int64b4"":9223372036854775807,""int64b5"":9223372036854775806,""uint64b0"":0,""uint64b1"":0,""uint64b2"":1,""uint64b3"":18446744073709551614,""uint64b4"":18446744073709551615,""uint64b5"":18446744073709551614}";

            // Create enums from the source JSON string
            var enums1 = Enums.FromJson(json);

            // Serialize enums to the JSON string
            json = enums1.ToJson();

            // Check the serialized JSON and its size
            Assert.True(json.Length > 0);

            // Deserialize enums from the JSON string
            var enums2 = Enums.FromJson(json);

            Assert.True(enums2.byte0 == EnumByte.ENUM_VALUE_0);
            Assert.True(enums2.byte1 == EnumByte.ENUM_VALUE_1);
            Assert.True(enums2.byte2 == EnumByte.ENUM_VALUE_2);
            Assert.True(enums2.byte3 == EnumByte.ENUM_VALUE_3);
            Assert.True(enums2.byte4 == EnumByte.ENUM_VALUE_4);
            Assert.True(enums2.byte5 == enums1.byte3);

            Assert.True(enums2.char0 == EnumChar.ENUM_VALUE_0);
            Assert.True(enums2.char1 == EnumChar.ENUM_VALUE_1);
            Assert.True(enums2.char2 == EnumChar.ENUM_VALUE_2);
            Assert.True(enums2.char3 == EnumChar.ENUM_VALUE_3);
            Assert.True(enums2.char4 == EnumChar.ENUM_VALUE_4);
            Assert.True(enums2.char5 == enums1.char3);

            Assert.True(enums2.wchar0 == EnumWChar.ENUM_VALUE_0);
            Assert.True(enums2.wchar1 == EnumWChar.ENUM_VALUE_1);
            Assert.True(enums2.wchar2 == EnumWChar.ENUM_VALUE_2);
            Assert.True(enums2.wchar3 == EnumWChar.ENUM_VALUE_3);
            Assert.True(enums2.wchar4 == EnumWChar.ENUM_VALUE_4);
            Assert.True(enums2.wchar5 == enums1.wchar3);

            Assert.True(enums2.int8b0 == EnumInt8.ENUM_VALUE_0);
            Assert.True(enums2.int8b1 == EnumInt8.ENUM_VALUE_1);
            Assert.True(enums2.int8b2 == EnumInt8.ENUM_VALUE_2);
            Assert.True(enums2.int8b3 == EnumInt8.ENUM_VALUE_3);
            Assert.True(enums2.int8b4 == EnumInt8.ENUM_VALUE_4);
            Assert.True(enums2.int8b5 == enums1.int8b3);

            Assert.True(enums2.uint8b0 == EnumUInt8.ENUM_VALUE_0);
            Assert.True(enums2.uint8b1 == EnumUInt8.ENUM_VALUE_1);
            Assert.True(enums2.uint8b2 == EnumUInt8.ENUM_VALUE_2);
            Assert.True(enums2.uint8b3 == EnumUInt8.ENUM_VALUE_3);
            Assert.True(enums2.uint8b4 == EnumUInt8.ENUM_VALUE_4);
            Assert.True(enums2.uint8b5 == enums1.uint8b3);

            Assert.True(enums2.int16b0 == EnumInt16.ENUM_VALUE_0);
            Assert.True(enums2.int16b1 == EnumInt16.ENUM_VALUE_1);
            Assert.True(enums2.int16b2 == EnumInt16.ENUM_VALUE_2);
            Assert.True(enums2.int16b3 == EnumInt16.ENUM_VALUE_3);
            Assert.True(enums2.int16b4 == EnumInt16.ENUM_VALUE_4);
            Assert.True(enums2.int16b5 == enums1.int16b3);

            Assert.True(enums2.uint16b0 == EnumUInt16.ENUM_VALUE_0);
            Assert.True(enums2.uint16b1 == EnumUInt16.ENUM_VALUE_1);
            Assert.True(enums2.uint16b2 == EnumUInt16.ENUM_VALUE_2);
            Assert.True(enums2.uint16b3 == EnumUInt16.ENUM_VALUE_3);
            Assert.True(enums2.uint16b4 == EnumUInt16.ENUM_VALUE_4);
            Assert.True(enums2.uint16b5 == enums1.uint16b3);

            Assert.True(enums2.int32b0 == EnumInt32.ENUM_VALUE_0);
            Assert.True(enums2.int32b1 == EnumInt32.ENUM_VALUE_1);
            Assert.True(enums2.int32b2 == EnumInt32.ENUM_VALUE_2);
            Assert.True(enums2.int32b3 == EnumInt32.ENUM_VALUE_3);
            Assert.True(enums2.int32b4 == EnumInt32.ENUM_VALUE_4);
            Assert.True(enums2.int32b5 == enums1.int32b3);

            Assert.True(enums2.uint32b0 == EnumUInt32.ENUM_VALUE_0);
            Assert.True(enums2.uint32b1 == EnumUInt32.ENUM_VALUE_1);
            Assert.True(enums2.uint32b2 == EnumUInt32.ENUM_VALUE_2);
            Assert.True(enums2.uint32b3 == EnumUInt32.ENUM_VALUE_3);
            Assert.True(enums2.uint32b4 == EnumUInt32.ENUM_VALUE_4);
            Assert.True(enums2.uint32b5 == enums1.uint32b3);

            Assert.True(enums2.int64b0 == EnumInt64.ENUM_VALUE_0);
            Assert.True(enums2.int64b1 == EnumInt64.ENUM_VALUE_1);
            Assert.True(enums2.int64b2 == EnumInt64.ENUM_VALUE_2);
            Assert.True(enums2.int64b3 == EnumInt64.ENUM_VALUE_3);
            Assert.True(enums2.int64b4 == EnumInt64.ENUM_VALUE_4);
            Assert.True(enums2.int64b5 == enums1.int64b3);

            Assert.True(enums2.uint64b0 == EnumUInt64.ENUM_VALUE_0);
            Assert.True(enums2.uint64b1 == EnumUInt64.ENUM_VALUE_1);
            Assert.True(enums2.uint64b2 == EnumUInt64.ENUM_VALUE_2);
            Assert.True(enums2.uint64b3 == EnumUInt64.ENUM_VALUE_3);
            Assert.True(enums2.uint64b4 == EnumUInt64.ENUM_VALUE_4);
            Assert.True(enums2.uint64b5 == enums1.uint64b3);
        }
    }
}
