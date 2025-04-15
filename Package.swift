// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "QappleRepository",
    platforms: [
        .macOS(.v15),
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "QappleRepository",
            targets: ["QappleRepository"]),
    ],
    targets: [
        .target(
            name: "QappleRepository"),
        .testTarget(
            name: "QappleRepositoryTests",
            dependencies: ["QappleRepository"]
        ),
    ]
)
