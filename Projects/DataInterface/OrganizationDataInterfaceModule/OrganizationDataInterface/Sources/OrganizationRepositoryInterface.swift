//
//  OrganizationRepositoryInterface.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 7/31/24.
//

import OpenapiGenerated
import OrganizationEntity

import RxSwift

public typealias GetOrganizationDetailParam = Operations.getInformation.Input.Path
public typealias GetOrganizationDetailResult = Components.Schemas.OrganizationInfoResponse

public typealias GetJoinedOrganizationsParam = Operations.getJoined.Input.Query
public typealias GetJoinedOrganizationsResult = Components.Schemas.SliceOrganizationResponse

public struct GetPublishedAnnouncementParam {
    public let organizationId: Int64
    public let pageable: Components.Schemas.Pageable
    
    public init(
        organizationId: Int64,
        pageable: Components.Schemas.Pageable
    ) {
        self.organizationId = organizationId
        self.pageable = pageable
    }
}
public typealias GetPublishedAnnouncementResult = Components.Schemas.SliceAnnouncementCoverResponse

public struct CreateOrganizationParam {
    public let memberId: Int64
    public let body: Components.Schemas.OrganizationCreateRequest
    
    public init(
        memberId: Int64,
        body: Components.Schemas.OrganizationCreateRequest
    ) {
        self.memberId = memberId
        self.body = body
    }
}
public typealias CreateOrganizationResult = Components.Schemas.OrganizationCreateResponse

/// A protocol defining the operations for managing organizations.
public protocol OrganizationRepositoryInterface {
    func getOrganizationDetail(
        _ param: GetOrganizationDetailParam
    ) -> Observable<GetOrganizationDetailResult>
    
    func getJoinedOrganizations(
        _ param: GetJoinedOrganizationsParam
    ) -> Observable<GetJoinedOrganizationsResult>
    
    func getPublishedAnnouncements(
        _ param: GetPublishedAnnouncementParam
    ) -> Observable<GetPublishedAnnouncementResult>
    
    func createOrganization(
        _ param: CreateOrganizationParam
    ) -> Observable<CreateOrganizationResult>
}
