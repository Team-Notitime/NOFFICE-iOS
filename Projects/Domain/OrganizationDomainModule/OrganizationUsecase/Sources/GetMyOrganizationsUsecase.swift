//
//  GetMyOrganizationsUsecase.swift
//  OrganizationUsecase
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import Container
import OrganizationEntity
import OrganizationDataInterface
import UserDefaultsUtility

import Swinject
import RxSwift

public class GetMyOrganizationsUsecase {
    // MARK: DTO
    public struct Input { 
        public init() { }
    }
    
    public struct Output {
        public let organizations: [OrganizationEntity]
        
        public init(
            organizations: [OrganizationEntity]
        ) {
            self.organizations = organizations
        }
    }
    
    // MARK: Property
    var page: Int
    
    // MARK: Dependency
    private let organizationRepository = Container.shared.resolve(OrganizationRepositoryInterface.self)!
    
    private let memberUserDefaultsManager = UserDefaultsManager<Member>()
    
    // MARK: Initializer
    public init() { 
        self.page = Constant.StartPage
    }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let outputObservable = organizationRepository.getJoinedOrganizations(
            .init(pageable: .init(page: Int32(self.page), size: Constant.PageSize))
        )
        .map { result in
            self.page += 1
            
            let organizations: [OrganizationEntity] = result.content?.map {
                OrganizationEntity(
                    id: Int($0.organizationId),
                    name: $0.organizationName,
                    categories: [], // TODO: remove
                    leader: 0, // TODO: remove
                    member: 0 // TODO: remove
                )
            } ?? []
            
            return Output(organizations: organizations)
        }
        
        return outputObservable
    }
    
}

// MARK: - Mock
private struct Mock {
    static let OrganizationEntities: [OrganizationEntity] = [
        .init(id: 1, name: "CMC 15th", categories: [1, 2, 3], leader: 1, member: 10),
        .init(id: 2, name: "멋진 동아리", categories: [1, 2, 3], leader: 1, member: 3),
        .init(id: 3, name: "즐거운 소모임", categories: [1, 2, 3], leader: 2, member: 15)
    ]
}

// MARK: - Constant
private enum Constant {
    static let StartPage: Int = 0
    static let PageSize: Int32 = 10
}
