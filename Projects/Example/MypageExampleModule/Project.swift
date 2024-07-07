import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
    .mypage,
    dependencies: [
        .feature(.mypage)
    ]
)
