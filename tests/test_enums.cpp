//
// Created by Ivan Shynkarenka on 29.06.2018
//

#include "test.h"

#include "../proto/enums.h"

TEST_CASE("Serialization: enums", "[FBE]")
{
    enums::Enums enums1;

    // Serialize enums to the FBE stream
    FBE::enums::EnumsModel<FBE::WriteBuffer> writer;
    REQUIRE(writer.model.fbe_offset() == 4);
    size_t serialized = writer.serialize(enums1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);
    REQUIRE(writer.model.fbe_offset() == (4 + writer.buffer().size()));

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 232);

    // Deserialize enums from the FBE stream
    enums::Enums enums2;
    FBE::enums::EnumsModel<FBE::ReadBuffer> reader;
    REQUIRE(reader.model.fbe_offset() == 4);
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(enums2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);
    REQUIRE(reader.model.fbe_offset() == (4 + reader.buffer().size()));

    REQUIRE(enums2.byte0 == (enums::EnumByte)0);
    REQUIRE(enums2.byte1 == (enums::EnumByte)0);
    REQUIRE(enums2.byte2 == (enums::EnumByte)1);
    REQUIRE(enums2.byte3 == (enums::EnumByte)254);
    REQUIRE(enums2.byte4 == (enums::EnumByte)255);
    REQUIRE(enums2.byte5 == enums1.byte3);

    REQUIRE(enums2.char0 == (enums::EnumChar)0);
    REQUIRE(enums2.char1 == (enums::EnumChar)'1');
    REQUIRE(enums2.char2 == (enums::EnumChar)'2');
    REQUIRE(enums2.char3 == (enums::EnumChar)'3');
    REQUIRE(enums2.char4 == (enums::EnumChar)'4');
    REQUIRE(enums2.char5 == enums1.char3);

    REQUIRE(enums2.wchar0 == (enums::EnumWChar)0);
    REQUIRE(enums2.wchar1 == (enums::EnumWChar)0x0444);
    REQUIRE(enums2.wchar2 == (enums::EnumWChar)0x0445);
    REQUIRE(enums2.wchar3 == (enums::EnumWChar)0x0555);
    REQUIRE(enums2.wchar4 == (enums::EnumWChar)0x0556);
    REQUIRE(enums2.wchar5 == enums1.wchar3);

    REQUIRE(enums2.int8b0 == (enums::EnumInt8)0);
    REQUIRE(enums2.int8b1 == (enums::EnumInt8)-128);
    REQUIRE(enums2.int8b2 == (enums::EnumInt8)-127);
    REQUIRE(enums2.int8b3 == (enums::EnumInt8)126);
    REQUIRE(enums2.int8b4 == (enums::EnumInt8)127);
    REQUIRE(enums2.int8b5 == enums1.int8b3);

    REQUIRE(enums2.uint8b0 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b1 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b2 == (enums::EnumUInt8)1);
    REQUIRE(enums2.uint8b3 == (enums::EnumUInt8)254);
    REQUIRE(enums2.uint8b4 == (enums::EnumUInt8)255);
    REQUIRE(enums2.uint8b5 == enums1.uint8b3);

    REQUIRE(enums2.int16b0 == (enums::EnumInt16)0);
    REQUIRE(enums2.int16b1 == (enums::EnumInt16)-32768);
    REQUIRE(enums2.int16b2 == (enums::EnumInt16)-32767);
    REQUIRE(enums2.int16b3 == (enums::EnumInt16)32766);
    REQUIRE(enums2.int16b4 == (enums::EnumInt16)32767);
    REQUIRE(enums2.int16b5 == enums1.int16b3);

    REQUIRE(enums2.uint16b0 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b1 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b2 == (enums::EnumUInt16)1);
    REQUIRE(enums2.uint16b3 == (enums::EnumUInt16)65534);
    REQUIRE(enums2.uint16b4 == (enums::EnumUInt16)65535);
    REQUIRE(enums2.uint16b5 == enums1.uint16b3);

    REQUIRE(enums2.int32b0 == (enums::EnumInt32)0);
    REQUIRE(enums2.int32b1 == (enums::EnumInt32)-2147483648ll);
    REQUIRE(enums2.int32b2 == (enums::EnumInt32)-2147483647ll);
    REQUIRE(enums2.int32b3 == (enums::EnumInt32)2147483646ll);
    REQUIRE(enums2.int32b4 == (enums::EnumInt32)2147483647ll);
    REQUIRE(enums2.int32b5 == enums1.int32b3);

    REQUIRE(enums2.uint32b0 == (enums::EnumUInt32)0);
    REQUIRE(enums2.uint32b1 == (enums::EnumUInt32)0ull);
    REQUIRE(enums2.uint32b2 == (enums::EnumUInt32)1ull);
    REQUIRE(enums2.uint32b3 == (enums::EnumUInt32)0xFFFFFFFEull);
    REQUIRE(enums2.uint32b4 == (enums::EnumUInt32)0xFFFFFFFFull);
    REQUIRE(enums2.uint32b5 == enums1.uint32b3);

    REQUIRE(enums2.int64b0 == (enums::EnumInt64)0);
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775808ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b3 == (enums::EnumInt64)9223372036854775806ll);
    REQUIRE(enums2.int64b4 == (enums::EnumInt64)9223372036854775807ll);
    REQUIRE(enums2.int64b5 == enums1.int64b3);

    REQUIRE(enums2.uint64b0 == (enums::EnumUInt64)0);
    REQUIRE(enums2.uint64b1 == (enums::EnumUInt64)0ull);
    REQUIRE(enums2.uint64b2 == (enums::EnumUInt64)1ull);
    REQUIRE(enums2.uint64b3 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFEull);
    REQUIRE(enums2.uint64b4 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFFull);
    REQUIRE(enums2.uint64b5 == enums1.uint64b3);
}

TEST_CASE("Serialization (Final): enums", "[FBE]")
{
    enums::Enums enums1;

    // Serialize enums to the FBE stream
    FBE::enums::EnumsFinalModel<FBE::WriteBuffer> writer;
    size_t serialized = writer.serialize(enums1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 224);

    // Deserialize enums from the FBE stream
    enums::Enums enums2;
    FBE::enums::EnumsFinalModel<FBE::ReadBuffer> reader;
    reader.attach(writer.buffer());
    REQUIRE(reader.verify());
    size_t deserialized = reader.deserialize(enums2);
    REQUIRE(deserialized == reader.buffer().size());
    reader.next(deserialized);

    REQUIRE(enums2.byte0 == (enums::EnumByte)0);
    REQUIRE(enums2.byte1 == (enums::EnumByte)0);
    REQUIRE(enums2.byte2 == (enums::EnumByte)1);
    REQUIRE(enums2.byte3 == (enums::EnumByte)254);
    REQUIRE(enums2.byte4 == (enums::EnumByte)255);
    REQUIRE(enums2.byte5 == enums1.byte3);

    REQUIRE(enums2.char0 == (enums::EnumChar)0);
    REQUIRE(enums2.char1 == (enums::EnumChar)'1');
    REQUIRE(enums2.char2 == (enums::EnumChar)'2');
    REQUIRE(enums2.char3 == (enums::EnumChar)'3');
    REQUIRE(enums2.char4 == (enums::EnumChar)'4');
    REQUIRE(enums2.char5 == enums1.char3);

    REQUIRE(enums2.wchar0 == (enums::EnumWChar)0);
    REQUIRE(enums2.wchar1 == (enums::EnumWChar)0x0444);
    REQUIRE(enums2.wchar2 == (enums::EnumWChar)0x0445);
    REQUIRE(enums2.wchar3 == (enums::EnumWChar)0x0555);
    REQUIRE(enums2.wchar4 == (enums::EnumWChar)0x0556);
    REQUIRE(enums2.wchar5 == enums1.wchar3);

    REQUIRE(enums2.int8b0 == (enums::EnumInt8)0);
    REQUIRE(enums2.int8b1 == (enums::EnumInt8)-128);
    REQUIRE(enums2.int8b2 == (enums::EnumInt8)-127);
    REQUIRE(enums2.int8b3 == (enums::EnumInt8)126);
    REQUIRE(enums2.int8b4 == (enums::EnumInt8)127);
    REQUIRE(enums2.int8b5 == enums1.int8b3);

    REQUIRE(enums2.uint8b0 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b1 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b2 == (enums::EnumUInt8)1);
    REQUIRE(enums2.uint8b3 == (enums::EnumUInt8)254);
    REQUIRE(enums2.uint8b4 == (enums::EnumUInt8)255);
    REQUIRE(enums2.uint8b5 == enums1.uint8b3);

    REQUIRE(enums2.int16b0 == (enums::EnumInt16)0);
    REQUIRE(enums2.int16b1 == (enums::EnumInt16)-32768);
    REQUIRE(enums2.int16b2 == (enums::EnumInt16)-32767);
    REQUIRE(enums2.int16b3 == (enums::EnumInt16)32766);
    REQUIRE(enums2.int16b4 == (enums::EnumInt16)32767);
    REQUIRE(enums2.int16b5 == enums1.int16b3);

    REQUIRE(enums2.uint16b0 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b1 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b2 == (enums::EnumUInt16)1);
    REQUIRE(enums2.uint16b3 == (enums::EnumUInt16)65534);
    REQUIRE(enums2.uint16b4 == (enums::EnumUInt16)65535);
    REQUIRE(enums2.uint16b5 == enums1.uint16b3);

    REQUIRE(enums2.int32b0 == (enums::EnumInt32)0);
    REQUIRE(enums2.int32b1 == (enums::EnumInt32)-2147483648ll);
    REQUIRE(enums2.int32b2 == (enums::EnumInt32)-2147483647ll);
    REQUIRE(enums2.int32b3 == (enums::EnumInt32)2147483646ll);
    REQUIRE(enums2.int32b4 == (enums::EnumInt32)2147483647ll);
    REQUIRE(enums2.int32b5 == enums1.int32b3);

    REQUIRE(enums2.uint32b0 == (enums::EnumUInt32)0);
    REQUIRE(enums2.uint32b1 == (enums::EnumUInt32)0ull);
    REQUIRE(enums2.uint32b2 == (enums::EnumUInt32)1ull);
    REQUIRE(enums2.uint32b3 == (enums::EnumUInt32)0xFFFFFFFEull);
    REQUIRE(enums2.uint32b4 == (enums::EnumUInt32)0xFFFFFFFFull);
    REQUIRE(enums2.uint32b5 == enums1.uint32b3);

    REQUIRE(enums2.int64b0 == (enums::EnumInt64)0);
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775808ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b3 == (enums::EnumInt64)9223372036854775806ll);
    REQUIRE(enums2.int64b4 == (enums::EnumInt64)9223372036854775807ll);
    REQUIRE(enums2.int64b5 == enums1.int64b3);

    REQUIRE(enums2.uint64b0 == (enums::EnumUInt64)0);
    REQUIRE(enums2.uint64b1 == (enums::EnumUInt64)0ull);
    REQUIRE(enums2.uint64b2 == (enums::EnumUInt64)1ull);
    REQUIRE(enums2.uint64b3 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFEull);
    REQUIRE(enums2.uint64b4 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFFull);
    REQUIRE(enums2.uint64b5 == enums1.uint64b3);
}

TEST_CASE("Serialization (JSON): enums", "[FBE]")
{
    enums::Enums enums1;

    // Serialize enums to the JSON stream
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
    REQUIRE(FBE::JSON::to_json(writer, enums1));

    // Check the serialized JSON size
    REQUIRE(buffer.GetSize() > 0);

    // Parse the JSON document
    rapidjson::Document json;
    json.Parse(buffer.GetString());

    // Deserialize enums from the JSON stream
    enums::Enums enums2;
    REQUIRE(FBE::JSON::from_json(json, enums2));

    REQUIRE(enums2.byte0 == (enums::EnumByte)0);
    REQUIRE(enums2.byte1 == (enums::EnumByte)0);
    REQUIRE(enums2.byte2 == (enums::EnumByte)1);
    REQUIRE(enums2.byte3 == (enums::EnumByte)254);
    REQUIRE(enums2.byte4 == (enums::EnumByte)255);
    REQUIRE(enums2.byte5 == enums1.byte3);

    REQUIRE(enums2.char0 == (enums::EnumChar)0);
    REQUIRE(enums2.char1 == (enums::EnumChar)'1');
    REQUIRE(enums2.char2 == (enums::EnumChar)'2');
    REQUIRE(enums2.char3 == (enums::EnumChar)'3');
    REQUIRE(enums2.char4 == (enums::EnumChar)'4');
    REQUIRE(enums2.char5 == enums1.char3);

    REQUIRE(enums2.wchar0 == (enums::EnumWChar)0);
    REQUIRE(enums2.wchar1 == (enums::EnumWChar)0x0444);
    REQUIRE(enums2.wchar2 == (enums::EnumWChar)0x0445);
    REQUIRE(enums2.wchar3 == (enums::EnumWChar)0x0555);
    REQUIRE(enums2.wchar4 == (enums::EnumWChar)0x0556);
    REQUIRE(enums2.wchar5 == enums1.wchar3);

    REQUIRE(enums2.int8b0 == (enums::EnumInt8)0);
    REQUIRE(enums2.int8b1 == (enums::EnumInt8)-128);
    REQUIRE(enums2.int8b2 == (enums::EnumInt8)-127);
    REQUIRE(enums2.int8b3 == (enums::EnumInt8)126);
    REQUIRE(enums2.int8b4 == (enums::EnumInt8)127);
    REQUIRE(enums2.int8b5 == enums1.int8b3);

    REQUIRE(enums2.uint8b0 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b1 == (enums::EnumUInt8)0);
    REQUIRE(enums2.uint8b2 == (enums::EnumUInt8)1);
    REQUIRE(enums2.uint8b3 == (enums::EnumUInt8)254);
    REQUIRE(enums2.uint8b4 == (enums::EnumUInt8)255);
    REQUIRE(enums2.uint8b5 == enums1.uint8b3);

    REQUIRE(enums2.int16b0 == (enums::EnumInt16)0);
    REQUIRE(enums2.int16b1 == (enums::EnumInt16)-32768);
    REQUIRE(enums2.int16b2 == (enums::EnumInt16)-32767);
    REQUIRE(enums2.int16b3 == (enums::EnumInt16)32766);
    REQUIRE(enums2.int16b4 == (enums::EnumInt16)32767);
    REQUIRE(enums2.int16b5 == enums1.int16b3);

    REQUIRE(enums2.uint16b0 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b1 == (enums::EnumUInt16)0);
    REQUIRE(enums2.uint16b2 == (enums::EnumUInt16)1);
    REQUIRE(enums2.uint16b3 == (enums::EnumUInt16)65534);
    REQUIRE(enums2.uint16b4 == (enums::EnumUInt16)65535);
    REQUIRE(enums2.uint16b5 == enums1.uint16b3);

    REQUIRE(enums2.int32b0 == (enums::EnumInt32)0);
    REQUIRE(enums2.int32b1 == (enums::EnumInt32)-2147483648ll);
    REQUIRE(enums2.int32b2 == (enums::EnumInt32)-2147483647ll);
    REQUIRE(enums2.int32b3 == (enums::EnumInt32)2147483646ll);
    REQUIRE(enums2.int32b4 == (enums::EnumInt32)2147483647ll);
    REQUIRE(enums2.int32b5 == enums1.int32b3);

    REQUIRE(enums2.uint32b0 == (enums::EnumUInt32)0);
    REQUIRE(enums2.uint32b1 == (enums::EnumUInt32)0ull);
    REQUIRE(enums2.uint32b2 == (enums::EnumUInt32)1ull);
    REQUIRE(enums2.uint32b3 == (enums::EnumUInt32)0xFFFFFFFEull);
    REQUIRE(enums2.uint32b4 == (enums::EnumUInt32)0xFFFFFFFFull);
    REQUIRE(enums2.uint32b5 == enums1.uint32b3);

    REQUIRE(enums2.int64b0 == (enums::EnumInt64)0);
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775808ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b3 == (enums::EnumInt64)9223372036854775806ll);
    REQUIRE(enums2.int64b4 == (enums::EnumInt64)9223372036854775807ll);
    REQUIRE(enums2.int64b5 == enums1.int64b3);

    REQUIRE(enums2.uint64b0 == (enums::EnumUInt64)0);
    REQUIRE(enums2.uint64b1 == (enums::EnumUInt64)0ull);
    REQUIRE(enums2.uint64b2 == (enums::EnumUInt64)1ull);
    REQUIRE(enums2.uint64b3 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFEull);
    REQUIRE(enums2.uint64b4 == (enums::EnumUInt64)0xFFFFFFFFFFFFFFFFull);
    REQUIRE(enums2.uint64b5 == enums1.uint64b3);
}
