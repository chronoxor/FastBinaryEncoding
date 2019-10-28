/*!
    \file generator_swift.h
    \brief Fast binary encoding Kotlin generator definition
    \author Andrey Zbranevich
    \ Based on original Fast binary encoding generator design by
    \ Ivan Shynkarenka
    \date 01.08.2019
    \copyright MIT License
*/

#ifndef GENERATOR_SWIFT_H
#define GENERATOR_SWIFT_H

#include "generator.h"

namespace FBE {

class GeneratorSwift : public Generator
{
public:
    using Generator::Generator;

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorSwift& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorSwift& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Proto() const noexcept { return _proto; }
    GeneratorSwift& Proto(bool proto) noexcept { _proto = proto; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final{false};
    bool _json{false};
    bool _proto{false};

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateImports(const std::string& domain, const std::string& package);
    void GenerateImports(const std::shared_ptr<Package>& p);

    void GenerateFBEPackage(const std::string& domain, const std::string& package);
    void GenerateFBEUUIDGenerator(const std::string& domain, const std::string& package);
    void GenerateFBEBuffer(const std::string& domain, const std::string& package);
    void GenerateFBEModel(const std::string& domain, const std::string& package);
    void GenerateFBESize(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModel(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModel(const std::string& domain, const std::string& package, const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelDecimal(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModelTimestamp(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModelBytes(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModelString(const std::string& domain, const std::string& package);
    void GenerateFBEFieldModelOptional(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFieldModelArray(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& base, bool optional, const std::string& model);
    void GenerateFBEFieldModelVector(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFieldModelMap(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& key_name, const std::string& key_type, const std::string& key_model, const std::string& value_name, const std::string& value_type, const std::string& value_model);
    void GenerateFBEFieldModelEnumFlags(const std::string& domain, const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBEFinalModel(const std::string& domain, const std::string& package);
    void GenerateFBEFinalModel(const std::string& domain, const std::string& package, const std::string& name, const std::string& type, const std::string& base, const std::string& size, const std::string& defaults);
    void GenerateFBEFinalModelDecimal(const std::string& domain, const std::string& package);
    void GenerateFBEFinalModelTimestamp(const std::string& domain, const std::string& package);
    void GenerateFBEFinalModelBytes(const std::string& domain, const std::string& package);
    void GenerateFBEFinalModelString(const std::string& domain, const std::string& package);
    void GenerateFBEFinalModelOptional(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFinalModelArray(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& base, bool optional, const std::string& model);
    void GenerateFBEFinalModelVector(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& name, const std::string& type, const std::string& model);
    void GenerateFBEFinalModelMap(const std::string& domain, const std::shared_ptr<Package>& p, const std::string& key_name, const std::string& key_type, const std::string& key_model, const std::string& value_name, const std::string& value_type, const std::string& value_model);
    void GenerateFBEFinalModelEnumFlags(const std::string& domain, const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBESender(const std::string& domain, const std::string& package);
    void GenerateFBEReceiver(const std::string& domain, const std::string& package);
    void GenerateFBEReceiverListener(const std::string& domain, const std::string& package);
    void GenerateFBEClient(const std::string& domain, const std::string& package);

    void GenerateContainers(const std::shared_ptr<Package>& p, bool final);
    void GeneratePackage(const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e, const CppCommon::Path& path);
    void GenerateEnumClass(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e, const CppCommon::Path& path);
    void GenerateFlags(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& e, const CppCommon::Path& path);
    void GenerateFlagsClass(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& e, const CppCommon::Path& path);
    void GenerateStruct(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateProtocolVersion(const std::shared_ptr<Package>& p);
    void GenerateSender(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiverListener(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxyListener(const std::shared_ptr<Package>& p, bool final);
    void GenerateClient(const std::shared_ptr<Package>& p, bool final);

    bool IsKnownType(const std::string& type);
    bool IsImportedType(const std::string& type);
    bool IsPackageType(const std::string& type);
    bool IsPrimitiveType(const std::string& type, bool optional);
    bool IsUnsignedType(const std::string& type);

    CppCommon::Path CreatePackagePath(const std::string& domain, const std::string& package);

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
    std::string ConvertTypeName(const std::string& domain, const std::string& package, const std::string& type, bool optional);
    std::string ConvertTypeName(const std::string& domain, const std::string& package, const StructField& field, bool typeless);
    std::string ConvertTypeImport(const std::string& type);
    std::string ConvertBaseFieldName(const std::string& domain, const std::string& type, bool final);
    std::string ConvertTypeFieldName(const std::string& type);
    std::string ConvertTypeFieldType(const std::string& domain, const std::string& type, bool optional);
    std::string ConvertTypeFieldDeclaration(const std::string& domain, const std::string& type, bool optional, bool final);
    std::string ConvertTypeFieldDeclaration(const std::string& domain, const StructField& field, bool final);
    std::string ConvertTypeFieldInitialization(const std::string& domain, const StructField& field, const std::string& offset, bool final);
    std::string ConvertConstant(const std::string& domain, const std::string& package, const std::string& type, const std::string& value, bool optional);
    std::string ConvertConstantPrefix(const std::string& type);
    std::string ConvertConstantSuffix(const std::string& type);
    std::string ConvertDefault(const std::string& domain, const std::string& package, const std::string& type);
    std::string ConvertDefault(const std::string& domain, const std::string& package, const StructField& field);

    std::string ConvertOutputStreamType(const std::string& type, const std::string& name, bool optional);
    std::string ConvertOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate, bool nullable);
    std::string ConvertDomain(const std::shared_ptr<Package>& package);
    std::string ConvertPackage(const std::shared_ptr<Package>& package);
    std::string ConvertPackageName(const std::string& package);
};

} // namespace FBE

#endif // GENERATOR_SWIFT_H
