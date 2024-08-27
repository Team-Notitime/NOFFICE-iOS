import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .common,
    dependencies: [
        .utility(.keychain),
        .utility(.notificationCenter)
    ]
)
