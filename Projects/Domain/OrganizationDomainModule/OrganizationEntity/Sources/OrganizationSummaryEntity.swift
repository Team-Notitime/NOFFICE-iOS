//
//  OrganizationSummaryEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 8/24/24.
//

import Foundation

/**
 Summary of information about the organization.
 */
public struct OrganizationSummaryEntity: Identifiable, Equatable {
    /// Unique identifier for the organization.
    public let id: Int64
    
    /// Name of the organization.
    public let name: String
    
    /// Profile image url of the organization.
    public let profileImageUrl: URL?
    
    public init(
        id: Int64,
        name: String,
        profileImageUrl: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.profileImageUrl = profileImageUrl
    }
}
