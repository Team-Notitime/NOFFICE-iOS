//
//  AnnouncementItemEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

/**
 Represents a announcement in group(organization).
 */
public struct AnnouncementEntity: Identifiable, Equatable {
    /// Unique identifier for the announcement item
    public let id: Int
    
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
    
    /// Event date or deadline (optional)
    public let endAt: Date?
    
    /// Place of the announcement (optional)
    public let place: AnnouncementPlaceEntity?
    
    /// List of todo items (optional)
    public let todos: [AnnouncementTodoEntity]?
    
    /// Types of reminder notifications (optional)
    public let remindNotification: [AnnouncementRemindNotification]?
    
    public init(
        id: Int,
        organizationId: Int64,
        imageURL: String? = nil,
        createdAt: Date? = nil,
        title: String,
        body: String,
        endAt: Date? = nil,
        place: AnnouncementPlaceEntity? = nil,
        todos: [AnnouncementTodoEntity]? = nil,
        remindNotification: [AnnouncementRemindNotification]? = nil
    ) {
        self.id = id
        self.organizationId = organizationId
        self.createdAt = createdAt
        self.imageUrl = imageURL
        self.title = title
        self.body = body
        self.endAt = endAt
        self.place = place
        self.todos = todos
        self.remindNotification = remindNotification
    }
}
