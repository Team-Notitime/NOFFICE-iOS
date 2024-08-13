import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomainModule(
    .member,
    dependencies: [
        .di(.container)
    ]
)
