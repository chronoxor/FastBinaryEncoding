/*!
    \file fbe.h
    \brief Fast binary encoding definitions
    \author Ivan Shynkarenka
    \date 11.04.2018
    \copyright MIT License
*/

#ifndef FBE_H
#define FBE_H

#include "version.h"

#include "filesystem/directory.h"
#include "filesystem/file.h"
#include "memory/memory_leaks.h"
#include "string/string_utils.h"
#include "system/environment.h"
#include "system/stream.h"
#include "threads/file_lock.h"

#include <algorithm>
#include <cstdint>
#include <memory>
#include <regex>
#include <string>
#include <vector>

int yyerror(const char* msg);
int yyerror(const std::string& msg);

namespace FBE {

struct EnumConst
{
    std::shared_ptr<std::string> constant;
    std::shared_ptr<std::string> reference;
};

struct EnumValue
{
    std::shared_ptr<std::string> name;
    std::shared_ptr<EnumConst> value;
};

struct EnumBody
{
    std::vector<std::shared_ptr<EnumValue>> values;

    void AddValue(EnumValue* v);
};

struct EnumType
{
    std::shared_ptr<std::string> name;
    std::shared_ptr<std::string> base;
    std::shared_ptr<EnumBody> body;
};

struct FlagsConst
{
    std::shared_ptr<std::string> constant;
    std::shared_ptr<std::string> reference;
};

struct FlagsValue
{
    std::shared_ptr<std::string> name;
    std::shared_ptr<FlagsConst> value;
};

struct FlagsBody
{
    std::vector<std::shared_ptr<FlagsValue>> values;

    void AddValue(FlagsValue* v);
};

struct FlagsType
{
    std::shared_ptr<std::string> name;
    std::shared_ptr<std::string> base;
    std::shared_ptr<FlagsBody> body;
};

struct StructField
{
    std::shared_ptr<std::string> name;
    std::shared_ptr<std::string> key;
    std::shared_ptr<std::string> type;
    std::shared_ptr<std::string> value;
    bool id{false};
    bool keys{false};
    bool optional{false};
    bool array{false};
    bool vector{false};
    bool list{false};
    bool set{false};
    bool map{false};
    bool hash{false};
    int N{0};

    void SetArraySize(int size);
};

struct StructBody
{
    std::vector<std::shared_ptr<StructField>> fields;

    void AddField(StructField* field);
};

struct StructRequest
{
};

struct StructResponse
{
    std::shared_ptr<std::string> response;
};

struct StructRejects
{
    std::vector<std::shared_ptr<std::string>> rejects;

    void AddReject(std::string* r);
};

struct StructType
{
    int type;
    bool fixed;
    bool id{false};
    bool keys{false};
    std::shared_ptr<std::string> name;
    std::shared_ptr<std::string> base;
    std::shared_ptr<StructRequest> request;
    std::shared_ptr<StructResponse> response;
    std::shared_ptr<StructRejects> rejects;
    std::shared_ptr<StructBody> body;

    static int stype;

    StructType(int t, bool f);
};

struct Statement
{
    std::shared_ptr<EnumType> e;
    std::shared_ptr<FlagsType> f;
    std::shared_ptr<StructType> s;
};

struct Statements
{
    std::vector<std::shared_ptr<EnumType>> enums;
    std::vector<std::shared_ptr<FlagsType>> flags;
    std::vector<std::shared_ptr<StructType>> structs;

    void AddStatement(Statement* st);

    void AddEnum(std::shared_ptr<EnumType>& e);
    void AddFlags(std::shared_ptr<FlagsType>& f);
    void AddStruct(std::shared_ptr<StructType>& s);
};

struct Import
{
    std::vector<std::shared_ptr<std::string>> imports;

    void AddImport(std::string* i);
};

struct Package
{
    int offset;
    std::shared_ptr<std::string> name;
    std::shared_ptr<Import> import;
    std::shared_ptr<Statements> body;

    static std::shared_ptr<Package> root;

    Package(int o);

    void initialize();
};

} // namespace FBE

#include "fbe.inl"

#endif // FBE_H
