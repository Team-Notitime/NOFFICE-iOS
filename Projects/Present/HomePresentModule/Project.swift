import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .home,
    dependencies: [
        .present(.announcement),
        .usecase(.todo),
        .usecase(.announcement),
        .entity(.todo),
        .entity(.announcement)
    ]
)
