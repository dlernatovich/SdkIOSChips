// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Package definition.
let package = Package(
    // Name for the package.
    name: "SdkChips",
    // Platforms.
    platforms: [.iOS(.v14)],
    // Products.
    products: [.library(name: "SdkChips", targets: ["SdkChips"])],
    // Targets.
    targets: [
        .target(name: "SdkChips"),
        .testTarget(
            name: "SdkChipsTests",
            dependencies: ["SdkChips"]
        ),
    ]
)
