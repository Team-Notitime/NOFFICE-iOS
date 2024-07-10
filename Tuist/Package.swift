// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    // Customize the product types for specific package product
    // Default is .staticFramework
    // productTypes: ["Alamofire": .framework,]
    productTypes: [
        "Swinject": .framework,
        "RxSwift": .framework,
        "SnapKit": .framework,
        "Then": .framework,
        "Alamofire": .framework,
    ], 
    baseSettings: .settings(
        configurations: [
            .debug(name: "dev"),
            .release(name: "prod")
        ]
    )
)
#endif

let package = Package(
    name: "Noffice",
    dependencies: [
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.55.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0")
    ],
    targets: []
)
