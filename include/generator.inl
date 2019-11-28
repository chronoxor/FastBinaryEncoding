/*!
    \file generator.inl
    \brief Fast binary encoding generator inline implementation
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

namespace FBE {

inline Generator::Generator(const std::string& input, const std::string& output, int indent, char space)
    : _input(input),
      _output(output),
      _indent(indent),
      _space(space)
{
}

inline void Generator::Indent(int count)
{
    _cursor += _indent * count;
}

inline void Generator::WriteBegin()
{
    _buffer.clear();
}

inline void Generator::Write(const std::string& str)
{
    _buffer.append(str);
}

inline void Generator::WriteIndent()
{
    for (int i = 0; i < _cursor; ++i)
        _buffer.append(1, _space);
}

inline void Generator::WriteIndent(const std::string& str)
{
    for (int i = 0; i < _cursor; ++i)
        _buffer.append(1, _space);
    _buffer.append(str);
}

inline void Generator::WriteLine()
{
    Write(EndLine());
}

inline void Generator::WriteLine(const std::string& str)
{
    Write(str);
    Write(EndLine());
}

inline void Generator::WriteLineIndent(const std::string& str)
{
    WriteIndent(str);
    Write(EndLine());
}

inline void Generator::WriteEnd()
{
}

inline std::string Generator::EndLine()
{
    return CppCommon::Environment::EndLine();
}

} // namespace FBE
