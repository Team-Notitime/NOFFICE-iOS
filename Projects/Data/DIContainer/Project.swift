import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DIContainer",
    targets: [
        .target(
            name: "DIContainer",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.notice.di",
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Swinject")
            ]
        )
    ]
)
