import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.exampleApp(
    name: "Home",
    dependencies: [
        .feature(.home)
    ]
)
