// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Simple-KeychainSwift",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Simple-KeychainSwift", type: .dynamic, targets: ["Simple-KeychainSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Simple-KeychainSwift", dependencies: [], path: "Simple-KeychainSwift")
    ]
)
