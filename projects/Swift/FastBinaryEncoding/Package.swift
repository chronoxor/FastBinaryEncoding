// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FastBinaryEncoding",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FastBinaryEncoding",
            targets: ["FastBinaryEncoding"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
         .package(path: "../Chronoxor/Fbe"),
         .package(path: "../Chronoxor/Proto"),
         .package(path: "../Chronoxor/Protoex"),
         .package(path: "../Chronoxor/Test"),
         .package(path: "../Chronoxor/Enums"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FastBinaryEncoding",
            dependencies: ["ChronoxorFbe", "ChronoxorProto", "ChronoxorProtoex", "ChronoxorTest", "ChronoxorEnums"]),
        .testTarget(
            name: "Benchmark",
            dependencies: ["FastBinaryEncoding"]),
        .testTarget(
            name: "Tests",
            dependencies: ["FastBinaryEncoding"]),
        .testTarget(
            name: "Examples",
            dependencies: ["FastBinaryEncoding"]),
        
    ]
)
