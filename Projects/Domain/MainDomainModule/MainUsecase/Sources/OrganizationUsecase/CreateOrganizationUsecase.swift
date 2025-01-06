//
//  CreateOrganizationUsecase.swift
//  OrganizationUsecase
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation

import Container
import MainEntity
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
    
    public struct Output {
      public let organization: OrganizationEntity
      
      public init(
        organization: OrganizationEntity
      ) {
        self.organization = organization
      }
    }
    
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
                    categoryList: newOrganization.categories.map { Int64($0) },
                    profileImage: newOrganization.imageURL?.absoluteString,
                    endAt: newOrganization.endDate,
                    promotionCode: .init(promotionCode: newOrganization.promotionCode)
                )
            )
        )
        .map { org in
          return Output(
            organization: .init(
              id: Int(org.id),
              name: org.name,
              categories: [],
              profileImageUrl: URL(string: org.profileImage ?? ""),
              endDate: org.endAt,
              promotionCode: org.promotion?.promotionCode,
              leader: 0,
              member: 0
            )
          )
        }
    }
}
