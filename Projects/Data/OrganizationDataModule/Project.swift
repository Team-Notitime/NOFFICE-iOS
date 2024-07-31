import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .organization,
    dependencies: [
        .data(.common),
        .entity(.organization)
    ]
)
