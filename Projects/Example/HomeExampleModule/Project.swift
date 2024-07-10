import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .home,
    dependencies: [
        .present(.home)
    ]
)
