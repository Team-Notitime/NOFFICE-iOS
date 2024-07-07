import ProjectDescription

public extension TargetDependency {
    static func feature(
        _ target: Module.Feature
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Feature",
            path: .relativeToRoot("Projects/Feature/\(target.rawValue)FeatureModule")
        )
    }
    
    static func domain(
        _ target: Module.Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Domain",
            path: .relativeToRoot("Projects/Domain/\(target.rawValue)DomainModule")
        )
    }
    
    static func dataInterface(
        _ target: Module.DataInterface
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)DataInterface",
            path: .relativeToRoot("Projects/DataInterface/\(target.rawValue)DataInterfaceModule")
        )
    }
    
    static func data(
        _ target: Module.Data
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Data",
            path: .relativeToRoot("Projects/Data/\(target.rawValue)DataModule")
        )
    }
    
    static func di(
        _ target: Module.DI
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)",
            path: .relativeToRoot("Projects/DI/\(target.rawValue)Module")
        )
    }
}
