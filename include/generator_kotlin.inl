/*!
    \file generator_kotlin.inl
    \brief Fast binary encoding Kotlin generator inline implementation
    \author Ivan Shynkarenka
    \date 03.10.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorKotlin::GeneratorKotlin(const std::string& output, int indent, char space)
    : Generator(output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
