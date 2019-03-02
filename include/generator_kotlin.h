/*!
    \file generator_kotlin.h
    \brief Fast binary encoding Kotlin generator definition
    \author Ivan Shynkarenka
    \date 03.10.2018
    \copyright MIT License
*/

#ifndef GENERATOR_KOTLIN_H
#define GENERATOR_KOTLIN_H

#include "generator.h"

namespace FBE {

class GeneratorKotlin : public Generator
{
public:
    GeneratorKotlin(const std::string& input, const std::string& output, int indent, char space);

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorKotlin& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorKotlin& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Sender() const noexcept { return _sender; }
    GeneratorKotlin& Sender(bool sender) noexcept { _sender = sender; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final;
    bool _json;
    bool _sender;

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateImports(const std::string& package);
    void GenerateImports(const std::shared_ptr<Package>& p);

    void GenerateFBEPackage(const std::string& package);
    void GenerateFBEUUIDGenerator(const std::string& package);
    void GenerateFBEBuffer(const std::string& package);
    void GenerateFBEModel(const std::string& package);
    void GenerateFBESize(const std::string& package);
    void GenerateFBEFieldModel(const std::string& package);
    void GenerateFBEFieldModel(const std::string& package, const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelDecimal(const std::string& package);
    void GenerateFBEFieldModelTimestamp(const std::string& package);
    void GenerateFBEFieldModelBytes(const std::string& package);
    void GenerateFBEFieldModelString(const std::string& package);
    void GenerateFBEFieldModelOptional(const std::string& package, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFieldModelArray(const std::string& package, const std::string& name, const std::string& type, const std::string& base, bool optional, const std::string& model);
    void GenerateFBEFieldModelVector(const std::string& package, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFieldModelMap(const std::string& package, const std::string& key_name, const std::string& key_type, const std::string& key_model, const std::string& value_name, const std::string& value_type, const std::string& value_model);
    void GenerateFBEFieldModelEnumFlags(const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBEFinalModel(const std::string& package);
    void GenerateFBEFinalModel(const std::string& package, const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFinalModelDecimal(const std::string& package);
    void GenerateFBEFinalModelTimestamp(const std::string& package);
    void GenerateFBEFinalModelBytes(const std::string& package);
    void GenerateFBEFinalModelString(const std::string& package);
    void GenerateFBEFinalModelOptional(const std::string& package, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFinalModelArray(const std::string& package, const std::string& name, const std::string& type, const std::string& base, bool optional, const std::string& model);
    void GenerateFBEFinalModelVector(const std::string& package, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFinalModelMap(const std::string& package, const std::string& key_name, const std::string& key_type, const std::string& key_model, const std::string& value_name, const std::string& value_type, const std::string& value_model);
    void GenerateFBEFinalModelEnumFlags(const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBESender(const std::string& package);
    void GenerateFBEReceiver(const std::string& package);
    void GenerateFBEJson(const std::string& package);

    void GenerateContainers(const std::shared_ptr<Package>& p, bool final);
    void GeneratePackage(const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e, const CppCommon::Path& path);
    void GenerateEnumClass(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e, const CppCommon::Path& path);
    void GenerateEnumJson(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateFlags(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& e, const CppCommon::Path& path);
    void GenerateFlagsClass(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& e, const CppCommon::Path& path);
    void GenerateFlagsJson(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& e);
    void GenerateStruct(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateSender(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy(const std::shared_ptr<Package>& p, bool final);
    void GenerateJson(const std::shared_ptr<Package>& p);

    bool IsKnownType(const std::string& type);
    bool IsPrimitiveType(const std::string& type, bool optional);
    bool IsUnsignedType(const std::string& type);

    std::string ConvertEnumBase(const std::string& type);
    std::string ConvertEnumType(const std::string& type);
    std::string ConvertEnumSize(const std::string& type);
    std::string ConvertEnumGet(const std::string& type);
    std::string ConvertEnumRead(const std::string& type);
    std::string ConvertEnumFrom(const std::string& type);
    std::string ConvertEnumTo(const std::string& type);
    std::string ConvertEnumFlags(const std::string& type);
    std::string ConvertEnumConstant(const std::string& base, const std::string& type, const std::string& value, bool flag);
    std::string ConvertEnumConstantPrefix(const std::string& type);
    std::string ConvertEnumConstantSuffix(const std::string& type);
    std::string ConvertPrimitiveTypeName(const std::string& type);
    std::string ConvertTypeName(const std::string& type, bool optional);
    std::string ConvertTypeName(const StructField& field, bool typeless);
    std::string ConvertBaseFieldName(const std::string& type, bool final);
    std::string ConvertTypeFieldName(const std::string& type);
    std::string ConvertTypeFieldType(const std::string& type, bool optional);
    std::string ConvertTypeFieldDeclaration(const std::string& type, bool optional, bool final);
    std::string ConvertTypeFieldDeclaration(const StructField& field, bool final);
    std::string ConvertTypeFieldInitialization(const StructField& field, const std::string& offset, bool final);
    std::string ConvertConstant(const std::string& type, const std::string& value, bool optional);
    std::string ConvertConstantPrefix(const std::string& type);
    std::string ConvertConstantSuffix(const std::string& type);
    std::string ConvertDefault(const std::string& type);
    std::string ConvertDefault(const StructField& field);

    std::string ConvertOutputStreamType(const std::string& type, const std::string& name, bool optional);
    std::string ConvertOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate, bool nullable);
};

} // namespace FBE

#include "generator_kotlin.inl"

#endif // GENERATOR_KOTLIN_H
