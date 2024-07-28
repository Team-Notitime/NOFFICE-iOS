//
//  OrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import Foundation

// 요청 모델
struct CreateOrganizationRequest: Codable {
    let name: String
    let categories: Categories
    let profileImage: String
    let organizationEndAt: String
    let promotionCode: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case categories
        case profileImage = "profile_image"
        case organizationEndAt = "organizationEndAt"
        case promotionCode = "promotion_code"
    }
}

struct Categories: Codable {
    let categoryIds: String
}

struct JoinOrganizationRequest: Codable {
    let memberId: Int
    let organizationId: Int
}

struct Organization: Codable {
    let id: Int
    let name: String
}

struct OrganizationListResponse: Codable {
    let organizations: [Organization]
}
