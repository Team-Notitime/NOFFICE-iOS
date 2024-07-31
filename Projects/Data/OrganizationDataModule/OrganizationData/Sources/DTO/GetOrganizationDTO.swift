//
//  GetOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct GetOrganizationDTO {
    struct Request: Codable { }
    
    struct Response: Codable { 
        let id: Int
        let name: String
        let categories: [Int]
        let profileImage: String?
        let organizationEndAt: String?
        let promotionCode: String?
    }
}
