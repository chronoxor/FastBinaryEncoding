/*!
    \file generator_go.inl
    \brief Fast binary encoding Go generator inline implementation
    \author Ivan Shynkarenka
    \date 24.04.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorGo::GeneratorGo(const std::string& input, const std::string& output, int indent, char space)
    : Generator(input, output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
