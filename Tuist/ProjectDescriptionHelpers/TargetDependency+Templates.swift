import ProjectDescription

public extension TargetDependency {
    static func present(
        _ target: Module.Present
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Present",
            path: .relativeToRoot("Projects/Present/\(target.rawValue)PresentModule")
        )
    }
    
    static func ui(
        _ target: Module.UI
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)",
            path: .relativeToRoot("Projects/UI/\(target.rawValue)UIModule")
        )
    }
    
    static func usecase(
        _ target: Module.Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Usecase",
            path: .relativeToRoot("Projects/Domain/\(target.rawValue)DomainModule")
        )
    }
    
    static func entity(
        _ target: Module.Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.rawValue)Entity",
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
            path: .relativeToRoot("Projects/DI/\(target.rawValue)DIModule")
        )
    }
    
    static func thirdParty(
        _ target: Module.ThirdParty
    ) -> TargetDependency {
        return .external(name: target.rawValue)
    }
}
