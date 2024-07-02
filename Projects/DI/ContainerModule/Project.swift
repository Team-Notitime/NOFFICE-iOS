import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    name: "Container",
    dependencies: [
        .external(name: "Swinject")
    ]
)
