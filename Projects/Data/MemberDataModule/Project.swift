import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .member,
    dependencies: [.dataInterface(.member)]
)
