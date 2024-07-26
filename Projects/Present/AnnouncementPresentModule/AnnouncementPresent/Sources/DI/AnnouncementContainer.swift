//
//  AnnouncementContainer.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(AnnouncementDetailReactor.self) { _ in
            AnnouncementDetailReactor()
        }
        .inObjectScope(.transient)

        return container
    }()
}
