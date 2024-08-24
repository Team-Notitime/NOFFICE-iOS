//
//  AnnouncementOrganizationEntity.swift
//  TodoEntity
//
//  Created by DOYEON LEE on 7/21/24.
//

import Foundation

/**
 Represents an organization containing a list of annuncements.
*/
public struct AnnouncementOrganizationEntity: Identifiable, Equatable {
    /// Unique identifier for the organization.
    public let id: Int
    
    /// Name of the organization in Korean.
    public let name: String
    
    /// Status of the organization.
    public let status: OrganizationStatus
    
    /// List of todos associated with the organization.
    public let announcements: [AnnouncementSummaryEntity]
    
    public init(
        id: Int,
        name: String,
        status: OrganizationStatus,
        announcements: [AnnouncementSummaryEntity]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.announcements = announcements
    }
}

/**
 Enum representing the status of an organization.
 */
public enum OrganizationStatus: Codable, Equatable {
    /// The organization has joined.
    case join
    /// The organization is pending approval.
    case pending
}
