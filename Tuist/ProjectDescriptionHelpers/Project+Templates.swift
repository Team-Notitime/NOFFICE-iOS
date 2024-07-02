import ProjectDescription

extension Project {
    public static let deployTarget = 16.0
    
    public static func featureFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Feature",
            targets: [
                .target(
                    name: "\(name)Feature",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.\(name).feature",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    resources: ["Resources/**",],
                    dependencies: [
                        .external(name: "RxSwift"),
                        .external(name: "SnapKit"),
                        .external(name: "Then"),
                    ] + dependencies
                )
            ]
        )
    }
    
    public static func exampleApp(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Example",
            targets: [
                .target(
                    name: "\(name)Example",
                    destinations: [.iPhone],
                    product: .app,
                    bundleId: "com.notice.\(name).example",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    infoPlist: .file(path: "Sources/Info.plist"),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
    
    public static func domainFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Domain",
            targets: [
                .target(
                    name: "\(name)Domain",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.\(name).domain",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
    
    public static func dataInterface(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)DataInterface",
            targets: [
                .target(
                    name: "\(name)DataInterface",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.\(name).repository.interface",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
    
    public static func dataFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)Data",
            targets: [
                .target(
                    name: "\(name)Data",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.\(name).data",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                ),
                .target(
                    name: "\(name)DataMock",
                    destinations: .iOS,
                    product: .dynamicLibrary,
                    bundleId: "com.notice.\(name).data.mock",
                    sources: ["Mock/**"]
                )
            ]
        )
    }
    
    public static func diFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        return Project(
            name: "\(name)",
            targets: [
                .target(
                    name: "\(name)",
                    destinations: [.iPhone],
                    product: .framework,
                    bundleId: "com.notice.\(name).di",
                    deploymentTargets: .iOS("\(Project.deployTarget)"),
                    infoPlist: .extendingDefault(with: dataInfoPlist),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}

// MARK: - Info.plist

extension Project {
    static let dataInfoPlist: [String: Plist.Value] = [
        "API_BASE_URL": "http://$(API_BASE_URL)",
    ]
}
