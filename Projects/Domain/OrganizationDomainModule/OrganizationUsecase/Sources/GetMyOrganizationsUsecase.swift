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
    
    // MARK: Error
    public enum Error: LocalizedError {
        case memberNotFound
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
        if let memberId = memberUserDefaultsManager.get()?.id {
            return organizationRepository.getJoinedOrganizations(
                .init(
                    memberId: 3,
                    pageable: .init(page: Int32(page), size: Constant.PageSize)
                )
            )
            .map { result in
                self.page += 1
                
                let organizations: [OrganizationEntity] = result.content?.map {
                    OrganizationEntity(
                        id: Int($0.id ?? -1),
                        name: $0.name ?? "알 수 없는 그룹",
                        categories: [], // TODO: remove
                        leader: 0, // TODO: remove
                        member: 0 // TODO: remove
                    )
                } ?? []
                
                return Output(organizations: organizations)
            }
            
        } else {
            return Observable.error(Error.memberNotFound)
        }
    }
}

private struct Mock {
    static let OrganizationEntities: [OrganizationEntity] = [
        .init(id: 1, name: "CMC 15th", categories: [1, 2, 3], leader: 1, member: 10),
        .init(id: 2, name: "멋진 동아리", categories: [1, 2, 3], leader: 1, member: 3),
        .init(id: 3, name: "즐거운 소모임", categories: [1, 2, 3], leader: 2, member: 15)
    ]
}

private enum Constant {
    static let StartPage: Int = 1
    static let PageSize: Int32 = 10
}
