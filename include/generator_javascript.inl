/*!
    \file generator_javascript.inl
    \brief Fast binary encoding JavaScript generator inline implementation
    \author Ivan Shynkarenka
    \date 28.06.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorJavaScript::GeneratorJavaScript(const std::string& input, const std::string& output, int indent, char space)
    : Generator(input, output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
