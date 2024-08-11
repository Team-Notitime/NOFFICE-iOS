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
        let baseSettings: SettingsDictionary = [
            "VERSIONING_SYSTEM": "apple-generic", // For fastlane auto increment build version
            "CURRENT_PROJECT_VERSION": "$(CURRENT_PROJECT_VERSION)",
            "CODE_SIGN_STYLE": "Manual"
        ]
        
        switch type {
        case .base:
            return .settings(
                base: baseSettings,
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: baseSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: baseSettings)
                ],
                defaultSettings: .recommended
            )
        case .view:
            var viewSettings: SettingsDictionary = [
                "OTHER_LDFLAGS": [
                    "-Xlinker", // For InjectIII
                    "-interposable", // For InjectIII
                    "$(inherited) -ObjC" // For InjectIII, SkeletonView
                ]
            ]
            
            // Merge base settings
            viewSettings.merge(baseSettings) { (_, new) in new }
            
            var prodViewSettings: SettingsDictionary = [
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC" // For SkeletonView
                ]
            ]
            // Merge base settings
            prodViewSettings.merge(baseSettings) { (_, new) in new }
            
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
