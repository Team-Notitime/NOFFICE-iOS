import ProjectDescription

extension Project {
    public static let deployTarget = 16.0
    public static let bundleId = "com.notice"
    
    public static func makeMainApp(name: String) -> Project {
        return Project(
            name: "\(name)",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)",
                    product: .app,
                    bundleId: "\(bundleId).app",
                    infoPlist: .file(path: "\(name)/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: [
                        .feature(.home),
                        .feature(.group),
                        .feature(.my),
                        .feature(.signup),
                        .di(.router),
                    ] + uiDependencies
                ),
                makeTarget(
                    name: "\(name)Tests",
                    product: .unitTests,
                    bundleId: "\(bundleId).app.tests",
                    dependencies: [.target(name: "Noffice")]
                )
            ],
            schemes: .base
        )
    }
    
    public static func makeFeatureModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)FeatureModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)Feature",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).feature",
                    infoPlist: .default,
                    hasResource: true,
                    dependencies: dependencies + uiDependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeUIModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Module",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)App",
                    product: .app,
                    bundleId: "\(bundleId).\(name).app",
                    infoPlist: .file(path: "\(name)App/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: [
                        .target(name: "\(name)"),
                    ] + dependencies + uiDependencies
                ),
                makeTarget(
                    name: "\(name)",
                    product: .framework,
                    bundleId: "\(bundleId).\(name)",
                    infoPlist: .file(path: "\(name)/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: dependencies + uiDependencies
                ),
            ],
            schemes: .base,
            resourceSynthesizers: [
                .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
            ]
        )
    }
    
    public static func makeExampleModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)ExampleModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)Example",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).example",
                    infoPlist: .file(path: "\(name)Example/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: dependencies + uiDependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDomainModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)DomainModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)Domain",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).domain",
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDataInterfaceModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)DataInterfaceModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)DataInterface",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).datainterface",
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDataModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)DataModule",
            settings: .settings(.data),
            targets: [
                makeTarget(
                    name: "\(name)Data",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).data",
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    dependencies: dependencies
                ),
                makeTarget(
                    name: "\(name)DataMock",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).data.mock",
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDIModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Module",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(name)",
                    product: .framework,
                    bundleId: "\(bundleId).\(name).di",
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
}

// MARK: - Target
extension Project {
    static func makeTarget(
        name: String,
        product: Product,
        bundleId: String,
        infoPlist: InfoPlist? = .default,
        hasResource: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return .target(
            name: name,
            destinations: [.iPhone],
            product: product,
            bundleId: bundleId,
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            infoPlist: infoPlist,
            sources: ["\(name)/Sources/**"],
            resources: hasResource ? ["\(name)/Resources/**"] : nil,
            scripts: [.swiftlint],
            dependencies: dependencies
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
    
    static let dataDependencies: [TargetDependency] = [
//        .external(name: "Moya"),
//        .external(name: "RxSwift"),
    ]
}

