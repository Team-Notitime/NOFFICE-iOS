import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .signup,
    dependencies: [
        .feature(.signup)
    ]
)
