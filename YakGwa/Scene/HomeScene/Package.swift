// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HomeScene",
            targets: ["HomeScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./Common"),
        .package(path: "./Network"),
        .package(path: "./Util")
    ],
    targets: [
        .target(
            name: "HomeScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "Common", package: "Common"),
                .product(name: "Network", package: "Network"),
                .product(name: "Util", package: "Util")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "HomeSceneTests",
            dependencies: ["HomeScene"]),
    ]
)