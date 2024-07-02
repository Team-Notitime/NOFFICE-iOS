import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    name: "Signup",
    dependencies: [
        .feature(.signup)
    ]
)
