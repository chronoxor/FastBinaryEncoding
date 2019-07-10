/*!
    \file generator_go.h
    \brief Fast binary encoding Go generator definition
    \author Ivan Shynkarenka
    \date 20.11.2018
    \copyright MIT License
*/

#ifndef GENERATOR_GO_H
#define GENERATOR_GO_H

#include "generator.h"

namespace FBE {

class GeneratorGo : public Generator
{
public:
    using Generator::Generator;

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorGo& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorGo& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Proto() const noexcept { return _proto; }
    GeneratorGo& Proto(bool proto) noexcept { _proto = proto; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final{false};
    bool _json{false};
    bool _proto{false};

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateFBEPackage(const std::string& package);
    void GenerateFBEConstants(const std::string& package);
    void GenerateFBEJson(const std::string& package);
    void GenerateFBEOptional(const std::string& package);
    void GenerateFBETypes(const std::string& package);
    void GenerateFBEVersion(const std::string& package, const std::string& source);
    void GenerateFBEBuffer(const std::string& package);
    void GenerateFBEFieldModel(const std::string& package, const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelDecimal(const std::string& package);
    void GenerateFBEFieldModelTimestamp(const std::string& package);
    void GenerateFBEFieldModelUUID(const std::string& package);
    void GenerateFBEFieldModelBytes(const std::string& package);
    void GenerateFBEFieldModelString(const std::string& package);
    void GenerateFBEFieldModelOptional(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFieldModelArray(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFieldModelVector(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFieldModelSet(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFieldModelMap(const std::shared_ptr<Package>& p, const std::string& key_name, const std::string& key_model, const std::string& value_name, const std::string& value_model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFieldModelEnumFlags(const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBEFinalModel(const std::string& package, const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
    void GenerateFBEFinalModelDecimal(const std::string& package);
    void GenerateFBEFinalModelTimestamp(const std::string& package);
    void GenerateFBEFinalModelUUID(const std::string& package);
    void GenerateFBEFinalModelBytes(const std::string& package);
    void GenerateFBEFinalModelString(const std::string& package);
    void GenerateFBEFinalModelOptional(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFinalModelArray(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFinalModelVector(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFinalModelSet(const std::shared_ptr<Package>& p, const std::string& name, const std::string& model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFinalModelMap(const std::shared_ptr<Package>& p, const std::string& key_name, const std::string& key_model, const std::string& value_name, const std::string& value_model, const StructField& field, const CppCommon::Path& path);
    void GenerateFBEFinalModelEnumFlags(const std::string& package, const std::string& name, const std::string& type);
    void GenerateFBESender(const std::string& package);
    void GenerateFBEReceiver(const std::string& package);
    void GenerateImports(const std::shared_ptr<Package>& p);

    void GenerateContainers(const std::shared_ptr<Package>& p, const CppCommon::Path& path, bool final);
    void GeneratePackage(const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e, const CppCommon::Path& path);
    void GenerateFlags(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f, const CppCommon::Path& path);
    void GenerateStruct(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateStructModelFinal(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s, const CppCommon::Path& path);
    void GenerateProtocolVersion(const std::shared_ptr<Package>& p, const CppCommon::Path& path);
    void GenerateSender(const std::shared_ptr<Package>& p, const CppCommon::Path& path, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, const CppCommon::Path& path, bool final);
    void GenerateProxy(const std::shared_ptr<Package>& p, const CppCommon::Path& path, bool final);

    bool IsPrimitiveType(const std::string& type);
    bool IsGoType(const std::string& type);

    std::string ConvertToLower(const std::string& type);
    std::string ConvertToUpper(const std::string& type);
    std::string ConvertEnumBase(const std::string& type);
    std::string ConvertEnumSize(const std::string& type);
    std::string ConvertEnumType(const std::string& type);
    std::string ConvertEnumConstant(const std::string& value);
    std::string ConvertEnumConstant(const std::string& name, const std::string& type, const std::string& value);
    std::string ConvertBaseName(const std::string& type);
    std::string ConvertKeyName(const std::string& type);
    std::string ConvertModelName(const std::string& type, const std::string& model);
    std::string ConvertNewName(const std::string& type);
    std::string ConvertOptional(const std::string& type);
    std::string ConvertOptional(const std::string& type, const std::string& value);
    std::string ConvertTypeName(const std::string& type, bool optional);
    std::string ConvertTypeName(const StructField& field);
    std::string ConvertTypeFieldName(const std::string& type);
    std::string ConvertTypeFieldType(const std::string& type, bool optional);
    std::string ConvertTypeFieldDeclaration(const std::string& type, bool optional, bool final);
    std::string ConvertTypeFieldDeclaration(const StructField& field, bool final);
    std::string ConvertTypeFieldInitialization(const std::string& type, bool optional, const std::string& offset, bool final);
    std::string ConvertTypeFieldInitialization(const StructField& field, const std::string& offset, bool final);
    std::string ConvertConstant(const std::string& type, const std::string& value, bool optional);
    std::string ConvertDefault(const std::string& type, bool optional);
    std::string ConvertDefault(const StructField& field);

    void WriteOutputStreamType(const std::string& type, const std::string& name, bool optional);
    void WriteOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate);
};

} // namespace FBE

#endif // GENERATOR_GO_H
