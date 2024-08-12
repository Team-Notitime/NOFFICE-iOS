import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .member,
    dependencies: [
        .entity(.member),
        .dataInterface(.member)
    ]
)
