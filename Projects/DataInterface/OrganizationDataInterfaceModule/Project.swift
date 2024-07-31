import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataInterfaceModule(
    .organization,
    dependencies: [
        .entity(.organization)
    ]
)
