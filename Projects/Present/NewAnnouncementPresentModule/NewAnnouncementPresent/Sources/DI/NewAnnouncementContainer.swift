//
//  DI.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(NewAnnouncementFunnelReactor.self) { resolver in
            NewAnnouncementFunnelReactor(
                selectOrganizationReactor: resolver.resolve(SelectOrganizationPageReactor.self)!,
                editContentsReactor: resolver.resolve(EditContentsPageReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(SelectOrganizationPageReactor.self) { _ in
            SelectOrganizationPageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(EditContentsPageReactor.self) { _ in
            EditContentsPageReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
