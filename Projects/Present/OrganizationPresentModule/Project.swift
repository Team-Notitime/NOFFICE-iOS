import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .organization,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
