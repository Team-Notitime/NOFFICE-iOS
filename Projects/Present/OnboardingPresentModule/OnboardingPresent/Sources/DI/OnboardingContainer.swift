//
//  Untitled.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import Swinject

extension Container {
  static let shared: Container = {
    let container = Container()
    
    container.register(OnboardingReactor.self) { _ in
      OnboardingReactor()
    }
    .inObjectScope(.weak)
    
    return container
  }()
}
