//
//  GetOrganizationListDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct GetOrganizationListDTO {
    struct Request: Codable { }
    
    struct Response: Codable {
        let organizations: [Organization]
    }
    
    // MARK: Nested DTO
    struct Organization: Codable {
        let id: Int
        let name: String
        let categories: [Int]
        let profileImage: String?
        let organizationEndAt: String?
        let promotionCode: String?
        let leader: Int
        let member: Int
    }
}
