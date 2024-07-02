import ProjectDescription

extension Scheme {
    public enum SchemeType: String {
        case dev
        case prod
        
        public var name: ConfigurationName {
            return ConfigurationName.configuration(self.rawValue)
        }
    }
}

extension Array where Element == Scheme {
    public static var base: [Scheme] {
        return [
            .scheme(name: "\(Scheme.SchemeType.dev.rawValue)",
                    buildAction: .buildAction(
                        targets: ["**"],
                        preActions: [swiftlintAction]
                    )
                   ),
            .scheme(name: "\(Scheme.SchemeType.prod.rawValue)")
        ]
    }
    
    public static var swiftlintAction: ExecutionAction {
        return .executionAction(scriptText:
            """
            if which swiftlint > /dev/null; then
                swiftlint
            else
                echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
            fi
            """
        )
    }
}
