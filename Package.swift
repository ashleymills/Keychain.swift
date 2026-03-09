// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Simple-KeychainSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Simple-KeychainSwift", targets: ["Simple-KeychainSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Simple-KeychainSwift", dependencies: [], path: "Simple-KeychainSwift")
    ]
)
