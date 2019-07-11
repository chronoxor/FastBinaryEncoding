/*!
    \file generator_python.h
    \brief Fast binary encoding Python generator definition
    \author Ivan Shynkarenka
    \date 24.04.2018
    \copyright MIT License
*/

#ifndef GENERATOR_PYTHON_H
#define GENERATOR_PYTHON_H

#include "generator.h"

namespace FBE {

class GeneratorPython : public Generator
{
public:
    using Generator::Generator;

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorPython& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorPython& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Proto() const noexcept { return _proto; }
    GeneratorPython& Proto(bool proto) noexcept { _proto = proto; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final{false};
    bool _json{false};
    bool _proto{false};

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateInit(const CppCommon::Path& path);
    void GenerateFBE(const CppCommon::Path& path);
    void GenerateFBEWriteBuffer();
    void GenerateFBEReadBuffer();
    void GenerateFBEModel();
    void GenerateFBEFieldModelBase();
    void GenerateFBEFieldModel();
    void GenerateFBEFieldModel(const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
    void GenerateFBEFieldModelDecimal();
    void GenerateFBEFieldModelBytes();
    void GenerateFBEFieldModelString();
    void GenerateFBEFieldModelOptional();
    void GenerateFBEFieldModelArray();
    void GenerateFBEFieldModelVector();
    void GenerateFBEFieldModelSet();
    void GenerateFBEFieldModelMap();
    void GenerateFBEFinalModel();
    void GenerateFBEFinalModel(const std::string& name, const std::string& type, const std::string& size, const std::string& defaults);
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
    void GenerateProtocolVersion(const std::shared_ptr<Package>& p);
    void GenerateSender(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy(const std::shared_ptr<Package>& p, bool final);

    bool IsPrimitiveType(const std::string& type);
    bool IsPythonType(const std::string& type);

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
    void WriteOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate);
};

} // namespace FBE

#endif // GENERATOR_PYTHON_H
