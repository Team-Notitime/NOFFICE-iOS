import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    name: "My",
    dependencies: [
        .feature(.my)
    ]
)
