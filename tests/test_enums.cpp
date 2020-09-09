//
// Created by Ivan Shynkarenka on 29.06.2018
//

#include "test.h"

#include "../proto/enums_json.h"
#include "../proto/enums_models.h"
#include "../proto/enums_final_models.h"

TEST_CASE("Serialization: enums", "[FBE]")
{
    enums::Enums enums1;

    // Serialize enums to the FBE stream
    FBE::enums::EnumsModel writer;
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
    FBE::enums::EnumsModel reader;
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
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775806ll);
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
    FBE::enums::EnumsFinalModel writer;
    size_t serialized = writer.serialize(enums1);
    REQUIRE(serialized == writer.buffer().size());
    REQUIRE(writer.verify());
    writer.next(serialized);

    // Check the serialized FBE size
    REQUIRE(writer.buffer().size() == 224);

    // Deserialize enums from the FBE stream
    enums::Enums enums2;
    FBE::enums::EnumsFinalModel reader;
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
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775806ll);
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
    // Define a source JSON string
    rapidjson::Document json;
    json.Parse(R"JSON({"byte0":0,"byte1":0,"byte2":1,"byte3":254,"byte4":255,"byte5":254,"char0":0,"char1":49,"char2":50,"char3":51,"char4":52,"char5":51,"wchar0":0,"wchar1":1092,"wchar2":1093,"wchar3":1365,"wchar4":1366,"wchar5":1365,"int8b0":0,"int8b1":-128,"int8b2":-127,"int8b3":126,"int8b4":127,"int8b5":126,"uint8b0":0,"uint8b1":0,"uint8b2":1,"uint8b3":254,"uint8b4":255,"uint8b5":254,"int16b0":0,"int16b1":-32768,"int16b2":-32767,"int16b3":32766,"int16b4":32767,"int16b5":32766,"uint16b0":0,"uint16b1":0,"uint16b2":1,"uint16b3":65534,"uint16b4":65535,"uint16b5":65534,"int32b0":0,"int32b1":-2147483648,"int32b2":-2147483647,"int32b3":2147483646,"int32b4":2147483647,"int32b5":2147483646,"uint32b0":0,"uint32b1":0,"uint32b2":1,"uint32b3":4294967294,"uint32b4":4294967295,"uint32b5":4294967294,"int64b0":0,"int64b1":-9223372036854775807,"int64b2":-9223372036854775806,"int64b3":9223372036854775806,"int64b4":9223372036854775807,"int64b5":9223372036854775806,"uint64b0":0,"uint64b1":0,"uint64b2":1,"uint64b3":18446744073709551614,"uint64b4":18446744073709551615,"uint64b5":18446744073709551614})JSON");

    // Create enums from the source JSON string
    enums::Enums enums1;
    REQUIRE(FBE::JSON::from_json(json, enums1));

    // Serialize enums to the JSON stream
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
    REQUIRE(FBE::JSON::to_json(writer, enums1));

    // Check the serialized JSON size
    REQUIRE(buffer.GetSize() > 0);

    // Parse the JSON document
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
    REQUIRE(enums2.int64b1 == (enums::EnumInt64)-9223372036854775807ll);
    REQUIRE(enums2.int64b2 == (enums::EnumInt64)-9223372036854775806ll);
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
