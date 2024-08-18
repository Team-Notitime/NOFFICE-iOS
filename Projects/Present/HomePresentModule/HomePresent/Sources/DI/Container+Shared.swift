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
        
        container.register(HomeTabReactor.self) { _ in
            HomeTabReactor()
        }
        .inObjectScope(.transient)

        return container
    }()
}
