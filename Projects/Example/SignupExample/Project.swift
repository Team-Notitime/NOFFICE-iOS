import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.exampleApp(
    name: "Signup",
    dependencies: [
        .feature(.signup)
    ]
)
