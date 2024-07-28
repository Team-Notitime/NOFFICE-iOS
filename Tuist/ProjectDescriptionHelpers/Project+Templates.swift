import ProjectDescription

extension Project {
    public static let deployTarget = 16.0
    public static let bundleId = "notitime.noffice"
    
    public static func makeMainApp(
        _ target: Module.MainApp,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.name)",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)",
                    product: .app,
                    bundleId: "\(bundleId).app",
                    infoPlist: .file(path: "\(target.rawValue)/Sources/Info.plist"),
                    dependencies: dependencies + uiDependencies
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
    
    public static func makePresentModule(
        _ target: Module.Present,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.rawValue)PresentModule",
            settings: .settings(.view),
            targets: [
                makeTarget(
                    name: "\(target.rawValue)Present",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).present",
                    infoPlist: .default,
                    dependencies: [
                        .ui(.designSystem),
                        .ui(.assets),
                        .di(.router),
                    ] + dependencies + uiDependencies + presentDependencies
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
                    bundleId: "\(bundleId).\(target.bundleIdenifier).app",
                    infoPlist: .file(path: "\(target.rawValue)App/Sources/Info.plist"),
                    dependencies: [
                        .target(name: "\(target.rawValue)"),
                    ] + dependencies + uiDependencies
                ),
                makeTarget(
                    name: "\(target.rawValue)",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier)",
                    infoPlist: .file(path: "\(target.rawValue)/Sources/Info.plist"),
                    dependencies: dependencies + uiDependencies
                )
            ],
            schemes: .base,
            resourceSynthesizers: [
                .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
            ]
        )
    }
    
    public static func makeExampleModule(
        _ target: Module.Present,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.name)ExampleModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)Example",
                    product: .app,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).example",
                    infoPlist: .file(path: "\(target.name)Example/Sources/Info.plist"),
                    dependencies: [
                        .di(.router)
                    ] + dependencies + uiDependencies
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
            name: "\(target.name)DomainModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)Usecase",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).domain",
                    dependencies: [
                        .di(.container),
                        .target(name: "\(target.name)Entity"),
                        .thirdParty(.rxSwift)
                    ] + dependencies
                ),
                makeTarget(
                    name: "\(target.name)Entity",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).entity",
                    dependencies: []
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
            name: "\(target.name)DataInterfaceModule",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)DataInterface",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).datainterface",
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
            name: "\(target.name)DataModule",
            settings: .settings(.data),
            targets: [
                makeTarget(
                    name: "\(target.name)Data",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).data",
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    dependencies: dependencies
                )
            ],
            schemes: .base
        )
    }
    
    public static func makeDIModule(
        _ target: Module.DI,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(target.name)Module",
            settings: .settings(.base),
            targets: [
                makeTarget(
                    name: "\(target.name)",
                    product: .framework,
                    bundleId: "\(bundleId).\(target.bundleIdenifier).di",
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
            resources: .resources(
                ["\(name)/Resources/**"],
                privacyManifest: .privacyManifest(
                    tracking: false,
                    trackingDomains: [],
                    collectedDataTypes: [
                        [
                            "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeName",
                            "NSPrivacyCollectedDataTypeLinked": false,
                            "NSPrivacyCollectedDataTypeTracking": false,
                            "NSPrivacyCollectedDataTypePurposes": [
                                "NSPrivacyCollectedDataTypePurposeAppFunctionality",
                            ],
                        ],
                    ],
                    accessedApiTypes: [
                        [
                            "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults",
                            "NSPrivacyAccessedAPITypeReasons": [
                                "CA92.1",
                            ],
                        ],
                    ]
                )
            ),
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
    static let presentDependencies : [TargetDependency] = [
        .thirdParty(.reactorKit),
        .thirdParty(.swinject),
        .thirdParty(.kingfisher),
        .thirdParty(.skeletonView)
    ]
    
    static let uiDependencies: [TargetDependency] = [
        .thirdParty(.rxSwift),
        .thirdParty(.rxCocoa),
        .thirdParty(.rxGesture),
        .thirdParty(.snapKit),
        .thirdParty(.then),
        
    ]
    
    static let dataDependencies: [TargetDependency] = [
        .thirdParty(.alamofire),
        .thirdParty(.rxSwift)
    ]
}
