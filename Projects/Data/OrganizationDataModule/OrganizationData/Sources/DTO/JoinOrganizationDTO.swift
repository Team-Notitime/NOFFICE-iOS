//
//  JoinOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct JoinOrganizationDTO {
    struct Request: Codable {
        let memberId: Int
        let organizationId: Int
    }
    
    struct Response: Codable { 
        let isSuccess: Bool
    }
}
