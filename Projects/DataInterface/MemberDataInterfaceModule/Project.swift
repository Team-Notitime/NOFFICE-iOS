import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataInterfaceModule(
    .member,
    dependencies: [
        .entity(.member)
    ]
)
