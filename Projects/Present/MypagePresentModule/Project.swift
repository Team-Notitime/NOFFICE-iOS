import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makePresentModule(
    .mypage,
    dependencies: [
        .usecase(.main),
        .entity(.main)
    ]
)
