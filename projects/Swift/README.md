# Fast Binary Encoding for Swift

A single SwiftPM package. Generated models live in `Proto/<Module>/Source/Chronoxor<Module>`
(produced by `fbec --swift`, never edit by hand); tests are in `Tests/`.

## Xcode
Open this folder (or `Package.swift`) with Xcode 13+. Pick the `FastBinaryEncoding-Package` scheme
and press Cmd+U, or run an individual test class/method from the test navigator.

| Test target | Contents |
|---|---|
| `FastBinaryEncodingTests` | unit tests |
| `ExampleTests` | runnable examples |
| `BenchmarkTests` | performance benchmarks (`measure {}`); run in Release for real numbers |

## Command line
```sh
swift build
swift test                                   # everything
swift test --filter ExampleTests
swift test -c release --filter BenchmarkTests
```
