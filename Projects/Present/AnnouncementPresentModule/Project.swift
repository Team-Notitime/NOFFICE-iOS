import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .announcement,
    dependencies: [
        .usecase(.announcement),
        .entity(.announcement)
    ]
)
