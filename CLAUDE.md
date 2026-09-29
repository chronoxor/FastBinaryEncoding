# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Fast Binary Encoding (FBE) is a schema compiler. `fbec` parses `.fbe` domain-model files (packages, enums, flags, structs, requests/responses) and generates serialization code (FBE binary, "final" binary, JSON, sender/receiver protocol) for C++, C#, Go, Java, JavaScript, Kotlin, Python, Ruby and Swift. Format spec: `documents/FBE.md`.

## Setup and build

Dependencies in `modules/`, `build/` (scripts) and `cmake/` are git-links managed by [gil](https://github.com/chronoxor/gil) (see `.gitlinks`), not git submodules. After cloning: `pip3 install gil && gil update`. Also needs cmake >= 3.20, flex and bison (on Linux `binutils-dev uuid-dev flex bison`; on macOS put Homebrew bison on `PATH`; on Windows `choco install winflexbison3`).

```sh
cd build && ./unix.sh        # Linux/macOS: generate, build, test, install (build\vs.bat / mingw.bat on Windows)
```

The `build/` scripts (a separate repo, see `build/CLAUDE.md`) generate into `temp/`, and install binaries into `bin/`. To build directly:

```sh
cmake -S . -B temp && cmake --build temp -j4
./bin/fbe-tests "<test name or [tag]>"    # run a single Catch2 test (after install); or run temp/fbe-tests
ctest --test-dir temp -V                  # full suite (the single ctest entry runs fbe-tests)
```

Targets: `fbec` (compiler), `proto` (library of generated C++), `fbe-tests`, `fbe-example-*` (from `examples/*.cpp`), `fbe-performance-*` (from `performance/*.cpp`). Sources are picked up by glob, so re-run cmake after adding files.

## Architecture

- **Front end**: `source/fbe.l` (flex) and `source/fbe.y` (bison) build an AST defined in `include/fbe.h` (`Package`, `Struct`, `Enum`, `Flags`, ...). The lexer and parser outputs `source/fbe-lexer.cpp` and `source/fbe-parser.cpp` are generated during the build. `source/fbe.cpp` is `main` and handles CLI options (`--cpp`, `--csharp`, `--go`, `--java`, `--javascript`, `--kotlin`, `--python`, `--ruby`, `--swift`, `--final`, `--json`, `--proto`, `--input`, `--output`).
- **Back ends**: one `Generator` subclass per language (`include/generator_<lang>.h`, `source/generator_<lang>.cpp`), all deriving from `include/generator.h`, which offers the buffered `Write*/Indent/Store` helpers. Each generator emits its language's code as large embedded string templates, so the files are very large (up to 12k lines). Feature flags (`--final`, `--json`, `--proto`) enable extra generated sections. Adding a schema feature means changing the grammar, the AST and every generator.
- **Generated output is committed**: `proto/*.fbe` are the sample and test schemas. A CMake custom command regenerates them into `proto/` (C++) and into every `projects/<Lang>/...` directory (paths listed in `CMakeLists.txt`) using the just-built `fbec`. `proto/*.h|*.cpp|*.inl` and the `proto`/`Proto` directories under `projects/` are generated, so change the generator or the `.fbe` file and never edit them by hand.
- **Tests and samples**: C++ tests are Catch2 in `tests/` and use the `proto` library. Each `projects/<Lang>/` folder holds its own native tests, examples, benchmarks and a project file that exercises the generated code in that language. Those are built and run with each language's own toolchain, not through CMake.
- `.github/workflows/` has one build workflow per platform and compiler, plus doxygen. They run `gil update` and then the build scripts.
