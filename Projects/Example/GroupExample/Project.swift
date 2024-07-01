import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.exampleApp(
    name: "Group",
    dependencies: [
        .project(
            target: "GroupFeature",
            path: .relativeToRoot("Projects/Feature/GroupFeature")
        )
    ]
)
