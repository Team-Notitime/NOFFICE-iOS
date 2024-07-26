import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .announcement,
    dependencies: [
        .present(.announcement)
    ]
)
