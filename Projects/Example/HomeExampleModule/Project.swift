import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    name: "Home",
    dependencies: [
        .feature(.home)
    ]
)
