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
            dependencies: [],
            path: "AppConfigurations"
        ),
        .target(
            name: "CoreInterface",
            dependencies: [],
            path: "CoreInterface/Sources"
        ),
        .target(
            name: "Networking",
            dependencies: [],
            path: "Networking/Sources"
        ),
        .target(
            name: "Tabs",
            dependencies: [
                "MoviesList"
            ],
            path: "Tabs/Sources"
        ),
        .target(
            name: "MoviesList",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking",
                "MovieDetails"
            ],
            path: "MoviesList/Sources"
        ),
        .target(
            name: "MovieDetails",
            dependencies: [
                "CoreInterface",
                "AppConfigurations",
                "Networking"
            ],
            path: "MovieDetails/Sources"
        ),

        .testTarget(
            name: "MoviesListTests",
            dependencies: ["MoviesList"],
            path: "MoviesList/Tests"
        ),
        .testTarget(
            name: "MovieDetailsTests",
            dependencies: ["MovieDetails"],
            path: "MovieDetails/Tests"
        ),
    ]
)
