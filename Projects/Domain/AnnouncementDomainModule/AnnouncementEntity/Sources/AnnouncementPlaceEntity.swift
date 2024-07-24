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
public struct AnnouncementPlaceEntity: Equatable {
    /// Type of the announcement place (offline or online)
    public let type: AnnouncementPlaceType
    /// Name of the place
    public let name: String?
    /// Link to the place
    public let link: String
    
    public init(
        type: AnnouncementPlaceType,
        name: String? = nil,
        link: String
    ) {
        self.type = type
        self.name = name
        self.link = link
    }
}

/**
 Enum representing the type of announcement place.
 */
public enum AnnouncementPlaceType: String, Equatable, CaseIterable, Identifiable {
    /// Online location
    case online
    /// Offline location
    case offline
    
    public var title: String {
        switch self {
        case .online:
            return "비대면"
        case .offline:
            return "대면"
        }
    }
    
    public var id: String {
        return self.title
    }
}
