import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .sample,
    dependencies: [
        .entity(.common)
    ]
)
