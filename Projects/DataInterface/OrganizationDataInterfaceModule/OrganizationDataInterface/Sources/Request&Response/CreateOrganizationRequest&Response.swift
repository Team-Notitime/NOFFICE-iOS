//
//  CreateOrganizationPayload.swift
//  OrganizationDataInterface
//
//  Created by DOYEON LEE on 8/24/24.
//

import OpenapiGenerated

// MARK: Request
public struct CreateOrganizationRequest {
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

// MARK: Response
public typealias CreateOrganizationResponse = Components.Schemas.OrganizationCreateResponse
