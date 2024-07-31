//
//  GetAnnouncementDTO.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct GetAnnouncementDTO {
    struct Request: Codable { }
    
    struct Response: Codable {
        let organizationId: String
        let memberId: String
        let title: String
        let content: String
        let profileImageUrl: URL
        let placeName: String
        let placeLinkUrl: URL
        let isFaceToFace: Bool
        let tasks: [Task]
        let endAt: String
        let noticeBefore: [String]
        let noticeDate: [String]
    }
    
    // MARK: Nested DTO
    struct Task: Codable {
        let content: String
    }
}
