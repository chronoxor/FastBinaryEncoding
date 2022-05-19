/*!
    \file generator_csharp.h
    \brief Fast binary encoding C# generator definition
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

#ifndef GENERATOR_CSHARP_H
#define GENERATOR_CSHARP_H

#include "generator.h"

namespace FBE {

class GeneratorCSharp : public Generator
{
public:
    using Generator::Generator;

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorCSharp& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorCSharp& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Proto() const noexcept { return _proto; }
    GeneratorCSharp& Proto(bool proto) noexcept { _proto = proto; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final{false};
    bool _json{false};
    bool _proto{false};

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateImports();
    void GenerateImports(const std::string& domain, const std::shared_ptr<Package>& p);
    void GenerateFBEUuidGenerator();
    void GenerateFBEBuffer();
    void GenerateFBEBaseModel();
    void GenerateFBEFieldModelBase();
    void GenerateFBEFieldModel(const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelTimestamp();
    void GenerateFBEFieldModelBytes();
    void GenerateFBEFieldModelString();
    void GenerateFBEFieldModelOptional(bool valueType);
    void GenerateFBEFieldModelArray(bool valueType, bool optional);
    void GenerateFBEFieldModelVector(bool valueType, bool optional);
    void GenerateFBEFieldModelMap(bool valueTypeKey, bool valueTypeValue, bool optional);
    void GenerateFBEFinalModelBase();
    void GenerateFBEFinalModel(const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFinalModelTimestamp();
    void GenerateFBEFinalModelBytes();
    void GenerateFBEFinalModelString();
    void GenerateFBEFinalModelOptional(bool valueType);
    void GenerateFBEFinalModelArray(bool valueType, bool optional);
    void GenerateFBEFinalModelVector(bool valueType, bool optional);
    void GenerateFBEFinalModelMap(bool valueTypeKey, bool valueTypeValue, bool optional);
    void GenerateFBESender();
    void GenerateFBEReceiver();
    void GenerateFBEClient();
    void GenerateFBEJson();
    void GenerateFBE(const std::string& domain, const CppCommon::Path& path);

    void GeneratePackage(const std::string& domain, const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateEnumFieldModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateEnumFinalModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateFlags(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFieldModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFinalModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateStruct(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFieldModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal(const std::string& domain, const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateProtocolVersion(const std::string& domain, const std::shared_ptr<Package>& p);
    void GenerateSender(const std::string& domain, const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::string& domain, const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy(const std::string& domain, const std::shared_ptr<Package>& p, bool final);
    void GenerateClient(const std::string& domain, const std::shared_ptr<Package>& p, bool final);

    bool IsKnownType(const std::string& type);
    bool IsReferenceType(const std::string& type);

    std::string ConvertEnumRead(const std::string& type);
    std::string ConvertEnumSize(const std::string& type);
    std::string ConvertEnumType(const std::string& type);
    std::string ConvertEnumTypeUtf8Json(const std::string& type);
    std::string ConvertEnumConstant(const std::string& type, const std::string& value);
    std::string ConvertEnumConstantPrefix(const std::string& type);
    std::string ConvertEnumConstantSuffix(const std::string& type);
    std::string ConvertBaseTypeName(const std::string& type);
    std::string ConvertTypeName(const std::string& type, bool optional);
    std::string ConvertTypeName(const std::string& domain, const std::string& package, const std::string& type, bool optional);
    std::string ConvertTypeName(const StructField& field);
    std::string ConvertTypeFieldName(const std::string& domain, const std::string& package, const std::string& type, bool final);
    std::string ConvertTypeFieldDeclaration(const std::string& domain, const std::string& package, const StructField& field, bool final);
    std::string ConvertTypeFieldInitialization(const std::string& domain, const std::string& package, const StructField& field, const std::string& offset, bool final);
    std::string ConvertConstant(const std::string& domain, const std::string& package, const std::string& type, const std::string& value, bool optional);
    std::string ConvertConstantPrefix(const std::string& type);
    std::string ConvertConstantSuffix(const std::string& type);
    std::string ConvertDefault(const std::string& domain, const std::string& package, const std::string& type);
    std::string ConvertDefault(const std::string& domain, const std::string& package, const StructField& field);

    std::string ConvertOutputStreamType(const std::string& type, const std::string& name, bool optional);
    std::string ConvertOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate);
};

} // namespace FBE

#endif // GENERATOR_CSHARP_H
