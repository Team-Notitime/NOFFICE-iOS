import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .home,
    dependencies: [
        .entity(.todo)
    ]
)
