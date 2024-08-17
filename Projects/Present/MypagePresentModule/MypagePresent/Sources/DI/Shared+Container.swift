//
//  Shared+Container.swift
//  MypagePresent
//
//  Created by DOYEON LEE on 8/17/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(MypageReactor.self) { _ in
            MypageReactor()
        }
        .inObjectScope(.transient)

        return container
    }()
}
