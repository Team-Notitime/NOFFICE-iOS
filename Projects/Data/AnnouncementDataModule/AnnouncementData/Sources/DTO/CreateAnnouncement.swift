//
//  CreateAnnouncementDTO.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

struct CreateAnnouncementRequest: Codable {
    let organizationId: Int
    let memberId: Int
    let title: String
    let content: String
    let profileImageUrl: String
    let placeName: String
    let placeLinkUrl: String
    let isFaceToFace: Bool
    let tasks: [_Task]
    let endAt: String
    let noticeBefore: [String]
    let noticeDate: [String]
    
    struct _Task: Codable {
        let content: String
    }
}

struct CreateAnnouncementResponse: Codable { }
