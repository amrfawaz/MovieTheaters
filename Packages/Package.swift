// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppConfigurations",
            targets: ["AppConfigurations"]),
        .library(
            name: "CoreInterface",
            targets: ["CoreInterface"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Packages",
            targets: ["Packages"]),
        .library(
            name: "MoviesList",
            targets: ["MoviesList"])
    ],
    targets: [
        .target(
            name: "AppConfigurations",
            dependencies: []),
        .target(
            name: "CoreInterface",
            dependencies: []),
        .target(
            name: "Networking",
            dependencies: []),
        .target(
            name: "MoviesList",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking"
            ]),
        .target(
            name: "MovieDetails",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking"
            ]),

        .target(
            name: "Packages"),
        .testTarget(
            name: "PackagesTests",
            dependencies: ["Packages"]),
    ]
)
