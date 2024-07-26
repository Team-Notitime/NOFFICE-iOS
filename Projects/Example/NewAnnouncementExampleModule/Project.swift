import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .newAnnouncement,
    dependencies: [
        .present(.newAnnouncement)
    ]
)
