/*!
    \file generator_ruby.inl
    \brief Fast binary encoding Ruby generator inline implementation
    \author Ivan Shynkarenka
    \date 15.10.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorRuby::GeneratorRuby(const std::string& output, int indent, char space)
    : Generator(output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
