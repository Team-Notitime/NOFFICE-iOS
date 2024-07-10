import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        .dataInterface(.sample),
        .data(.sample),
        .external(name: "Swinject")
    ]
)
