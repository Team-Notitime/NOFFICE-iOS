//
//  GetOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct GetOrganizationRequest: Codable { }

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
