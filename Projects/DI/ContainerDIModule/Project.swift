import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        .dataInterface(.sample),
        .data(.sample),
        .thirdParty(.swinject)
    ]
)
