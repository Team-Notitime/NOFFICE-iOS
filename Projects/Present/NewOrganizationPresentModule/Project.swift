import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .newOrganization,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
