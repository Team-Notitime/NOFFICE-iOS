import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .organization,
    dependencies: [
        .feature(.organization)
    ]
)
