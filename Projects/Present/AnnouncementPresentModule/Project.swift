import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .announcement,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
