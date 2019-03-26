/*!
    \file generator_cpp.h
    \brief Fast binary encoding C++ generator definition
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

#ifndef GENERATOR_CPP_H
#define GENERATOR_CPP_H

#include "generator.h"

namespace FBE {

class GeneratorCpp : public Generator
{
public:
    GeneratorCpp(const std::string& input, const std::string& output, int indent, char space);

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorCpp& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorCpp& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Sender() const noexcept { return _sender; }
    GeneratorCpp& Sender(bool sender) noexcept { _sender = sender; return *this; }

    // Logging protocol code generation
    bool Logging() const noexcept { return _logging; }
    GeneratorCpp& Logging(bool logging) noexcept { _logging = logging; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final;
    bool _json;
    bool _sender;
    bool _logging;

    void GenerateHeader(const std::string& source);
    void GenerateFooter();
    void GenerateImports();
    void GenerateImports(const std::shared_ptr<Package>& p);
    void GenerateBufferWrapper();
    void GenerateDecimalWrapper();
    void GenerateFlagsWrapper();
    void GenerateTimeWrapper();
    void GenerateUUIDWrapper();
    void GenerateFBEWriteBuffer();
    void GenerateFBEReadBuffer();
    void GenerateFBEBaseModel();
    void GenerateFBEFieldModel();
    void GenerateFBEFieldModelDecimal();
    void GenerateFBEFieldModelUUID();
    void GenerateFBEFieldModelBytes();
    void GenerateFBEFieldModelString();
    void GenerateFBEFieldModelOptional();
    void GenerateFBEFieldModelArray();
    void GenerateFBEFieldModelVector();
    void GenerateFBEFieldModelMap();
    void GenerateFBEFinalModel();
    void GenerateFBEFinalModelDecimal();
    void GenerateFBEFinalModelUUID();
    void GenerateFBEFinalModelBytes();
    void GenerateFBEFinalModelString();
    void GenerateFBEFinalModelOptional();
    void GenerateFBEFinalModelArray();
    void GenerateFBEFinalModelVector();
    void GenerateFBEFinalModelMap();
    void GenerateFBESender();
    void GenerateFBEReceiver();
    void GenerateFBEJson();
    void GenerateFBE(const CppCommon::Path& path);

    void GeneratePackage(const std::shared_ptr<Package>& p);
    void GenerateEnum(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateEnumOutputStream(const std::shared_ptr<EnumType>& e);
    void GenerateEnumLoggingStream(const std::shared_ptr<EnumType>& e);
    void GenerateEnumJson(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateEnumFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateEnumFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<EnumType>& e);
    void GenerateFlags(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsOutputStream(const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsLoggingStream(const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsJson(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateFlagsFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<FlagsType>& f);
    void GenerateStruct(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructOutputStream(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructLoggingStream(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructHash(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructJson(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFieldModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateSender(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy(const std::shared_ptr<Package>& p, bool final);

    bool IsKnownType(const std::string& type);
    bool IsPrimitiveType(const std::string& type, bool optional);

    std::string ConvertEnumType(const std::string& type);
    std::string ConvertTypeName(const std::string& package, const std::string& type, bool optional);
    std::string ConvertTypeName(const std::string& package, const StructField& field);
    std::string ConvertTypeNameAsArgument(const std::string& package, const StructField& field);
    std::string ConvertConstant(const std::string& type, const std::string& value, bool optional);
    std::string ConvertConstantPrefix(const std::string& type);
    std::string ConvertConstantSuffix(const std::string& type);
    std::string ConvertDefault(const std::string& package, const std::string& type);
    std::string ConvertDefault(const std::string& package, const StructField& field);

    std::string ConvertOutputStreamType(const std::string& type, const std::string& name, bool optional);
    std::string ConvertOutputStreamValue(const std::string& type, const std::string& name, bool optional, bool separate);

    std::string ConvertLoggingStreamType(const std::string& type, const std::string& name, bool optional);
    std::string ConvertLoggingStreamValue(const std::string& type, const std::string& name, bool optional, bool separate);
};

} // namespace FBE

#include "generator_cpp.inl"

#endif // GENERATOR_CPP_H
