import ProjectDescription

extension Project {
    public static let deployTarget = 16.0
    public static let bundleId = "com.notice"
    
    public static func makeMainApp( _ target: Module.MainApp) -> Project {
        return Project(
            name: "\(target.name)",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)",
                    product: .app,
                    bundleId: "\(bundleId).app",
                    infoPlist: .file(path: "\(target.rawValue)/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: [
                        .feature(.home),
                        .feature(.organization),
                        .feature(.mypage),
                        .feature(.signup),
                        .di(.router),
                    ] + uiDependencies
                ),
                makeTarget(
                    name: "\(target.rawValue)Tests",
                    product: .unitTests,
                    bundleId: "\(bundleId).app.tests",
                    dependencies: [.target(name: "Noffice")]
                )
            ],
            schemes: .base
        )
    }
    
    public static func makeFeatureModule(
        _ target: Module.Feature,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)FeatureModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)Feature",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).feature",
                    infoPlist: .default,
                    hasResource: true,
                    dependencies: dependencies + uiDependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeUIModule(
        _ target: Module.UI,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)Module",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)App",
                    product: .app,
                    bundleId: "\(bundleId).\(target.rawValue).app",
                    infoPlist: .file(path: "\(target.rawValue)App/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: [
                        .target(name: "\(target.rawValue)"),
                    ] + dependencies + uiDependencies
                ),
                makeTarget(
                    name: "\(target.rawValue)",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue)",
                    infoPlist: .file(path: "\(target.rawValue)/Sources/Info.plist"),
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
        _ target: Module.Feature,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)ExampleModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)Example",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).example",
                    infoPlist: .file(path: "\(target.rawValue)Example/Sources/Info.plist"),
                    hasResource: true,
                    dependencies: dependencies + uiDependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDomainModule(
        _ target: Module.Domain,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)DomainModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)Usecase",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).domain",
                    dependencies: [
                        .di(.container),
                        .target(name: "\(target.rawValue)Entity")
                    ] + dependencies
                ),
                makeTarget(
                    name: "\(target.rawValue)Entity",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).domain",
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDataInterfaceModule(
        _ target: Module.DataInterface,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)DataInterfaceModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)DataInterface",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).datainterface",
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDataModule(
        _ target: Module.Data,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)DataModule",
            settings: .settings(.data),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)Data",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).data",
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    dependencies: dependencies
                ),
                makeTarget(
                    name: "\(target.rawValue)DataMock",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).data.mock",
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    dependencies: dependencies
                ),
            ],
            schemes: .base
        )
    }
    
    public static func makeDIModule(
        _ target: Module.DI,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)Module",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.rawValue).di",
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

