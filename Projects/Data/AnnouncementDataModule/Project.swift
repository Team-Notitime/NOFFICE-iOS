import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .announcement,
    dependencies: [
        .entity(.announcement),
        .dataInterface(.announcement),
        .data(.common)
    ]
)
