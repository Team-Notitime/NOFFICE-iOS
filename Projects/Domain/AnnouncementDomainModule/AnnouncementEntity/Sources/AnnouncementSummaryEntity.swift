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
    public let coverImageUrl: URL?
    
    /// Title of the announcement
    public let title: String
    
    /// Body text of the announcement
    public let body: String
    
    /// Event date or deadline (optional)
    public let endAt: Date?
    
    /// Place of the announcement (optional)
    public let placeName: String?
    
    /// Count of todo items (optional)
    public let todoCount: Int?
    
    public init(
        id: Int64,
        organizationId: Int64,
        coverImageUrl: URL?,
        createdAt: Date?,
        title: String,
        body: String,
        endAt: Date?,
        placeName: String?,
        todoCount: Int?
    ) {
        self.id = id
        self.organizationId = organizationId
        self.createdAt = createdAt
        self.coverImageUrl = coverImageUrl
        self.title = title
        self.body = body
        self.endAt = endAt
        self.placeName = placeName
        self.todoCount = todoCount
    }
}
