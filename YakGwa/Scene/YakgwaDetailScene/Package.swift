// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YakgwaDetailScene",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "YakgwaDetailScene",
            targets: ["YakgwaDetailScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit")
    ],
    targets: [
        .target(
            name: "YakgwaDetailScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "YakgwaDetailSceneTests",
            dependencies: ["YakgwaDetailScene"]),
    ]
)
