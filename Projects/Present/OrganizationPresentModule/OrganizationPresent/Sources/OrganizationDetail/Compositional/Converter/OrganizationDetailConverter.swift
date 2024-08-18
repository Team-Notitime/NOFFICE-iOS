//
//  OrganizationDetailConverter.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 8/1/24.
//

import DesignSystem
import AnnouncementEntity

struct OrganizationDetailConverter {
    static func convert(
        from announcements: [AnnouncementSummaryEntity],
        onTapAnnouncementItem: @escaping (AnnouncementSummaryEntity) -> Void
    ) -> [any CompositionalSection] {
        return [
            AnnouncementSection(
                items: announcements.map { announcement in
                    AnnouncementItem(
                        id: announcement.id,
                        title: announcement.title,
                        place: announcement.placeName,
                        todoCount: announcement.todoCount,
                        body: announcement.body,
                        createdDate: announcement.createdAt ?? .now,
                        onTap: {
                            onTapAnnouncementItem(announcement)
                        }
                    )
                }
            )
        ]
    }
}
