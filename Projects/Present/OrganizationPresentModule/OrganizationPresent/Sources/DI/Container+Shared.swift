//
//  OrganizationContainer.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        // - Organization tab
        container.register(OrganizationTabReactor.self) { _ in
            OrganizationTabReactor()
        }
        .inObjectScope(.transient)
        
        // - Organization detail
        container.register(OrganizationDetailReactor.self) { _ in
            OrganizationDetailReactor()
        }
        .inObjectScope(.transient)

        return container
    }()
}
