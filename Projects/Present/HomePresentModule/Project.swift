import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .home,
    dependencies: [
        .usecase(.todo),
        .usecase(.announcement),
        .entity(.todo),
        .entity(.announcement)
    ]
)
