import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .image,
    dependencies: [
        .dataInterface(.image)
    ]
)
