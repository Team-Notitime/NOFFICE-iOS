import ProjectDescription

public extension TargetDependency {
    static func feature(
        name: String
    ) -> TargetDependency {
        return .project(
            target: "\(name)Feature",
            path: .relativeToRoot("Projects/Feature/\(name)Feature")
        )
    }
    
    static func domain(
        name: String
    ) -> TargetDependency {
        return .project(
            target: "\(name)Domain",
            path: .relativeToRoot("Projects/Feature/\(name)Domain")
        )
    }
    
    static func dataInterface(
        name: String
    ) -> TargetDependency {
        return .project(
            target: "\(name)DataInterface",
            path: .relativeToRoot("Projects/DataInterface/\(name)DataInterface")
        )
    }
    
    static func data(
        name: String
    ) -> TargetDependency {
        return .project(
            target: "\(name)Data",
            path: .relativeToRoot("Projects/Data/\(name)Data")
        )
    }
}
