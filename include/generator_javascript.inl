/*!
    \file generator_javascript.inl
    \brief Fast binary encoding JavaScript generator inline implementation
    \author Ivan Shynkarenka
    \date 28.06.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorJavaScript::GeneratorJavaScript(const std::string& output, int indent, char space)
    : Generator(output, indent, space), _final(false), _json(false)
{
}

} // namespace FBE
