// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokemonSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "PokemonSDK",
            targets: ["PokemonSDK"]),
    ],
    targets: [
        .binaryTarget(name: "PokemonSDK", url: "https://github.com/amolpimpare/PokemonSDK/blob/main/PokemonSDK.xcframework-1.0.0.zip", checksum: "b40cc5d0298ee82ff9d596b482657f046987296bf8cf90afeaae49ce1c2c145e")
    ]
)
