import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.diFramework(
    name: "Container",
    dependencies: [
        .external(name: "Swinject")
    ]
)
