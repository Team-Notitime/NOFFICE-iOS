//
//  NewAnnouncementEntity.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 8/25/24.
//

import Foundation

/**
 Represents a announcement in group(organization).
 */
public struct NewAnnouncementEntity: Equatable {
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
    
    /// List of todos associated with the announcement (optional)
    public let todos: [String]?

    /// Dates for notices before the announcement (optional)
    public let notifications: [AnnouncementRemindNotification]?

    public init(
        organizationId: Int64,
        imageURL: String?,
        createdAt: Date?,
        title: String,
        body: String,
        endAt: Date?,
        place: AnnouncementPlaceEntity?,
        todos: [String]?,
        notifications: [AnnouncementRemindNotification]?
    ) {
        self.organizationId = organizationId
        self.createdAt = createdAt
        self.imageUrl = imageURL
        self.title = title
        self.body = body
        self.endAt = endAt
        self.place = place
        self.todos = todos
        self.notifications = notifications
    }
}
