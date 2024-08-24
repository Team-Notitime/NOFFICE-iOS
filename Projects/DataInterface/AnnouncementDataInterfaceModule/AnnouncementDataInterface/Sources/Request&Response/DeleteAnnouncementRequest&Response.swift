//
//  DeleteAnnouncementRequest&Response.swift
//  AnnouncementDataInterface
//
//  Created by DOYEON LEE on 8/24/24.
//

// MARK: Request
public struct DeleteAnnouncementRequest {
    public let announcementId: Int64
    
    public init(
        announcementId: Int64
    ) {
        self.announcementId = announcementId
    }
}

// MARK: Response
public typealias DeleteAnnouncementResponse = Void
