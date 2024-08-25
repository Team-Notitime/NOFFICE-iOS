//
//  GetJoinedOrganizationsUsecase.swift
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

public class GetJoinedOrganizationsUsecase {
    // MARK: DTO
    public struct Input { 
        public init() { }
    }
    
    public struct Output {
        public let organizations: [OrganizationSummaryEntity]
        
        public init(
            organizations: [OrganizationSummaryEntity]
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
            
            let organizations: [OrganizationSummaryEntity] = result.content?.map {
                OrganizationSummaryEntity(
                    id: $0.organizationId,
                    name: $0.organizationName,
                    profileImageUrl: URL(
                        string: $0.profileImage
                    ),
                    role: $0.role == .LEADER ? .leader : .member
                )
            } ?? []
            
            return Output(organizations: organizations)
        }
        
        return outputObservable
    }
    
}

// MARK: - Constant
private enum Constant {
    static let StartPage: Int = 0
    static let PageSize: Int32 = 10
}
