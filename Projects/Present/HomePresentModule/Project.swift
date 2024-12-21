import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .home,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
