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
    public static var base: [Scheme] {
        return [
            .scheme(
                name: "\(Scheme.SchemeType.dev.rawValue)",
                buildAction: .buildAction(
                    targets: ["Noffice"],
                    preActions: [swiftlintAction]
                )
            ),
            .scheme(
                name: "\(Scheme.SchemeType.prod.rawValue)"
            )
        ]
    }
    
    public static var swiftlintAction: ExecutionAction {
        return .executionAction(scriptText:
            """
            echo "Run script"
            ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
            ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
            """
        )
    }
}
