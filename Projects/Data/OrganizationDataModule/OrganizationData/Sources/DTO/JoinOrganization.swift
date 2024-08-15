//
//  JoinOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

@available(*, deprecated, message: "Openapi generate된 dto로 대체")
struct JoinOrganizationRequeset: Codable {
    let memberId: Int
    let organizationId: Int
}

@available(*, deprecated, message: "Openapi generate된 dto로 대체")
struct JoinOrganizationResponse: Codable {
    let isSuccess: Bool
}
