import Foundation
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
    public static func makeAppScheme(_ appName: String) -> Self {
        return [
            .scheme(
                name: "\(appName)(\(Scheme.SchemeType.dev.rawValue))",
                hidden: false,
                buildAction: .buildAction(
                    targets: [.target(appName)],
                    preActions: []
                ),
                testAction: .targets([], configuration: Scheme.SchemeType.dev.name),
                runAction: .runAction(configuration: Scheme.SchemeType.dev.name),
                archiveAction: .archiveAction(configuration: Scheme.SchemeType.dev.name),
                profileAction: .profileAction(configuration: Scheme.SchemeType.dev.name),
                analyzeAction: .analyzeAction(configuration: Scheme.SchemeType.dev.name)
            ),
            .scheme(
                name: "\(appName)(\(Scheme.SchemeType.prod.rawValue))",
                hidden: false,
                buildAction: .buildAction(targets: [.target(appName)]),
                testAction: .targets([], configuration: Scheme.SchemeType.prod.name),
                runAction: .runAction(configuration: Scheme.SchemeType.prod.name),
                archiveAction: .archiveAction(configuration: Scheme.SchemeType.prod.name),
                profileAction: .profileAction(configuration: Scheme.SchemeType.prod.name),
                analyzeAction: .analyzeAction(configuration: Scheme.SchemeType.prod.name)
            )
        ]
    }
    
    public static func makeBaseScheme(_ moduleName: String) -> Self {
        return [
            .scheme(
                name: "\(moduleName)(\(Scheme.SchemeType.dev.rawValue))",
                hidden: true,
                buildAction: .buildAction(targets: []),
                testAction: .targets([], configuration: Scheme.SchemeType.dev.name),
                runAction: .runAction(configuration: Scheme.SchemeType.dev.name),
                archiveAction: .archiveAction(configuration: Scheme.SchemeType.dev.name),
                profileAction: .profileAction(configuration: Scheme.SchemeType.dev.name),
                analyzeAction: .analyzeAction(configuration: Scheme.SchemeType.dev.name)
            ),
            .scheme(
                name: "\(moduleName)(\(Scheme.SchemeType.prod.rawValue))",
                hidden: true,
                buildAction: .buildAction(targets: []),
                testAction: .targets([], configuration: Scheme.SchemeType.prod.name),
                runAction: .runAction(configuration: Scheme.SchemeType.prod.name),
                archiveAction: .archiveAction(configuration: Scheme.SchemeType.prod.name),
                profileAction: .profileAction(configuration: Scheme.SchemeType.prod.name),
                analyzeAction: .analyzeAction(configuration: Scheme.SchemeType.prod.name)
            )
        ]
    }
    
    private static var swiftlintAction: ExecutionAction {
        return .executionAction(scriptText:
            """
            echo "Run script"
            ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
            ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
            """
        )
    }
}
