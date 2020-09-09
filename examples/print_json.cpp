/*!
    \file print_json.cpp
    \brief Fast Binary Encoding print JSON example
    \author Ivan Shynkarenka
    \date 16.08.2018
    \copyright MIT License
*/

#include "../proto/test_json.h"

#include <iostream>

int main(int argc, char** argv)
{
    rapidjson::StringBuffer buffer;
    rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);

    buffer.Clear();
    writer.Reset(buffer);
    FBE::JSON::to_json(writer, test::StructSimple());
    std::cout << buffer.GetString() << std::endl << std::endl;

    buffer.Clear();
    writer.Reset(buffer);
    FBE::JSON::to_json(writer, test::StructOptional());
    std::cout << buffer.GetString() << std::endl << std::endl;

    buffer.Clear();
    writer.Reset(buffer);
    FBE::JSON::to_json(writer, test::StructNested());
    std::cout << buffer.GetString() << std::endl << std::endl;

    return 0;
}
