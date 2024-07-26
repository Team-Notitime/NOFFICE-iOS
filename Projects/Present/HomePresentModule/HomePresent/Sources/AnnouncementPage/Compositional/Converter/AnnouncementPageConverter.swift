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
        _ entities: [AnnouncementOrganizationEntity],
        onTapAnnouncementCard: @escaping (AnnouncementItemEntity) -> Void
    ) -> [OrganizationSection] {
        // - Convert to join pending card
        var convertPendingItems: () -> [any CompositionalItem] = {
            return [
                AnnouncementItem(state: .loading),
                AnnouncementDummyItem()
            ]
        }
        
        // - Convert to default announcement card
        var convertToAnnouncementItem: (
            AnnouncementItemEntity
        ) -> AnnouncementItem = { announcementEntity in
            let dateString = announcementEntity.date?
                .toString(format: "yyyy.MM.dd(EEE) HH:mm") ?? "-"
            let location = announcementEntity.place?.name ?? "-"
            
            return AnnouncementItem(
                state: .default,
                title: announcementEntity.title,
                date: dateString,
                location: location,
                onTap: {
                    onTapAnnouncementCard(announcementEntity)
                }
            )
        }
        
        // - Convert to join card or empty card
        var convertJoinItems: (
            AnnouncementOrganizationEntity
        ) -> [any CompositionalItem] = { organizationEntity in
            if organizationEntity.announcements.isEmpty {
                return [
                    AnnouncementItem(state: .none),
                    AnnouncementDummyItem()
                ]
            } else {
                return organizationEntity.announcements.map(convertToAnnouncementItem)
            }
        }
        
        // - Convert to cards
        var convertToItems: (
            AnnouncementOrganizationEntity
        ) -> [any CompositionalItem] = { organizationEntity in
            switch organizationEntity.status {
            case .join:
                return convertJoinItems(organizationEntity)
            case .pending:
                return convertPendingItems()
            }
        }
        
        return entities.map { organizationEntity in
            OrganizationSection(
                identifier: "\(organizationEntity.id)",
                organizationName: organizationEntity.name,
                items: convertToItems(organizationEntity)
            )
        }
    }
}
