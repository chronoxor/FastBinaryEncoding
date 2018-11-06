/*!
    \file generator_csharp.inl
    \brief Fast binary encoding C# generator inline implementation
    \author Ivan Shynkarenka
    \date 20.04.2018
    \copyright MIT License
*/

namespace FBE {

inline GeneratorCSharp::GeneratorCSharp(const std::string& input, const std::string& output, int indent, char space)
    : Generator(input, output, indent, space), _final(false), _json(false), _sender(false)
{
}

} // namespace FBE
