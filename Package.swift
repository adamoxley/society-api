// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "society-api",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "Society", targets: ["Society"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.25.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.1.0")
    ],
    targets: [
        .target(name: "Society", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Vapor", package: "vapor")
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "Society"),
        ]),
        .testTarget(name: "SocietyTests", dependencies: [
            .target(name: "Society"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
