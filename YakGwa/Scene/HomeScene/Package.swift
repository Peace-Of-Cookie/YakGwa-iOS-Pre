// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeScene",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeScene",
            targets: ["HomeScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./MakeYakgwaScene")
    ],
    targets: [
        .target(
            name: "HomeScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "MakeYakgwaScene", package: "MakeYakgwaScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "HomeSceneTests",
            dependencies: ["HomeScene"]),
    ]
)
