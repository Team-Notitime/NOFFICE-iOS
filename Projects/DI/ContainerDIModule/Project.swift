import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        // data interface
        .dataInterface(.organization),
        .dataInterface(.announcement),
        .dataInterface(.member),
        // data
        .data(.organization),
        .data(.announcement),
        .data(.member),
        // third party
        .thirdParty(.swinject),
        .thirdParty(.rxSwift)
    ]
)
