// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "ChronoxorFbe",
    swiftLanguageModes: [.v5],
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ChronoxorFbe",
            targets: ["ChronoxorFbe"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ChronoxorFbe",
            dependencies: [])
    ]
)
