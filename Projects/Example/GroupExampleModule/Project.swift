import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    name: "Group",
    dependencies: [
        .feature(.group)
    ]
)
