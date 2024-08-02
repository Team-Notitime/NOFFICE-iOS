import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .router,
    dependencies: [] + Module.Domain.allCases.map {
        .entity($0)
    }
)
