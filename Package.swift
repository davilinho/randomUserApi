// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "RandomUserApi",
    platforms: [
        .macOS(.v12),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "RandomUserApi",
            targets: ["RandomUserApi"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.10.1")
    ],
    targets: [
        .target(
            name: "RandomUserApi",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "RandomUserApiTests",
            dependencies: [
                "RandomUserApi",
                "ViewInspector"
            ],
            path: "Tests"
        )
    ]
)
