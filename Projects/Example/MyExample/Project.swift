import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.exampleApp(
    name: "My",
    dependencies: [
        .feature(name: "Signup")
    ]
)
