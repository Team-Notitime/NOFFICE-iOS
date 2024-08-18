import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .home,
    dependencies: [
        .usecase(.todo),
        .usecase(.announcement),
        .usecase(.member),
        .entity(.todo),
        .entity(.announcement),
        .entity(.member)
        
    ]
)
