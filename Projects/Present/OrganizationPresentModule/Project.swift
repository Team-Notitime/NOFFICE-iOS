import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .organization,
    dependencies: [
        .entity(.organization)
    ]
)
