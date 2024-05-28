// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginScene",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LoginScene",
            targets: ["LoginScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(
            url: "https://github.com/kakao/kakao-ios-sdk",
            .upToNextMajor(from: "2.0.0")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LoginScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "KakaoSDKAuth", package: "kakao-ios-sdk"),
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "LoginSceneTests",
            dependencies: ["LoginScene"]),
    ]
)
