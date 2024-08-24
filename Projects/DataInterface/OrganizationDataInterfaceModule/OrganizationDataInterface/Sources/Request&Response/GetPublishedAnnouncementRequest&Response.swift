//
//  GetPublishedAnnouncementPayload.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 8/24/24.
//

import OpenapiGenerated

// MARK: Request
public struct GetPublishedAnnouncementRequest {
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

// MARK: Response
public typealias GetPublishedAnnouncementResponse = Components.Schemas.SliceAnnouncementCoverResponse
