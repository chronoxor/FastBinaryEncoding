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
    GeneratorGo(const std::string& input, const std::string& output, int indent, char space);

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorGo& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorGo& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Sender() const noexcept { return _sender; }
    GeneratorGo& Sender(bool sender) noexcept { _sender = sender; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final;
    bool _json;
    bool _sender;

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateFBEPackage(const std::string& package);
    void GenerateFBEConstants(const std::string& package);
    void GenerateFBEBuffer(const std::string& package);
    void GenerateFBEFieldModel(const std::string& package, const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelDecimal();
    void GenerateFBEFieldModelBytes();
    void GenerateFBEFieldModelString();
    void GenerateFBEFieldModelOptional();
    void GenerateFBEFieldModelArray();
    void GenerateFBEFieldModelVector();
    void GenerateFBEFieldModelSet();
    void GenerateFBEFieldModelMap();
    void GenerateFBEFinalModel();
    void GenerateFBEFinalModel(const std::string& package, const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
    void GenerateFBEFinalModelDecimal();
    void GenerateFBEFinalModelBytes();
    void GenerateFBEFinalModelString();
    void GenerateFBEFinalModelOptional();
    void GenerateFBEFinalModelArray();
    void GenerateFBEFinalModelVector();
    void GenerateFBEFinalModelSet();
    void GenerateFBEFinalModelMap();
    void GenerateFBESender();
    void GenerateFBEReceiver();
    void GenerateImports(const std::shared_ptr<Package>& p);

    void GeneratePackage(const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::shared_ptr<EnumType>& e);
    void GenerateEnumFieldModel(const std::shared_ptr<EnumType>& e);
    void GenerateEnumFinalModel(const std::shared_ptr<EnumType>& e);
    void GenerateFlags(const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFieldModel(const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFinalModel(const std::shared_ptr<FlagsType>& f);
    void GenerateStruct(const std::shared_ptr<StructType>& s);
    void GenerateStructFieldModel(const std::shared_ptr<StructType>& s);
    void GenerateStructModel(const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel(const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal(const std::shared_ptr<StructType>& s);
    void GenerateSender(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, bool final);

    bool IsPrimitiveType(const std::string& type);
    bool IsGoType(const std::string& type);

    std::string ConvertEnumSize(const std::string& type);
    std::string ConvertEnumType(const std::string& type);
    std::string ConvertEnumConstant(const std::string& type, const std::string& value);
    std::string ConvertTypeName(const std::string& type, bool optional);
    std::string ConvertTypeName(const StructField& field);
    std::string ConvertTypeFieldName(const std::string& type, bool final);
    std::string ConvertTypeFieldInitialization(const std::string& type, bool optional, const std::string& offset, bool final);
    std::string ConvertTypeFieldInitialization(const StructField& field, const std::string& offset, bool final);
    std::string ConvertConstant(const std::string& type, const std::string& value, bool optional);
    std::string ConvertDefaultOrNone(const std::string& type, bool optional);
    std::string ConvertDefault(const std::string& type, bool optional);
    std::string ConvertDefault(const StructField& field);

    void WriteOutputStreamType(const std::string& type, const std::string& name, bool optional);
    void WriteOutputStreamItem(const std::string& type, const std::string& name, bool optional);
    void WriteOutputStreamValue(const std::string& type, const std::string& name, bool optional);
};

} // namespace FBE

#include "generator_go.inl"

#endif // GENERATOR_GO_H
