import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDataModule(
    .todo,
    dependencies: [
        .dataInterface(.todo)
    ]
)
