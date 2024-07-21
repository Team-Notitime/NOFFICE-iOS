//
//  AnnouncementLocationEntity.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/21/24.
//

import Foundation

/**
 Represents the location information of an announcement.
 */
public struct AnnouncementLocationEntity: Codable, Equatable {
    /// Type of the announcement location (offline or online)
    public let type: AnnouncementLocationType
    /// Name of the location
    public let name: String?
    /// Link to the location (e.g., URL for online location)
    public let link: String
    
    public init(
        type: AnnouncementLocationType,
        name: String? = nil,
        link: String
    ) {
        self.type = type
        self.name = name
        self.link = link
    }
}

/**
 Enum representing the type of announcement location.
 */
public enum AnnouncementLocationType: String, Codable, Equatable {
    /// Offline location
    case offline
    /// Online location
    case online
}
