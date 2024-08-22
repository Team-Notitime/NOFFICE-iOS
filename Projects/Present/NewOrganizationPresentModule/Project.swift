import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .newOrganization,
    dependencies: [
        .usecase(.organization),
        .entity(.organization)
    ]
)
