import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomainModule(
    .common,
    dependencies: [
        .dataInterface(.sample)
    ]
)
