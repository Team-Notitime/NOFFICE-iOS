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
                editContentsReactor: resolver.resolve(EditContentsPageReactor.self)!,
                editDateTimeReactor: resolver.resolve(EditDateTimeReactor.self)!,
                editPlaceReactor: resolver.resolve(EditPlaceReactor.self)!,
                editTodoReactor: resolver.resolve(EditTodoReactor.self)!,
                editNotificationReactor: resolver.resolve(EditNotificationReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(SelectOrganizationPageReactor.self) { _ in
            SelectOrganizationPageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(EditContentsPageReactor.self) { resolver in
            EditContentsPageReactor(
                editDateTimeReactor: resolver.resolve(EditDateTimeReactor.self)!,
                editPlaceReactor: resolver.resolve(EditPlaceReactor.self)!,
                editTodoReactor: resolver.resolve(EditTodoReactor.self)!,
                editNotificationReactor: resolver.resolve(EditNotificationReactor.self)!
            )
        }
        .inObjectScope(.weak)
        
        container.register(EditDateTimeReactor.self) { _ in
            EditDateTimeReactor()
        }
        .inObjectScope(.weak)
        
        container.register(EditPlaceReactor.self) { _ in
            EditPlaceReactor()
        }
        .inObjectScope(.weak)
        
        container.register(EditTodoReactor.self) { _ in
            EditTodoReactor()
        }
        .inObjectScope(.weak)
        
        container.register(EditNotificationReactor.self) { _ in
            EditNotificationReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
