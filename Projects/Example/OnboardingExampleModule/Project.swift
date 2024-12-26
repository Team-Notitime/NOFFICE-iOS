//
//  Project.swift
//  Manifests
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeExampleModule(
  .onboarding,
  dependencies: [
    .present(.onboarding)
  ]
)
