//
//  OrganizationCategoryEntity.swift
//  OrganizationEntity
//
//  Created by DOYEON LEE on 7/19/24.
//

import Foundation

/**
 Represents a todo item categorized by group.
 */
public struct TodoItemEntity: Codable, Identifiable, Equatable {
    /// Unique identifier for the todo item
    public let id: Int
    /// Contents of the todo item
    public let contents: String
    /// Status of the todo item
    public let status: TodoItemStatus
    
    public init(
        id: Int,
        contents: String,
        status: TodoItemStatus
    ) {
        self.id = id
        self.contents = contents
        self.status = status
    }
}

public enum TodoItemStatus: String, Codable {
    case done
    case pending
}