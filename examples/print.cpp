/*!
    \file print.cpp
    \brief Fast Binary Encoding print example
    \author Ivan Shynkarenka
    \date 18.04.2018
    \copyright MIT License
*/

#include "../proto/test.h"

#include <iostream>

int main(int argc, char** argv)
{
    std::cout << test::StructSimple() << std::endl << std::endl;
    std::cout << test::StructOptional() << std::endl << std::endl;
    std::cout << test::StructNested() << std::endl << std::endl;
    return 0;
}
