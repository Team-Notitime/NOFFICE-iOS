import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .newOrganization,
    dependencies: [
        .present(.newOrganization)
    ]
)
