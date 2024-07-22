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
public struct AnnouncementTodoEntity: Equatable {
    /// Content of the todo
    public let content: String
    
    public init(content: String) {
        self.content = content
    }
}
