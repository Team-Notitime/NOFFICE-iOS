import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DesignSystem",
    targets: [
        .target(
            name: "DesignSystemExampleApp",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.notice.designsystem.app",
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            infoPlist: .file(path: "Sources/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .target(name: "DesignSystem"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "RxSwift"),
            ]
        ),
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.notice.designsystem",
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            sources: ["Core/Sources/**"],
            resources: ["Core/Resources/**"],
            dependencies: [
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "RxSwift"),
            ]
        ),
    ],
    resourceSynthesizers: [
        .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
    ]
)
