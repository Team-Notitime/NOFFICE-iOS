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
    public let id: Int64
    
    /// Contents of the todo item
    public let contents: String
    
    /// Status of the todo item
    public var status: Status
    
    public init(
        id: Int64,
        contents: String,
        status: Status
    ) {
        self.id = id
        self.contents = contents
        self.status = status
    }
}

public extension TodoItemEntity {
    enum Status: String, Codable {
        case done
        case pending
    }
}
