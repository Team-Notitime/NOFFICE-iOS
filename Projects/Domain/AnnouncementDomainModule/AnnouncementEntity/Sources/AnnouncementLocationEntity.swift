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
public enum AnnouncementLocationType: String, Codable, Equatable, CaseIterable, Identifiable {
    /// Online location
    case online
    /// Offline location
    case offline
    
    public var title: String {
        switch self {
        case .online:
            return "대면"
        case .offline:
            return "비대면"
        }
    }
    
    public var id: String {
        return self.title
    }
}
