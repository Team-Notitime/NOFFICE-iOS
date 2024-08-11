//
//  JoinOrganizationDTO.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct JoinOrganizationRequeset: Codable {
    let memberId: Int
    let organizationId: Int
}

struct JoinOrganizationResponse: Codable {
    let isSuccess: Bool
}
