import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeUIModule(
    .designSystem,
    dependencies: [
        .ui(.assets)
    ]
)
