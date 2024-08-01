import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .organization,
    dependencies: [
        .usecase(.organization),
        .usecase(.announcement),
        .entity(.organization),
        .entity(.announcement)
    ]
)
