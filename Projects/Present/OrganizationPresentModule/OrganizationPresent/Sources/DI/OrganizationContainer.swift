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
        
        container.register(NewOrganizationFunnelReactor.self) { resolver in
            NewOrganizationFunnelReactor(
                nameReactor: resolver.resolve(NewOrganizationNamePageReactor.self)!,
                categoryReactor: resolver.resolve(NewOrganizationCategoryPageReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(NewOrganizationNamePageReactor.self) { _ in
            NewOrganizationNamePageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(NewOrganizationCategoryPageReactor.self) { _ in
            NewOrganizationCategoryPageReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
