import ProjectDescription

public extension TargetDependency {
    static func present(
        _ target: Module.Present
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)Present",
            path: .relativeToRoot("Projects/Present/\(target.name)PresentModule")
        )
    }
    
    static func ui(
        _ target: Module.UI
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)",
            path: .relativeToRoot("Projects/UI/\(target.name)UIModule")
        )
    }
    
    static func usecase(
        _ target: Module.Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)Usecase",
            path: .relativeToRoot("Projects/Domain/\(target.name)DomainModule")
        )
    }
    
    static func entity(
        _ target: Module.Domain
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)Entity",
            path: .relativeToRoot("Projects/Domain/\(target.name)DomainModule")
        )
    }
    
    static func dataInterface(
        _ target: Module.DataInterface
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)DataInterface",
            path: .relativeToRoot("Projects/DataInterface/\(target.name)DataInterfaceModule")
        )
    }
    
    static func data(
        _ target: Module.Data
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)Data",
            path: .relativeToRoot("Projects/Data/\(target.name)DataModule")
        )
    }
    
    static func di(
        _ target: Module.DI
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)",
            path: .relativeToRoot("Projects/DI/\(target.name)DIModule")
        )
    }
    
    static func utility(
        _ target: Module.Utility
    ) -> TargetDependency {
        return .project(
            target: "\(target.name)",
            path: .relativeToRoot("Projects/Utility/\(target.name)UtilityModule")
        )
    }
    
    static func thirdParty(
        _ target: Module.ThirdParty
    ) -> TargetDependency {
        return .external(name: target.name)
    }
}
