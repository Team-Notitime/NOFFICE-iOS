//
//  GetOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

@available(*, deprecated, message: "Openapi generate된 dto로 대체")
struct GetOrganizationRequest: Codable { }

@available(*, deprecated, message: "Openapi generate된 dto로 대체")
struct GetOrganizationResponse: Codable {
    let id: Int
    let name: String
    let categories: [Int]
    let profileImage: String?
    let organizationEndAt: String?
    let promotionCode: String?
    let leader: Int
    let member: Int
}
