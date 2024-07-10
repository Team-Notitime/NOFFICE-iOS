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
        switch type {
        case .base:
            return .settings(
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name),
                    .release(name: Scheme.SchemeType.prod.name)
                ],
                defaultSettings: .recommended
            )
        case .view:
            return settings(
                configurations: [
                    .debug(name: Scheme.SchemeType.dev.name, settings: [
                        "OTHER_LDFLAGS": ["-ObjC", "-Xlinker", "-interposable"]
                    ]),
                    .release(name: Scheme.SchemeType.prod.name)
                ],
                defaultSettings: .recommended
            )
        case .data:
            return .settings(
                configurations: [
                    .debug(
                        name: Scheme.SchemeType.dev.name,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    ),
                    .release(
                        name: Scheme.SchemeType.prod.name,
                        xcconfig: .relativeToRoot("Xcconfigs/DataConfig.xcconfig")
                    )
                ],
                defaultSettings: .recommended
            )
        }
    }
}
