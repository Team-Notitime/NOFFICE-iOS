import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomainModule(
    .organization,
    dependencies: [
        .dataInterface(.organization),
        .di(.container),
        .utility(.userDefaults)
    ]
)
