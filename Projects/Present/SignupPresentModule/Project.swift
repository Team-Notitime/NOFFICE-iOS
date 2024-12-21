import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .signup,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
