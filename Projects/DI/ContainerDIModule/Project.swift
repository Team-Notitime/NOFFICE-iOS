import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDIModule(
    .container,
    dependencies: [
        // entity
        .entity(.organization),
        .entity(.announcement),
        .entity(.todo),
        // data interface
        .dataInterface(.organization),
        .dataInterface(.announcement),
        // data
        .data(.organization),
        .data(.announcement),
        // third party
        .thirdParty(.swinject),
        .thirdParty(.rxSwift)
    ]
)
