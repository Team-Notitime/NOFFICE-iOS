import ProjectDescription
import ProjectDescriptionHelpers

let dataInterfaceDepdencencies = Module.DataInterface
    .allCases
    .map {
        TargetDependency.dataInterface($0)
    }

let dataDepdencencies = Module.Data
    .allCases
    .map {
        TargetDependency.data($0)
    }

let project = Project.makeDIModule(
    .container,
    dependencies: [
        .thirdParty(.swinject),
        .thirdParty(.rxSwift)
    ] 
    + dataInterfaceDepdencencies
    + dataDepdencencies
)
