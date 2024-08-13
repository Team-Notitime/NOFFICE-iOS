//
//  Contaner+Shared.swift
//  Container
//
//  Created by DOYEON LEE on 8/14/24.
//

import Swinject

import MemberDataInterface
import MemberData

public extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(MemberRepository.self) { _ in
            MemberRepositoryImpl()
        }
        
        return container
    }()
}
