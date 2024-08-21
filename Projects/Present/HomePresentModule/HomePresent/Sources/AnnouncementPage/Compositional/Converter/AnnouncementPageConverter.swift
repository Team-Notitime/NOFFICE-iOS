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
        onTapAnnouncementCard: @escaping (AnnouncementSummaryEntity, AnnouncementOrganizationEntity) -> Void
    ) -> [AnnouncementSection] {
        // - Convert to join pending card
        let convertPendingItems: () -> [any CompositionalItem] = {
            return [
                AnnouncementItem(state: .loading),
                AnnouncementDummyItem()
            ]
        }
        
        // - Convert to default announcement card
        let convertToAnnouncementItem: (
            AnnouncementSummaryEntity,
            AnnouncementOrganizationEntity
        ) -> AnnouncementItem = { announcement, organization in
            return AnnouncementItem(
                state: .default,
                title: announcement.title,
                date: announcement.endAt?.toString() ?? "-",
                location: announcement.placeName ?? "-",
                onTap: { onTapAnnouncementCard(announcement, organization) }
            )
        }
        
        // - Convert to join card or empty card
        let convertJoinItems: (
            AnnouncementOrganizationEntity
        ) -> [any CompositionalItem] = { organization in
            if organization.announcements.isEmpty {
                return [
                    AnnouncementItem(state: .none),
                    AnnouncementDummyItem()
                ]
            } else {
                return organization.announcements
                    .map {
                        convertToAnnouncementItem($0, organization)
                    }
            }
        }
        
        // - Convert to cards
        let convertToItems: (
            AnnouncementOrganizationEntity
        ) -> [any CompositionalItem] = { organizationEntity in
            switch organizationEntity.status {
            case .join: return convertJoinItems(organizationEntity)
            case .pending: return convertPendingItems()
            }
        }
        
        return entities.map { organizationEntity in
            let scrollDisabled = organizationEntity.status == .pending
                || organizationEntity.announcements.isEmpty
            
            return AnnouncementSection(
                identifier: "\(organizationEntity.id)",
                organizationName: organizationEntity.name,
                scrollDisabled: scrollDisabled,
                items: convertToItems(organizationEntity)
            )
        }
    }
}
