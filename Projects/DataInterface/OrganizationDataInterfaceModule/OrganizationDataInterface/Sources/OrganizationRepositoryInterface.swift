//
//  OrganizationRepositoryInterface.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 7/31/24.
//

import OpenapiGenerated
import OrganizationEntity
import RxSwift

/// A protocol defining the operations for managing organizations.
public protocol OrganizationRepositoryInterface {
    func getOrganizationDetail(
        _ request: GetOrganizationDetailRequest
    ) -> Observable<GetOrganizationDetailResponse>

    func getJoinedOrganizations(
        _ request: GetJoinedOrganizationsRequest
    ) -> Observable<GetJoinedOrganizationsResponse>

    func getPublishedAnnouncements(
        _ request: GetPublishedAnnouncementRequest
    ) -> Observable<GetPublishedAnnouncementResponse>

    func createOrganization(
        _ request: CreateOrganizationRequest
    ) -> Observable<CreateOrganizationResponse>
}
