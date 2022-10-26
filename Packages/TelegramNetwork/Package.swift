// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TelegramNetwork",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "TelegramNetwork",
            targets: ["TelegramNetwork"]),
    ],
    dependencies: [
        .package(path: "../SSignalKit")
    ],
    targets: [
        .target(
            name: "TelegramNetwork",
            dependencies: [
                .product(name: "SwiftSignalKit", package: "SSignalKit")
            ]),
        .testTarget(
            name: "TelegramNetworkTests",
            dependencies: ["TelegramNetwork"]),
    ]
)
