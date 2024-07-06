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
            name: "Tabs",
            targets: ["Tabs"]),
        .library(
            name: "MoviesList",
            targets: ["MoviesList"]),
        .library(
            name: "MovieDetails",
            targets: ["MovieDetails"])
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
            name: "Tabs",
            dependencies: [
                "MoviesList"
            ]),
        .target(
            name: "MoviesList",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking",
                "MovieDetails"
            ]),
        .target(
            name: "MovieDetails",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking"
            ]),
    ]
)
