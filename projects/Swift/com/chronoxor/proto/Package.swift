// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "proto",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "proto",
            targets: ["proto"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../fbe"),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "proto",
            dependencies: ["fbe", ]),
    ]
)