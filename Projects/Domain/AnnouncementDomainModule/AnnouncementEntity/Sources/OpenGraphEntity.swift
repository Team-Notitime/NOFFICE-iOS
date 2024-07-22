//
//  OpenGraphEntity.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

/**
 Represents an Open Graph entity with metadata.
 */
public struct OpenGraphEntity {
    /// Title of the site
    public let title: String
    /// Type of the site
    public let type: String
    /// Image URL of the site (optional)
    public let imageURL: String?
    /// URL of the site
    public let url: String
    
    public init(
        title: String,
        type: String,
        imageURL: String? = nil,
        url: String
    ) {
        self.title = title
        self.type = type
        self.imageURL = imageURL
        self.url = url
    }
}
