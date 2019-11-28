/*!
    \file generator.h
    \brief Fast binary encoding generator definition
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

#ifndef GENERATOR_H
#define GENERATOR_H

#include "fbe.h"

namespace FBE {

class Generator
{
public:
    Generator(const std::string& input, const std::string& output, int indent, char space);

    virtual void Generate(const std::shared_ptr<Package>& package) = 0;

protected:
    std::string _buffer;
    std::string _input;
    std::string _output;
    int _cursor{0};
    int _indent;
    char _space;

    void Indent(int count);

    void WriteBegin();
    void Write(const std::string& str);
    void WriteIndent();
    void WriteIndent(const std::string& str);
    void WriteLine();
    void WriteLine(const std::string& str);
    void WriteLineIndent(const std::string& str);
    void WriteEnd();

    void Store(const CppCommon::Path& filename);

    static std::string EndLine();
};

} // namespace FBE

#include "generator.inl"

#endif // GENERATOR_H
