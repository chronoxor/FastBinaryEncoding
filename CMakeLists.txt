cmake_minimum_required(VERSION 3.6)

# Global properties
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Project name
project(FastBinaryEncoding)

# Doxygen
find_package(Doxygen)
if(DOXYGEN_FOUND)
  set(DOXYGEN "doxygen")
  if(NOT TARGET ${DOXYGEN})
    add_custom_command(OUTPUT "Doxyfile" COMMAND ${DOXYGEN_EXECUTABLE} "Doxyfile" WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/documents")
    add_custom_target(${DOXYGEN} DEPENDS "Doxyfile")
    set_target_properties(${DOXYGEN} PROPERTIES FOLDER doxygen)
  endif()
endif()

# CMake module path
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Compiler features
include(SetCompilerFeatures)
include(SetCompilerWarnings)
include(SetPlatformFeatures)
include(SystemInformation)

# External packages
find_package(BISON)
find_package(FLEX)
find_package(Threads REQUIRED)

# Modules
add_subdirectory("modules")

# Link libraries
list(APPEND LINKLIBS cppcommon)

# System directories
include_directories(SYSTEM "${CMAKE_CURRENT_SOURCE_DIR}/modules")

# Lexer & parser
if(MSVC)
  flex_target(lexer "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe.l" "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe-lexer.cpp" COMPILE_FLAGS "--verbose --hex --yylineno --wincompat")
else()
  flex_target(lexer "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe.l" "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe-lexer.cpp" COMPILE_FLAGS "--verbose --yylineno")
endif()
bison_target(parser "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe.y" "${CMAKE_CURRENT_SOURCE_DIR}/source/fbe-parser.cpp")
add_flex_bison_dependency(lexer parser)

# Compiler
file(GLOB_RECURSE SOURCE_FILES "source/*.cpp")
list(APPEND SOURCE_FILES ${FLEX_lexer_OUTPUTS})
list(APPEND SOURCE_FILES ${BISON_parser_OUTPUTS})
if(MSVC)
  # C4005: 'identifier' : macro redefinition
  # C4065: switch statement contains 'default' but no 'case' labels
  # C4127: conditional expression is constant
  # C4244: 'conversion' conversion from 'type1' to 'type2', possible loss of data
  # C4505: 'function' : unreferenced local function has been removed
  # C4702: unreachable code
  set_source_files_properties(${SOURCE_FILES} PROPERTIES COMPILE_FLAGS "${PEDANTIC_COMPILE_FLAGS} /wd4005 /wd4065 /wd4127 /wd4244 /wd4505 /wd4702")
else()
  # error: ISO C++17 does not allow ‘register’ storage class specifier
  set_source_files_properties(${SOURCE_FILES} PROPERTIES COMPILE_FLAGS "${PEDANTIC_COMPILE_FLAGS} -Wno-register")
endif()
add_executable(fbec ${SOURCE_FILES})
target_include_directories(fbec PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(fbec ${LINKLIBS} cpp-optparse)
set_target_properties(fbec PROPERTIES FOLDER compiler)
list(APPEND INSTALL_TARGETS fbec)

# Additional module components: benchmarks, examples, plugins, tests, tools and install
if(NOT FBEC_MODULE)

  # Proto FBE models
  file(GLOB FBE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/proto" "proto/*.fbe")
  foreach(FBE_FILE ${FBE_FILES})
    string(REGEX REPLACE "(.*)\\.fbe" "\\1.h" FBE_HEADER ${FBE_FILE})
    set(FBE_INPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/proto")
    set(FBE_INPUT_FILE "${FBE_INPUT_DIR}/${FBE_FILE}")
    set(FBE_OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/proto")
    set(FBE_OUTPUT_FILE "${FBE_OUTPUT_DIR}/${FBE_HEADER}")
    set(FBE_TARGET "${FBE_FILE}_TARGET")
    add_custom_command(
        OUTPUT ${FBE_OUTPUT_FILE} DEPENDS ${FBE_INPUT_FILE}
        COMMAND $<TARGET_FILE:fbec> --cpp --final --json --input ${FBE_INPUT_FILE} --output ${FBE_OUTPUT_DIR} COMMENT "Generating C++ proto for ${FBE_INPUT_FILE}..." VERBATIM
        COMMAND $<TARGET_FILE:fbec> --csharp --final --json --input ${FBE_INPUT_FILE} --output ${CMAKE_CURRENT_SOURCE_DIR}/projects/CSharp/Proto COMMENT "Generating C# proto for ${FBE_INPUT_FILE}..." VERBATIM
        COMMAND $<TARGET_FILE:fbec> --csharp --final --json --input ${FBE_INPUT_FILE} --output ${CMAKE_CURRENT_SOURCE_DIR}/projects/.NETCore/Proto COMMENT "Generating .NET Core proto for ${FBE_INPUT_FILE}..." VERBATIM
        COMMAND $<TARGET_FILE:fbec> --java --final --json --input ${FBE_INPUT_FILE} --output ${CMAKE_CURRENT_SOURCE_DIR}/projects/Java/src/proto COMMENT "Generating Java proto for ${FBE_INPUT_FILE}..." VERBATIM
        COMMAND $<TARGET_FILE:fbec> --javascript --final --json --input ${FBE_INPUT_FILE} --output ${CMAKE_CURRENT_SOURCE_DIR}/projects/JavaScript/proto COMMENT "Generating JavaScript proto for ${FBE_INPUT_FILE}..." VERBATIM
        COMMAND $<TARGET_FILE:fbec> --python --final --json --input ${FBE_INPUT_FILE} --output ${CMAKE_CURRENT_SOURCE_DIR}/projects/Python/proto COMMENT "Generating Python proto for ${FBE_INPUT_FILE}..." VERBATIM
    )
    add_custom_target(${FBE_TARGET} DEPENDS ${FBE_OUTPUT_FILE})
    set_target_properties(${FBE_TARGET} PROPERTIES FOLDER proto)
    list(APPEND PROTO_DEPENDENCIES ${FBE_TARGET})
    list(APPEND PROTO_FILES ${FBE_OUTPUT_FILE})
  endforeach()

  # Examples
  file(GLOB EXAMPLE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/examples" "examples/*.cpp")
  foreach(EXAMPLE_FILE ${EXAMPLE_FILES})
    string(REGEX REPLACE "(.*)\\.cpp" "\\1" EXAMPLE_NAME ${EXAMPLE_FILE})
    set(EXAMPLE_TARGET "fbe-example-${EXAMPLE_NAME}")
    set_source_files_properties(examples/${EXAMPLE_FILE} PROPERTIES COMPILE_FLAGS "${PEDANTIC_COMPILE_FLAGS}")
    add_executable(${EXAMPLE_TARGET} examples/${EXAMPLE_FILE} ${PROTO_FILES})
    add_dependencies(${EXAMPLE_TARGET} ${PROTO_DEPENDENCIES})
    target_include_directories(${EXAMPLE_TARGET} PUBLIC ${rapidjson})
    target_link_libraries(${EXAMPLE_TARGET} ${LINKLIBS})
    set_target_properties(${EXAMPLE_TARGET} PROPERTIES FOLDER examples)
    list(APPEND INSTALL_TARGETS ${EXAMPLE_TARGET})
    list(APPEND INSTALL_TARGETS_PDB ${EXAMPLE_TARGET})
  endforeach()

  # Benchmarks
  file(GLOB BENCHMARK_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/performance" "performance/*.cpp")
  foreach(BENCHMARK_FILE ${BENCHMARK_FILES})
    string(REGEX REPLACE "(.*)\\.cpp" "\\1" BENCHMARK_NAME ${BENCHMARK_FILE})
    set(BENCHMARK_TARGET "fbe-performance-${BENCHMARK_NAME}")
    set_source_files_properties(performance/${BENCHMARK_FILE} PROPERTIES COMPILE_FLAGS "${PEDANTIC_COMPILE_FLAGS}")
    add_executable(${BENCHMARK_TARGET} performance/${BENCHMARK_FILE})
    add_dependencies(${BENCHMARK_TARGET} ${PROTO_DEPENDENCIES})
    target_include_directories(${BENCHMARK_TARGET} PUBLIC ${rapidjson})
    target_link_libraries(${BENCHMARK_TARGET} ${LINKLIBS} cppbenchmark)
    set_target_properties(${BENCHMARK_TARGET} PROPERTIES FOLDER performance)
    list(APPEND INSTALL_TARGETS ${BENCHMARK_TARGET})
    list(APPEND INSTALL_TARGETS_PDB ${BENCHMARK_TARGET})
  endforeach()

  # Tests
  file(GLOB TESTS_SOURCE_FILES "tests/*.cpp")
  set_source_files_properties(${TESTS_SOURCE_FILES} PROPERTIES COMPILE_FLAGS "${PEDANTIC_COMPILE_FLAGS}")
  add_executable(fbe-tests ${Catch2} ${TESTS_SOURCE_FILES} ${PROTO_FILES})
  add_dependencies(fbe-tests ${PROTO_DEPENDENCIES})
  target_include_directories(fbe-tests PUBLIC ${rapidjson} PRIVATE ${Catch2})
  target_link_libraries(fbe-tests ${LINKLIBS})
  set_target_properties(fbe-tests PROPERTIES FOLDER tests)
  list(APPEND INSTALL_TARGETS fbe-tests)
  list(APPEND INSTALL_TARGETS_PDB fbe-tests)

  # CTest
  enable_testing()
  add_test(fbe-tests fbe-tests --durations yes --order lex)

  # Install
  install(TARGETS ${INSTALL_TARGETS}
    RUNTIME DESTINATION "${PROJECT_SOURCE_DIR}/bin"
    LIBRARY DESTINATION "${PROJECT_SOURCE_DIR}/bin"
    ARCHIVE DESTINATION "${PROJECT_SOURCE_DIR}/bin")

  # Install *.pdb files
  if(MSVC)
    foreach(INSTALL_TARGET_PDB ${INSTALL_TARGETS_PDB})
      install(FILES $<TARGET_PDB_FILE:${INSTALL_TARGET_PDB}> DESTINATION "${PROJECT_SOURCE_DIR}/bin")
    endforeach()
  endif()

endif()
