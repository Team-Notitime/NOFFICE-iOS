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
    
    /// The data module needs an `API URL`, so it has a special xcconfig file.
    /// Other modules have the same settings and don't require an xcconfig file. But it may be added in the future.
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
                    "-Xlinker",
                    "-interposable",
                    "$(inherited) -ObjC"
                ]
            ]
            viewSettings.merge(baseSettings) { (_, new) in new } // Merge base settings
            
            return .settings(
                base: viewSettings,
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: viewSettings),
                    .release(name: Scheme.SchemeType.prod.name, settings: baseSettings)
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
