//
//  Contaner+Shared.swift
//  Container
//
//  Created by DOYEON LEE on 8/14/24.
//

import Swinject

import AnnouncementData
import AnnouncementDataInterface
import ImageData
import ImageDataInterface
import MemberData
import MemberDataInterface
import OrganizationData
import OrganizationDataInterface
import TodoData
import TodoDataInterface

public extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(MemberRepositoryInterface.self) { _ in
            MemberRepository()
        }
        
        container.register(AnnouncementRepositoryInterface.self) { _ in
            AnnouncementRepository()
        }
        
        container.register(OrganizationRepositoryInterface.self) { _ in
            OrganizationRepository()
        }
        
        container.register(TodoRepositoryInterface.self) { _ in
            TodoRepository()
        }
        
        container.register(ImageRepositoryInterface.self) { _ in
            ImageRepository()
        }
        
        return container
    }()
}
