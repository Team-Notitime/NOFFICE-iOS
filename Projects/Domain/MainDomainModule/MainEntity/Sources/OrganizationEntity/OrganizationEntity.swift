//
//  OrganizationEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

/**
 Represents an organization with various attributes.
 */
public struct OrganizationEntity: Identifiable, Equatable {
    /// Unique identifier for the organization.
    public let id: Int
    
    /// Name of the organization.
    public let name: String
    
    /// List of category associated with the organization.
    public let categories: [String]
    
    /// URL of the image associated with the organization (optional).
    public let profileImageUrl: URL?
    
    /// End date of the group's activities (optional).
    public let endDate: Date?
    
    /// Promotion code for the organization (optional).
    public let promotionCode: String?
    
    /// Number of leaders participating in the organization.
    public let leader: Int
    
    /// Number of members participating in the organization.
    public let member: Int
    
    public init(
        id: Int,
        name: String,
        categories: [String],
        profileImageUrl: URL?,
        endDate: Date?,
        promotionCode: String?,
        leader: Int,
        member: Int
    ) {
        self.id = id
        self.name = name
        self.categories = categories
        self.profileImageUrl = profileImageUrl
        self.endDate = endDate
        self.promotionCode = promotionCode
        self.leader = leader
        self.member = member
    }
}
