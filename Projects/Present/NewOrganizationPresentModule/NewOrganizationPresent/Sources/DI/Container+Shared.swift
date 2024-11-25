//
//  Container+Shared.swift
//  NewOrganizationPresent
//
//  Created by DOYEON LEE on 8/15/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        // - New organization funnel
        container.register(NewOrganizationFunnelReactor.self) { resolver in
            NewOrganizationFunnelReactor(
                nameReactor: resolver.resolve(NewOrganizationNamePageReactor.self)!,
                categoryReactor: resolver.resolve(NewOrganizationCategoryPageReactor.self)!,
                imageReactor: resolver.resolve(NewOrganizationImagePageReactor.self)!,
                endDateReactor: resolver.resolve(NewOrganizationDatePageReactor.self)!,
                promotionReactor: resolver.resolve(NewOrganizationPromotionPageReactor.self)!,
                completeReactor: resolver.resolve(NewOrganizationCompletePageReactor.self)!
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
        
        container.register(NewOrganizationImagePageReactor.self) { _ in
            NewOrganizationImagePageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(NewOrganizationDatePageReactor.self) { _ in
            NewOrganizationDatePageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(NewOrganizationPromotionPageReactor.self) { _ in
            NewOrganizationPromotionPageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(NewOrganizationCompletePageReactor.self) { _ in
            NewOrganizationCompletePageReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
