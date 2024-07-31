import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .organization,
    dependencies: [
        .entity(.organization),
        .dataInterface(.organization),
        .data(.common)
    ]
)
