//
//  GetAnnouncementConverter.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 8/10/24.
//

import Foundation

import AnnouncementEntity
import CommonData

struct GetAnnouncementConverter {
    
    static func convert(
        from response: GetAnnouncementResponse,
        memberId: Int
    ) -> AnnouncementEntity {
        // Convert place information
        let placeEntity: AnnouncementPlaceEntity? = {
            if !response.placeName.isEmpty {
                return AnnouncementPlaceEntity(
                    type: response.isFaceToFace ? .offline : .online, 
                    name: response.placeName,
                    link: response.placeLinkUrl
                )
            }
            return nil
        }()
        
        // Task(todo) fetch later
        let tasks: [AnnouncementTodoEntity] = []
        
        // Convert remind notifications
        let remindNotifications: [AnnouncementRemindNotification] = response.noticeBefore.compactMap { interval in
            if let timeInterval = TimeInterval(interval) {
                return .before(timeInterval)
            }
            return nil
        } + response.noticeDate.compactMap { dateStr in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            if let date = formatter.date(from: dateStr) {
                return .custom(date)
            }
            return nil
        }
        
        // Convert endAt date
        let endDate: Date? = ISO8601DateFormatter().date(from: response.endAt)
        
        return AnnouncementEntity(
            id: UUID().hashValue,  // Assuming there's no ID in response and generating a temporary ID
            organizationId: Int(response.organizationId) ?? 0,
            imageURL: response.profileImageUrl,
            createdAt: nil, // Assuming creation date is not provided in the response
            title: response.title,
            body: response.content,
            endAt: endDate,
            place: placeEntity,
            todos: tasks.isEmpty ? nil : tasks,
            remindNotification: remindNotifications.isEmpty ? nil : remindNotifications
        )
    }
}
