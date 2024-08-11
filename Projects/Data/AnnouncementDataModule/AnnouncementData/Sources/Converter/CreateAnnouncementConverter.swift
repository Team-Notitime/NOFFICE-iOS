//
//  CreateAnnouncementConverter.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import AnnouncementEntity

import CommonData

struct CreateAnnouncementConverter {
    
    static func convert(
        from entity: AnnouncementEntity,
        memberId: Int
    ) -> CreateAnnouncementRequest {
        // Convert remindNotification to noticeBefore and noticeDate
        let noticeBefore: [String] = entity.remindNotification?.compactMap { notification in
            switch notification {
            case .before(let interval):
                return String(interval)
            default:
                return nil
            }
        } ?? []
        
        let noticeDate: [String] = entity.remindNotification?.compactMap { notification in
            switch notification {
            case .custom(let date):
                return date.toString()
            default:
                return nil
            }
        } ?? []
        
        return CreateAnnouncementRequest(
            organizationId: entity.organizationId,
            memberId: memberId,
            title: entity.title,
            content: entity.body,
            profileImageUrl: entity.imageUrl ?? "",
            placeName: entity.place?.name ?? "",
            placeLinkUrl: entity.place?.link ?? "",
            isFaceToFace: entity.place?.type == .online,
            tasks: entity.todos?.map {
                CreateAnnouncementRequest._Task(content: $0.content)
            } ?? [],
            endAt: entity.endAt?.toString() ?? "",
            noticeBefore: noticeBefore,
            noticeDate: noticeDate
        )
    }
}
