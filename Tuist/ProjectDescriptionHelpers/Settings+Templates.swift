import ProjectDescription

extension Settings {
    public enum SettingsType: String {
        case base
        case view
        case data
        
        public var name: ConfigurationName {
            return ConfigurationName.configuration(self.rawValue)
        }
    }
    
    public static func settings(_ type: SettingsType) -> Settings {
        switch type {
        case .base:
            
            return .settings(
                base: baseSettings,
                configurations: [
                    .debug(
                        name: Scheme.SchemeType.dev.name,
                        settings: devSettings.merging(baseSettings) {
                            _, new in new
                        }
                    ),
                    .release(
                        name: Scheme.SchemeType.prod.name,
                        settings: prodSettings.merging(baseSettings) {
                            _, new in new
                        }
                    ),
                ],
                defaultSettings: .recommended
            )
        case .view:
            // Merge base settings
            let viewSettings = viewSettings
                .merging(baseSettings) { (_, new) in new }
                .merging(devSettings) { (_, new) in new }
            
            let prodSettings = prodViewSettings
                .merging(baseSettings) { (_, new) in new }
            
            return .settings(
                base: prodViewSettings,
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: viewSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: prodViewSettings)
                ],
                defaultSettings: .recommended
            )
        case .data:
            return .settings(
                configurations: [
                    .debug(
                        name: Scheme.SchemeType.dev.name,
                        settings: baseSettings,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    ),
                    .release(
                        name: Scheme.SchemeType.prod.name,
                        settings: baseSettings,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    )
                ],
                defaultSettings: .recommended
            )
        }
    }
}

// TODO: 스키마 정리 필ㅇ
extension Settings {
    // - Layer setting
    static let baseSettings: SettingsDictionary = [
        "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
        "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
        "CODE_SIGN_STYLE": "Manual"
    ]
    
    static let viewSettings: SettingsDictionary = [
        "OTHER_LDFLAGS": [
            "-Xlinker", // For InjectIII
            "-interposable", // For InjectIII
            "$(inherited) -ObjC" // For InjectIII, SkeletonView
        ]
    ]
    
    // - Scheme setting
    static let devSettings: SettingsDictionary = [
        "OTHER_SWIFT_FLAGS": [
            "-D DEV"
        ]
    ]
    
    static let prodSettings: SettingsDictionary = [
        "OTHER_SWIFT_FLAGS": [
            "-D PROD"
        ]
    ]
    
    static let prodViewSettings: SettingsDictionary = [
        "OTHER_LDFLAGS": [
            "$(inherited) -ObjC" // For SkeletonView
        ]
    ]
}
