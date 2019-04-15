/*!
    \file fbe.inl
    \brief Fast binary encoding inline implementation
    \author Ivan Shynkarenka
    \date 11.04.2018
    \copyright MIT License
*/

namespace FBE {

inline void StructField::SetArraySize(int size)
{
    if (size <= 0)
        yyerror("Array size should be greater than zero!");

    N = size;
}

} // namespace FBE
