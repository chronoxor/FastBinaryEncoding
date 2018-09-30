/*!
    \file generator_python.inl
    \brief Fast binary encoding Python generator inline implementation
    \author Ivan Shynkarenka
    \date 24.04.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorPython::GeneratorPython(const std::string& output, int indent, char space)
    : Generator(output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
