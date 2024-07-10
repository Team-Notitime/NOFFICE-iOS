import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .signup,
    dependencies: [
        .present(.signup)
    ]
)
