import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .signup,
    dependencies: [
        .usecase(.member),
        .entity(.member)
    ]
)
