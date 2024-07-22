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
    /// Image URL for the announcement illustration. (optional)
    public let imageURL: String?
    /// Title of the announcement
    public let title: String
    /// Body text of the announcement
    public let body: String
    /// Event date or deadline (optional)
    public let date: Date?
    /// Location of the announcement (optional)
    public let location: AnnouncementLocationEntity?
    /// List of todo items (optional)
    public let todos: [AnnouncementTodoEntity]?
    /// Types of reminder notifications (optional)
    public let remindNotification: [AnnouncementRemindNotification]?
    
    public init(
        id: Int,
        imageURL: String? = nil,
        title: String,
        body: String,
        date: Date? = nil,
        location: AnnouncementLocationEntity? = nil,
        todos: [AnnouncementTodoEntity]? = nil,
        remindNotification: [AnnouncementRemindNotification]? = nil
    ) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.body = body
        self.date = date
        self.location = location
        self.todos = todos
        self.remindNotification = remindNotification
    }
}

/**
 Enum representing the types of reminder notifications for an announcement.
 */
public enum AnnouncementRemindNotification: Codable, Equatable {
    /// Notification to remind before a specified time interval
    case before(TimeInterval)
    /// Custom notification date
    case custom(Date)
}
