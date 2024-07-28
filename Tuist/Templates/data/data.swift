import ProjectDescription

// Required attributes for the template
let nameAttribute = Template.Attribute.required("name")

// Define the template
let template = Template(
    description: "A template for generating a new data and data interface module",
    attributes: [nameAttribute],
    items: [
        // data
        .file(
            path: "Projects/Data/{{ name }}DataModule/Project.swift",
            templatePath: "./ProjectData.stencil"
        ),
        .string(
            path: "Projects/Data/{{ name }}DataModule/{{name}}Data/Sources/Sample.swift",
            contents: ""
        ),
        .string(
            path: "Projects/Data/{{ name }}DataModule/{{name}}Data/Resources/Empty.swift",
            contents: "// This file is used to generate the TuistBundle file."
        ),
        // data interface
        .file(
            path: "Projects/DataInterface/{{ name }}DataInterfaceModule/Project.swift",
            templatePath: "./ProjectDataInterface.stencil"
        ),
        .string(
            path: "Projects/DataInterface/{{ name }}DataInterfaceModule/{{name}}DataInterface/Sources/Sample.swift",
            contents: ""
        ),
        .string(
            path: "Projects/DataInterface/{{ name }}DataInterfaceModule/{{name}}DataInterface/Resources/Empty.swift",
            contents: "// This file is used to generate the TuistBundle file."
        )
    ]
)
