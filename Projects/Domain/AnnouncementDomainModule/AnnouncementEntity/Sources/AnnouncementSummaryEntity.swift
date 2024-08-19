//
//  AnnouncementSummaryEntity.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 8/18/24.
//

import Foundation

/**
 Represents a announcement in group(organization).
 */
public struct AnnouncementSummaryEntity: Identifiable, Equatable {
    /// Unique identifier for the announcement item
    public let id: Int64
    
    /// ID of organization that will generate announcement
    public let organizationId: Int64
    
    /// Announcement creation date
    public let createdAt: Date?
    
    /// Image URL for the announcement illustration. (optional)
    public let imageUrl: String?
    
    /// Title of the announcement
    public let title: String
    
    /// Body text of the announcement
    public let body: String
    
    /// Place of the announcement (optional)
    public let placeName: String?
    
    /// Count of todo items (optional)
    public let todoCount: Int?
    
    public init(
        id: Int64,
        organizationId: Int64,
        imageUrl: String? = nil,
        createdAt: Date? = nil,
        title: String,
        body: String,
        placeName: String? = nil,
        todoCount: Int? = nil
    ) {
        self.id = id
        self.organizationId = organizationId
        self.createdAt = createdAt
        self.imageUrl = imageUrl
        self.title = title
        self.body = body
        self.placeName = placeName
        self.todoCount = todoCount
    }
}
