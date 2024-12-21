import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomainModule(
    .main,
    dependencies: [
        .di(.container),
        .dataInterface(.image),
        .dataInterface(.organization),
        .utility(.keychain),
        .utility(.userDefaults),
        .thirdParty(.openGraph)
    ]
)
