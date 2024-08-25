import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .newOrganization,
    dependencies: [
        .usecase(.common),
        .usecase(.organization),
        .entity(.common),
        .entity(.organization)
    ]
)
