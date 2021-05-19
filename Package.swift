// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Glow",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "Glow", targets: ["Glow"]),
    ],
    targets: [
        .target(
            name: "Glow",
            dependencies: []
        ),
        .testTarget(
            name: "GlowTests",
            dependencies: ["Glow"]
        ),
    ]
)
