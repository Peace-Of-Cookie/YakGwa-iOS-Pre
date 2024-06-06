// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MakeYakgwaScene",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MakeYakgwaScene",
            targets: ["MakeYakgwaScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./Common"),
        .package(path: "./Network"),
        .package(path: "./Util"),
        .package(path: "./YakgwaDetailScene")
    ],
    targets: [
        .target(
            name: "MakeYakgwaScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "Common", package: "Common"),
                .product(name: "Network", package: "Network"),
                .product(name: "Util", package: "Util"),
                .product(name: "YakgwaDetailScene", package: "YakgwaDetailScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "MakeYakgwaSceneTests",
            dependencies: ["MakeYakgwaScene"]),
    ]
)
