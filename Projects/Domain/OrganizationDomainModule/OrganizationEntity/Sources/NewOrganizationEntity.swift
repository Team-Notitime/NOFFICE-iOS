//
//  NewOrganizationEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 8/1/24.
//

import Foundation

/**
 Represents the information of a new organization to be created.
 */
public struct NewOrganizationEntity: Identifiable, Equatable {
    /// Unique identifier for the organization.
    ///
    /// - Note: that this is not a globally unique value among all organizations, 
    /// but just a distinguishing identifier.
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
