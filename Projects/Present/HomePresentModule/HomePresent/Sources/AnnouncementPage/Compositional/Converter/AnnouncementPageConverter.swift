//
//  AnnouncementPageConverter.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import AnnouncementEntity
import DesignSystem

struct AnnouncementPageConverter {
    static func convertToOrganizationSections(
        _ entities: [AnnouncementOrganizationEntity]
    ) -> [OrganizationSection] {
        return entities.map { organizationEntity in
            OrganizationSection(
                identifier: "\(organizationEntity.id)",
                organizationName: organizationEntity.name,
                items: convertToItems(organizationEntity)
            )
        }
    }
    
    private static func convertToItems(
        _ organizationEntity: AnnouncementOrganizationEntity
    ) -> [any CompositionalItem] {
        switch organizationEntity.status {
        case .join:
            return convertJoinItems(organizationEntity)
        case .pending:
            return convertPendingItems()
        }
    }
    
    private static func convertJoinItems(
        _ organizationEntity: AnnouncementOrganizationEntity
    ) -> [any CompositionalItem] {
        if organizationEntity.announcements.isEmpty {
            return [
                AnnouncementItem(state: .none),
                AnnouncementDummyItem()
            ]
        } else {
            return organizationEntity.announcements.map(convertToAnnouncementItem)
        }
    }
    
    private static func convertPendingItems() -> [any CompositionalItem] {
        return [
            AnnouncementItem(state: .loading),
            AnnouncementDummyItem()
        ]
    }
    
    private static func convertToAnnouncementItem(
        _ announcementEntity: AnnouncementItemEntity
    ) -> AnnouncementItem {
        let dateString = announcementEntity.date?
            .toString(format: "yyyy.MM.dd(EEE) HH:mm") ?? "-"
        let location = announcementEntity.place?.name ?? "-"
        
        return AnnouncementItem(
            state: .default,
            title: announcementEntity.title,
            date: dateString,
            location: location
        )
    }
}
