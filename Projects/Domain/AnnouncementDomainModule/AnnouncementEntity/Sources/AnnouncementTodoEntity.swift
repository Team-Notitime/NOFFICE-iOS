//
//  AnnouncementTodoEntity.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

/**
 Represents a todo item in an announcement.
 */
public struct AnnouncementTodoEntity: Equatable, Identifiable, Hashable {
    /// Unique identifier
    public let id: Int
    /// Content of the todo
    public let content: String
    /// Status of the todo
    public var status: Status
    
    public init(
        id: Int,
        content: String,
        status: Status
    ) {
        self.id = id
        self.content = content
        self.status = status
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (
        lhs: AnnouncementTodoEntity,
        rhs: AnnouncementTodoEntity
    ) -> Bool {
        return lhs.id == rhs.id
    }
}

public extension AnnouncementTodoEntity {
    enum Status {
        case done
        case pending
    }
}

public extension AnnouncementTodoEntity {
    func copy<T>(
        with keyPath: WritableKeyPath<AnnouncementTodoEntity, T>,
        value: T
    ) -> AnnouncementTodoEntity {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
