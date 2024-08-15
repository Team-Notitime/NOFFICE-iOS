//
//  OrganizationRepositoryInterface.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 7/31/24.
//

import OpenapiGenerated
import OrganizationEntity

import RxSwift

public typealias GetOrganizationParam = Operations.getOrganization.Input.Path
public typealias GetOrganizationResult = Components.Schemas.OrganizationResponse

public typealias GetJoinedOrganizationsParam = Operations.getJoinedOrganizations.Input
public typealias GetJoinedOrganizationsResult = Components.Schemas.SliceOrganizationResponse

public struct GetPublishedAnnouncementParam {
    public let memberId: Int64
    public let organizationId: Int64
    public let pageable: Components.Schemas.Pageable
    
    public init(
        memberId: Int64,
        organizationId: Int64,
        pageable: Components.Schemas.Pageable
    ) {
        self.memberId = memberId
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
    func getOrganization(
        _ param: GetOrganizationParam
    ) -> Observable<GetOrganizationResult>
    
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
