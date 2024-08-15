//
//  Contaner+Shared.swift
//  Container
//
//  Created by DOYEON LEE on 8/14/24.
//

import Swinject

import MemberDataInterface
import MemberData
import AnnouncementDataInterface
import AnnouncementData
import OrganizationDataInterface
import OrganizationData

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
        
        return container
    }()
}
