import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .home,
    dependencies: [
        .feature(.home)
    ]
)
