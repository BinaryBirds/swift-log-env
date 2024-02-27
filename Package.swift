// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "swift-log-env",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "SwiftLogEnv", targets: ["SwiftLogEnv"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftLogEnv",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        )
    ]
)
