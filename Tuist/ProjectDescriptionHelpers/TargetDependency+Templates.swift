import ProjectDescription

public extension TargetDependency {
    static func feature(
        _ target: Feature
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Feature",
            path: .relativeToRoot("Projects/Feature/\(target.rawValue)Feature")
        )
    }
    
    static func domain(
        _ target: Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Domain",
            path: .relativeToRoot("Projects/Feature/\(target.rawValue)Domain")
        )
    }
    
    static func dataInterface(
        _ target: DataInterface
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)DataInterface",
            path: .relativeToRoot("Projects/DataInterface/\(target.rawValue)DataInterface")
        )
    }
    
    static func data(
        _ target: Data
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Data",
            path: .relativeToRoot("Projects/Data/\(target.rawValue)Data")
        )
    }
}
