//
//  UpdateAnnouncementRequest&Response.swift
//  AnnouncementDataInterface
//
//  Created by DOYEON LEE on 8/24/24.
//

import OpenapiGenerated

// MARK: Request
public struct UpdateAnnouncementRequest {
    public let announcementId: Int64
    public let updatedAnnoundement: Components.Schemas.AnnouncementUpdateRequest
    
    public init(
        announcementId: Int64,
        updatedAnnoundement: Components.Schemas.AnnouncementUpdateRequest
    ) {
        self.announcementId = announcementId
        self.updatedAnnoundement = updatedAnnoundement
    }
}

// MARK: Response
public typealias UpdateAnnouncementResponse = Components.Schemas.AnnouncementResponse
