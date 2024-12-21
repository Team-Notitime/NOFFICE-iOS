import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .announcement,
    dependencies: [
        .entity(.main),
        .dataInterface(.announcement),
        .data(.common)
    ]
)
