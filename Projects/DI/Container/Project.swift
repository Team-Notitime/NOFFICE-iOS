import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DI",
    targets: [
        .target(
            name: "Container",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.notice.di.container",
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Swinject")
            ]
        )
    ]
)
