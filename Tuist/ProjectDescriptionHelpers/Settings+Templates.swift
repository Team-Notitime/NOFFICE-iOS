import ProjectDescription

extension Settings {
    public enum SettingsType {
        /// 루트 앱에 사용
        case app
        /// Present 모듈에 사용
        case present
        /// Example 모듈에 사용
        case example(bundleIdentifier: String)
        /// Data 모듈에 사용
        case data
        /// 그 외 모듈에 사용
        case `default`
        
        public var name: ConfigurationName {
            switch self {
            case .app: "app"
            case .present: "present"
            case .example(_): "example"
            case .data: "data"
            case .default: "default"
            }
        }
    }
    
    public static func settings(_ type: SettingsType) -> Settings {
        switch type {
        case .app:
            let devSettings: SettingsDictionary = [
                "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
                "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
                "CODE_SIGN_STYLE": "Manual",
                "DEVELOPMENT_TEAM": "N8MX74Y447",
                "PROVISIONING_PROFILE_SPECIFIER": "match Development notitime.noffice.app",
                "OTHER_SWIFT_FLAGS": [
                    "-D DEV"
                ],
                "OTHER_LDFLAGS": [
                    "-Xlinker", // For InjectIII
                    "-interposable", // For InjectIII
                    "$(inherited) -ObjC" // For InjectIII, SkeletonView
                ]
            ]
            
            let prodSettings: SettingsDictionary = [
                "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
                "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
                "CODE_SIGN_STYLE": "Manual",
                "DEVELOPMENT_TEAM": "N8MX74Y447",
                "PROVISIONING_PROFILE_SPECIFIER": "match AppStore notitime.noffice.app",
                "OTHER_SWIFT_FLAGS": [
                    "-D PROD"
                ],
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC" // SkeletonView
                ]
            ]
            return .settings(
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: devSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: prodSettings)
                ],
                defaultSettings: .recommended
            )
        case .present:
            let devSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D DEV"
                ],
                "OTHER_LDFLAGS": [
                    "-Xlinker", // For InjectIII
                    "-interposable", // For InjectIII
                    "$(inherited) -ObjC" // For InjectIII, SkeletonView
                ]
            ]
            
            let prodSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D PROD"
                ],
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC" // SkeletonView
                ]
            ]
            
            return .settings(
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: devSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: prodSettings)
                ],
                defaultSettings: .recommended
            )
        case let .example(bundleIdentifier):
            let devSettings: SettingsDictionary = [
                "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
                "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
                "CODE_SIGN_STYLE": "Manual",
                "DEVELOPMENT_TEAM": "N8MX74Y447",
                "PROVISIONING_PROFILE_SPECIFIER": "match Development \(bundleIdentifier)",
                "OTHER_SWIFT_FLAGS": [
                    "-D DEV"
                ],
                "OTHER_LDFLAGS": [
                    "-Xlinker", // For InjectIII
                    "-interposable", // For InjectIII
                    "$(inherited) -ObjC" // For InjectIII, SkeletonView
                ]
            ]
            
            let prodSettings: SettingsDictionary = [
                "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
                "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
                "CODE_SIGN_STYLE": "Manual",
                "DEVELOPMENT_TEAM": "N8MX74Y447",
                "PROVISIONING_PROFILE_SPECIFIER": "match AppStore \(bundleIdentifier)",
                "OTHER_SWIFT_FLAGS": [
                    "-D PROD"
                ],
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC" // SkeletonView
                ]
            ]
            
            return .settings(
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: devSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: prodSettings)
                ],
                defaultSettings: .recommended
            )
        case .data:
            let devSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D DEV"
                ]
            ]
            
            let prodSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D PROD"
                ]
            ]
            
            return .settings(
                configurations: [
                    .debug(
                        name: Scheme.SchemeType.dev.name,
                        settings: devSettings,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    ),
                    .release(
                        name: Scheme.SchemeType.prod.name,
                        settings: prodSettings,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    )
                ],
                defaultSettings: .recommended
            )
        case .`default`:
            let devSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D DEV"
                ]
            ]
            
            let prodSettings: SettingsDictionary = [
                "OTHER_SWIFT_FLAGS": [
                    "-D PROD"
                ]
            ]
            
            return .settings(
                configurations: [
                    .debug(
                        name: Scheme.SchemeType.dev.name,
                        settings: devSettings
                    ),
                    .release(
                        name: Scheme.SchemeType.prod.name,
                        settings: prodSettings
                    ),
                ],
                defaultSettings: .recommended
            )
        }
    }
}
