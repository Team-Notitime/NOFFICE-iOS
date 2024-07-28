import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        .thirdParty(.swinject)
    ]
)
