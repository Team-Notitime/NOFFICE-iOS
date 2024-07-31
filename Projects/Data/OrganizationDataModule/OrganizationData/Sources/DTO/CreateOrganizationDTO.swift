//
//  OrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import Foundation

struct CreateOrganizationDTO {
    struct Request: Codable {
        let name: String
        let categories: [Int]
        let profileImage: String?
        let organizationEndAt: String?
        let promotionCode: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case categories
            case profileImage = "profile_image"
            case organizationEndAt = "organizationEndAt"
            case promotionCode = "promotion_code"
        }
    }

    struct Response: Codable {
        let id: Int
        let name: String
    }
}
