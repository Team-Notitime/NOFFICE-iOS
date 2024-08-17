import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeMainApp(
    .noffice,
    dependencies: [
        .ui(.designSystem),
        .ui(.assets),
        .di(.router),
        .thirdParty(.pulse),
        .thirdParty(.pulseUI)
    ] + Module.Present.allCases.map {
        .present($0)
    }
)
