// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dependencies",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Dependencies"),
        .testTarget(
            name: "DependenciesTests",
            dependencies: ["Dependencies"]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/groue/GRDB.swift", from: "6.15.0")
]
package.targets = [
    .target(name: "Dependencies",
        dependencies: [
            .product(name: "GRDB", package: "GRDB.swift")
        ]
    )
]
package.platforms = [
    .iOS("11.0"),
    .macOS("10.13"),
    .tvOS("11.0"),
    .watchOS("4.0")
]
