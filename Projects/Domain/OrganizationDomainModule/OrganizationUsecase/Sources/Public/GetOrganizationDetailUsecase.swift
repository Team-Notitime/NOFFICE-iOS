//
//  GetOrganizationDetailUsecase.swift
//  OrganizationUsecase
//
//  Created by DOYEON LEE on 8/18/24.
//

import Container
import Foundation
import OrganizationDataInterface
import OrganizationEntity
import RxSwift
import Swinject

public struct GetOrganizationDetailUsecase {
    // MARK: DTO
    public struct Input {
        let organizationId: Int

        public init(organizationId: Int) {
            self.organizationId = organizationId
        }
    }

    public struct Output {
        public let organization: OrganizationEntity
    }

    // MARK: Dependency
    private let organizationRepository = Container.shared.resolve(OrganizationRepositoryInterface.self)!

    // MARK: Initializer
    public init() {}

    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        return organizationRepository
            .getOrganizationDetail(
                .init(
                    organizationId: Int64(input.organizationId)
                )
            )
            .map { result in
                let organization = OrganizationEntity(
                    id: Int(result.organizationId),
                    name: result.organizationName,
                    categories: result.categories,
                    profileImageUrl: URL(string: result.profileImage ?? ""),
                    endDate: nil, // TODO: 왜없지?
                    promotionCode: nil, // TODO: 왜없지?
                    leader: Int(result.leaderCount ?? 0),
                    member: Int(result.participantCount ?? 0) // FIXME: ex
                )

                return Output(organization: organization)
            }
    }
}
