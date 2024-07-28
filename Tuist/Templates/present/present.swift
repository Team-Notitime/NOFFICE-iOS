import ProjectDescription

// Required attributes for the template
let nameAttribute = Template.Attribute.required("name")

// Define the template
let template = Template(
    description: "A template for generating a new domain module",
    attributes: [nameAttribute],
    items: [
        .file(
            path: "Projects/Present/{{ name }}PresentModule/Project.swift",
            templatePath: "./Project.stencil"
        ),
        .string(
            path: "Projects/Present/{{ name }}PresentModule/{{name}}Present/Sources/Sample.swift",
            contents: "// sample.swift"
        ),
        .string(
            path: "Projects/Present/{{ name }}PresentModule/{{name}}Present/Resources/Empty.swift",
            contents: "// This file is used to generate the TuistBundle file."
        ),
    ]
)
