import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Noffice",
    targets: [
        .target(
            name: "Noffice",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.notice.app",
            deploymentTargets: .iOS("\(Project.deployTarget)"),
            infoPlist: .file(path: "Sources/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .feature(.home),
                .feature(.group),
                .feature(.my),
                .feature(.signup),
                .di(.router)
            ]
        ),
        .target(
            name: "NofficeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.NofficeTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Noffice")]
        ),
    ]
)
