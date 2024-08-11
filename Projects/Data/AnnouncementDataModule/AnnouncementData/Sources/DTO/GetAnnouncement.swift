//
//  GetAnnouncementDTO.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct GetAnnouncementRequest: Codable { }

struct GetAnnouncementResponse {
    let organizationId: String
    let memberId: String
    let title: String
    let content: String
    let profileImageUrl: String
    let placeName: String
    let placeLinkUrl: String
    let isFaceToFace: Bool
    let tasks: [Task]
    let endAt: String
    let noticeBefore: [String]
    let noticeDate: [String]
    
    struct Task: Codable {
        let content: String
    }
}
