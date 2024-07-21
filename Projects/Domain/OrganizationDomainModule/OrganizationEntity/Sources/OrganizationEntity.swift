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
    /// List of category IDs associated with the organization.
    public let categories: [Int]
    /// URL of the image associated with the organization (optional).
    public let imageURL: String?
    /// End date of the group's activities (optional).
    public let endDate: Date?
    /// Promotion code for the organization (optional).
    public let promotionCode: String?
    
    public init(
        id: Int,
        name: String,
        categories: [Int],
        imageURL: String? = nil,
        endDate: Date? = nil,
        promotionCode: String? = nil
    ) {
        self.id = id
        self.name = name
        self.categories = categories
        self.imageURL = imageURL
        self.endDate = endDate
        self.promotionCode = promotionCode
    }
}
