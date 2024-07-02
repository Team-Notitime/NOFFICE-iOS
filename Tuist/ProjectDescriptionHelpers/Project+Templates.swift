import ProjectDescription

extension Project {
    public static let deployTarget = 16.0
    public static let bundleId = "com.notice"
    
    public static func mainApp(name: String) -> Project {
        Project(
            name: "\(name)",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)",
                    destinations: [.iPhone],
                    product: .app,
                    bundleId: "\(bundleId).app",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .file(path: "Sources/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .feature(.home),
                        .feature(.group),
                        .feature(.my),
                        .feature(.signup),
                        .di(.router),
                    ] + uiDependencies
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundleId).app.tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    resources: [],
                    dependencies: [.target(name: "Noffice")]
                ),
            ],
            schemes: .base
        )
    }
    
    public static func featureFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Feature",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)Feature",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "\(bundleId).\(name).feature",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    resources: ["Resources/**",],
                    dependencies: [
                    ] + dependencies + uiDependencies
                )
            ],
            schemes: .base
        )
    }
    
    public static func uiFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)App",
                    destinations: [.iPhone],
                    product: .app,
                    bundleId: "com.notice.designsystem.app",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .file(path: "Sources/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .target(name: "DesignSystem"),
                    ] + dependencies + uiDependencies
                ),
                .target(
                    name: "\(name)",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.designsystem",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    sources: ["Core/Sources/**"],
                    resources: ["Core/Resources/**"],
                    dependencies: [
                    ] + dependencies + uiDependencies
                ),
            ],
            schemes: .base,
            resourceSynthesizers: [
                .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
            ]
        )
    }
    
    public static func exampleApp(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Example",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)Example",
                    destinations: [.iPhone],
                    product: .app,
                    bundleId: "\(bundleId).\(name).example",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .file(path: "Sources/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: dependencies
                )
            ],
            schemes: .base
        )
    }
    
    public static func domainFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Domain",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)Domain",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "\(bundleId).\(name).domain",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ],
            schemes: .base
        )
    }
    
    public static func dataInterface(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)DataInterface",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)DataInterface",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "\(bundleId).\(name).repository.interface",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ],
            schemes: .base
        )
    }
    
    public static func dataFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Data",
            settings: .settings(.data),
            targets: [
                .target(
                    name: "\(name)Data",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "\(bundleId).\(name).data",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                ),
                .target(
                    name: "\(name)DataMock",
                    destinations: .iOS,
                    product: .dynamicLibrary,
                    bundleId: "\(bundleId).\(name).data.mock",
                    sources: ["Mock/**"]
                )
            ],
            schemes: .base
        )
    }
    
    public static func diFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)",
            settings: .settings(.base),
            targets: [
                .target(
                    name: "\(name)",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "\(bundleId).\(name).di",
                    deploymentTargets: .iOS("\(deployTarget)"),
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ],
            schemes: .base
        )
    }
}



// MARK: - Info.plist

extension Project {
    static let dataInfoPlist: [String: Plist.Value] = [
        "API_BASE_URL": "$(API_BASE_URL)",
    ]
}

// MARK: - Dependencies {
extension Project {
    static let uiDependencies: [TargetDependency] = [
        .external(name: "RxSwift"),
        .external(name: "SnapKit"),
        .external(name: "Then"),
    ]
}
