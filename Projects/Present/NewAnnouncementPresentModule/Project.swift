import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .newAnnouncement,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
