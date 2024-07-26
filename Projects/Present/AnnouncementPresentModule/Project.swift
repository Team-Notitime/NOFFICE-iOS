import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .announcement,
    dependencies: [
        .entity(.announcement)
    ]
)
