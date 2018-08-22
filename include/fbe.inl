/*!
    \file fbe.inl
    \brief Fast binary encoding inline implementation
    \author Ivan Shynkarenka
    \date 11.04.2018
    \copyright MIT License
*/

namespace FBE {

inline StructField::StructField()
    : keys(false),
      optional(false),
      array(false),
      vector(false),
      list(false),
      set(false),
      map(false),
      hash(false),
      N(0)
{
}

inline void StructField::SetArraySize(int size)
{
    if (size <= 0)
        yyerror("Array size should be greater than zero!");

    N = size;
}

} // namespace FBE
