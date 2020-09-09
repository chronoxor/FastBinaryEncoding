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
    using Generator::Generator;

    // Final protocol code generation
    bool Final() const noexcept { return _final; }
    GeneratorCpp& Final(bool final) noexcept { _final = final; return *this; }

    // JSON protocol code generation
    bool JSON() const noexcept { return _json; }
    GeneratorCpp& JSON(bool json) noexcept { _json = json; return *this; }

    // Sender/Receiver protocol code generation
    bool Proto() const noexcept { return _proto; }
    GeneratorCpp& Proto(bool proto) noexcept { _proto = proto; return *this; }

    // Logging protocol code generation
    bool Logging() const noexcept { return _logging; }
    GeneratorCpp& Logging(bool logging) noexcept { _logging = logging; return *this; }

    void Generate(const std::shared_ptr<Package>& package) override;

private:
    bool _final{false};
    bool _json{false};
    bool _proto{false};
    bool _logging{false};

    void GenerateHeader(const std::string& source);
    void GenerateInline(const std::string& source);
    void GenerateSource(const std::string& source);
    void GenerateWarningsHeader();
    void GenerateWarningsFooter();
    void GenerateFooter();
    void GenerateImports();
    void GenerateImports(const std::string& source);
    void GenerateImports(const std::shared_ptr<Package>& p);
    void GenerateImportsModels(const std::shared_ptr<Package>& p, bool final);
    void GenerateImportsProtocol(const std::shared_ptr<Package>& p, bool final);
    void GenerateImportsJson();
    void GenerateImportsJson(const std::shared_ptr<Package>& p);
    void GenerateBufferWrapper_Header();
    void GenerateBufferWrapper_Source();
    void GenerateDecimalWrapper_Header();
    void GenerateFlagsWrapper_Header();
    void GenerateTimeWrapper_Header();
    void GenerateTimeWrapper_Source();
    void GenerateUUIDWrapper_Header();
    void GenerateUUIDWrapper_Source();
    void GenerateFBEBuffer_Header();
    void GenerateFBEBuffer_Source();
    void GenerateFBEBaseModel_Header();
    void GenerateFBEFieldModel_Header();
    void GenerateFBEFieldModel_Inline();
    void GenerateFBEFieldModelDecimal_Header();
    void GenerateFBEFieldModelDecimal_Source();
    void GenerateFBEFieldModelUUID_Header();
    void GenerateFBEFieldModelUUID_Source();
    void GenerateFBEFieldModelBytes_Header();
    void GenerateFBEFieldModelBytes_Source();
    void GenerateFBEFieldModelString_Header();
    void GenerateFBEFieldModelString_Source();
    void GenerateFBEFieldModelOptional_Header();
    void GenerateFBEFieldModelOptional_Inline();
    void GenerateFBEFieldModelArray_Header();
    void GenerateFBEFieldModelArray_Inline();
    void GenerateFBEFieldModelVector_Header();
    void GenerateFBEFieldModelVector_Inline();
    void GenerateFBEFieldModelMap_Header();
    void GenerateFBEFieldModelMap_Inline();
    void GenerateFBEFinalModel_Header();
    void GenerateFBEFinalModel_Inline();
    void GenerateFBEFinalModelDecimal_Header();
    void GenerateFBEFinalModelDecimal_Source();
    void GenerateFBEFinalModelUUID_Header();
    void GenerateFBEFinalModelUUID_Source();
    void GenerateFBEFinalModelBytes_Header();
    void GenerateFBEFinalModelBytes_Source();
    void GenerateFBEFinalModelString_Header();
    void GenerateFBEFinalModelString_Source();
    void GenerateFBEFinalModelOptional_Header();
    void GenerateFBEFinalModelOptional_Inline();
    void GenerateFBEFinalModelArray_Header();
    void GenerateFBEFinalModelArray_Inline();
    void GenerateFBEFinalModelVector_Header();
    void GenerateFBEFinalModelVector_Inline();
    void GenerateFBEFinalModelMap_Header();
    void GenerateFBEFinalModelMap_Inline();
    void GenerateFBESender_Header();
    void GenerateFBESender_Source();
    void GenerateFBEReceiver_Header();
    void GenerateFBEReceiver_Source();
    void GenerateFBEJson();
    void GenerateFBE_Header(const CppCommon::Path& path);
    void GenerateFBE_Source(const CppCommon::Path& path);
    void GenerateFBEModels_Header(const CppCommon::Path& path);
    void GenerateFBEModels_Inline(const CppCommon::Path& path);
    void GenerateFBEModels_Source(const CppCommon::Path& path);
    void GenerateFBEFinalModels_Header(const CppCommon::Path& path);
    void GenerateFBEFinalModels_Inline(const CppCommon::Path& path);
    void GenerateFBEFinalModels_Source(const CppCommon::Path& path);
    void GenerateFBEProtocol_Header(const CppCommon::Path& path);
    void GenerateFBEProtocol_Source(const CppCommon::Path& path);
    void GenerateFBEJson_Header(const CppCommon::Path& path);

    void GeneratePackage_Header(const std::shared_ptr<Package>& p);
    void GeneratePackage_Inline(const std::shared_ptr<Package>& p);
    void GeneratePackage_Source(const std::shared_ptr<Package>& p);
    void GeneratePackage_Json(const std::shared_ptr<Package>& p);
    void GeneratePackageModels_Header(const std::shared_ptr<Package>& p);
    void GeneratePackageModels_Source(const std::shared_ptr<Package>& p);
    void GeneratePackageFinalModels_Header(const std::shared_ptr<Package>& p);
    void GeneratePackageFinalModels_Source(const std::shared_ptr<Package>& p);
    void GeneratePackageProtocol_Header(const std::shared_ptr<Package>& p, bool final);
    void GeneratePackageProtocol_Source(const std::shared_ptr<Package>& p, bool final);
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
    void GenerateStruct_Header(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStruct_Source(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructOutputStream(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructLoggingStream(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructHash(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructJson(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFieldModel_Header(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFieldModel_Source(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel_Header(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModel_Source(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel_Header(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructFinalModel_Source(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal_Header(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateStructModelFinal_Source(const std::shared_ptr<Package>& p, const std::shared_ptr<StructType>& s);
    void GenerateProtocolVersion(const std::shared_ptr<Package>& p);
    void GenerateSender_Header(const std::shared_ptr<Package>& p, bool final);
    void GenerateSender_Source(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver_Header(const std::shared_ptr<Package>& p, bool final);
    void GenerateReceiver_Source(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy_Header(const std::shared_ptr<Package>& p, bool final);
    void GenerateProxy_Source(const std::shared_ptr<Package>& p, bool final);
    void GenerateClient_Header(const std::shared_ptr<Package>& p, bool final);
    void GenerateClient_Source(const std::shared_ptr<Package>& p, bool final);

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

#endif // GENERATOR_CPP_H
