import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .newAnnouncement,
    dependencies: [
        .usecase(.announcement),
        .entity(.announcement)
    ]
)
