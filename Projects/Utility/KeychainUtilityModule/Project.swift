import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeUtilityModule(
    .keychain,
    dependencies: [] + Module.Domain.allCases.map {
        .entity($0)
    }
)
