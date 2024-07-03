// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]),
    ],
    dependencies: [
        .package(path: "./DesignSystem"),
        .package(path: "./Common"),
        .package(path: "./Network"),
        .package(path: "./Util")
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Common", package: "Common"),
                .product(name: "Network", package: "Network"),
                .product(name: "Util", package: "Util")
            ]
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"]),
    ]
)
