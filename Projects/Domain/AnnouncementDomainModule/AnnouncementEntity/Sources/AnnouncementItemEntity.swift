//
//  AnnouncementItemEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

/**
 Represents a todo item categorized by group.
 */
public struct AnnouncementItemEntity: Identifiable, Equatable {
    /// Unique identifier for the todo item
    public let id: Int
    /// Announcement creation date
    public let createdAt: Date?
    /// Image URL for the announcement illustration. (optional)
    public let imageURL: String?
    /// Title of the announcement
    public let title: String
    /// Body text of the announcement
    public let body: String
    /// Event date or deadline (optional)
    public let date: Date?
    /// Place of the announcement (optional)
    public let place: AnnouncementPlaceEntity?
    /// List of todo items (optional)
    public let todos: [AnnouncementTodoEntity]?
    /// Types of reminder notifications (optional)
    public let remindNotification: [AnnouncementRemindNotification]?
    
    public init(
        id: Int,
        imageURL: String? = nil,
        createdAt: Date? = nil,
        title: String,
        body: String,
        date: Date? = nil,
        place: AnnouncementPlaceEntity? = nil,
        todos: [AnnouncementTodoEntity]? = nil,
        remindNotification: [AnnouncementRemindNotification]? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.imageURL = imageURL
        self.title = title
        self.body = body
        self.date = date
        self.place = place
        self.todos = todos
        self.remindNotification = remindNotification
    }
}
