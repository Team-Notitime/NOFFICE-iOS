//
//  CreateOrganizationUsecase.swift
//  OrganizationUsecase
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation

import Container
import OrganizationEntity
import OrganizationDataInterface

import Swinject
import RxSwift

public struct CreateOrganizationUsecase {
    // MARK: DTO
    public struct Input { 
        let newOrganization: NewOrganizationEntity
        
        public init(
            newOrganization: NewOrganizationEntity
        ) {
            self.newOrganization = newOrganization
        }
    }
    
    public struct Output { }
    
    // MARK: Dependency
    private let organizationRepository = Container.shared.resolve(OrganizationRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let newOrganization = input.newOrganization
        return organizationRepository.createOrganization(
            .init(
                memberId: 1,
                body: .init(
                    name: newOrganization.name,
                    categoryList: [1, 2], // TODO
                    profileImage: newOrganization.imageURL,
                    endAt: newOrganization.endDate,
                    promotionCode: .init(promotionCode: newOrganization.promotionCode)
                )
            )
        )
        .map { _ in
            .init()
        }
    }
}
