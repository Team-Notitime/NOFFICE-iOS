//
//  GetMyOrganizationsUsecase.swift
//  OrganizationUsecase
//
//  Created by DOYEON LEE on 7/22/24.
//

import Container
import OrganizationEntity
import OrganizationDataInterface

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
    
    // MARK: Initializer
    public init() { 
        self.page = Constant.StartPage
    }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        
        organizationRepository.getJoinedOrganizations(
            .init(
                memberId: 1,
                pageable: .init(page: Int32(page), size: Constant.PageSize)
            )
        )
        
        return .just(.init(organizations: Self.mock))
    }
    
    static let mock: [OrganizationEntity] = [ // TODO: Repository로 이동
        .init(id: 1, name: "CMC 15th", categories: [1, 2, 3], leader: 1, member: 10),
        .init(id: 2, name: "멋진 동아리", categories: [1, 2, 3], leader: 1, member: 3),
        .init(id: 3, name: "즐거운 소모임", categories: [1, 2, 3], leader: 2, member: 15)
    ]
}

private enum Constant {
    static let StartPage: Int = 1
    static let PageSize: Int32 = 10
}
