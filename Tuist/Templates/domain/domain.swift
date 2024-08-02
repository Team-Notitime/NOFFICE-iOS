import ProjectDescription

// Required attributes for the template
let nameAttribute = Template.Attribute.required("name")

// Define the template
let template = Template(
    description: "A template for generating a new domain module",
    attributes: [nameAttribute],
    items: [
        .file(
            path: "Projects/Domain/{{ name }}DomainModule/Project.swift",
            templatePath: "./Project.stencil"
        ),
        // usecase
        .string(
            path: "Projects/Domain/{{ name }}DomainModule/{{name}}Usecase/Sources/Sample.swift",
            contents: "// sample.swift"
        ),
        .string(
            path: "Projects/Domain/{{ name }}DomainModule/{{name}}Usecase/Resources/Empty.swift",
            contents: "// This file is used to generate the TuistBundle file."
        ),
        // entity
        .string(
            path: "Projects/Domain/{{ name }}DomainModule/{{name}}Entity/Sources/Sample.swift",
            contents: "// sample.swift"
        ),
        .string(
            path: "Projects/Domain/{{ name }}DomainModule/{{name}}Entity/Resources/Empty.swift",
            contents: "// This file is used to generate the TuistBundle file."
        )
    ]
)
