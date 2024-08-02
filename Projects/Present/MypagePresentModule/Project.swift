import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .mypage,
    dependencies: [
        .usecase(.member),
        .entity(.member)
    ]
)
