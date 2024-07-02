import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomainModule(
    name: "Common",
    dependencies: [
        .dataInterface(.sample)
    ]
)
