//
//  Container+Shared.swift
//  HomePresent
//
//  Created by DOYEON LEE on 8/18/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(HomeTabReactor.self) { resolver in
            HomeTabReactor(
                announcementPageReactor: resolver.resolve(AnnouncementPageReactor.self)!,
                todoPageReactor: resolver.resolve(TodoPageReactor.self)!
            )
        }
        .inObjectScope(.transient)
        
        container.register(AnnouncementPageReactor.self) { _ in
            AnnouncementPageReactor()
        }
        .inObjectScope(.weak)
        
        container.register(TodoPageReactor.self) { _ in
            TodoPageReactor()
        }
        .inObjectScope(.weak)

        return container
    }()
}
