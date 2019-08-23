// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "proto.MyLibrary",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "proto.MyLibrary",
            targets: ["proto.MyLibrary"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
         .package(path: "../chronoxor/fbe"),
         .package(path: "../chronoxor/proto"),
         .package(path: "../chronoxor/protoex"),
         .package(path: "../chronoxor/test"),
         .package(path: "../chronoxor/enums"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "proto.MyLibrary",
            dependencies: ["fbe", "proto", "protoex", "test", "enums"]),
        .testTarget(
            name: "Benchmark",
            dependencies: ["proto.MyLibrary"]),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: ["proto.MyLibrary"]),
        .testTarget(
            name: "Examples",
            dependencies: ["proto.MyLibrary"]),
        
    ]
)
