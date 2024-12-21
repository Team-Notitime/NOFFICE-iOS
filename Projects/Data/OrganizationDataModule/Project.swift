import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .organization,
    dependencies: [
        .entity(.main),
        .dataInterface(.organization),
        .data(.common)
    ]
)
