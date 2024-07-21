import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeMainApp(
    .noffice,
    dependencies: [
        .ui(.designSystem),
        .ui(.assets),
        .present(.home),
        .present(.organization),
        .present(.mypage),
        .present(.signup),
        .present(.newAnnouncement),
        .di(.router)
    ]
)
