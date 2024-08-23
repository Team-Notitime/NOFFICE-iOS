import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        // data interface
        .dataInterface(.organization),
        .dataInterface(.announcement),
        .dataInterface(.member),
        .dataInterface(.todo),
        // data
        .data(.organization),
        .data(.announcement),
        .data(.member),
        .data(.todo),
        // third party
        .thirdParty(.swinject),
        .thirdParty(.rxSwift)
    ]
)
