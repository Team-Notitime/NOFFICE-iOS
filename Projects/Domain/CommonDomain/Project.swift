import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.domainFramework(
    name: "Common",
    dependencies: [
        .dataInterface(.sample)
    ]
)
