// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    // Customize the product types for specific package product
    // Default is .staticFramework
    // productTypes: ["Alamofire": .framework,]
    productTypes: Dictionary(
        uniqueKeysWithValues: Module.ThirdParty.allCases
            .map { ($0.rawValue, .framework) }
    ),
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
        .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", from: "4.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/satoshi-takano/OpenGraph.git", from: "1.4.0"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.3.0"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(path: "../openapi-generator-cli")
    ],
    targets: []
)
