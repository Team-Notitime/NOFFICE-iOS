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
        from announcements: [AnnouncementEntity]
    ) -> [any CompositionalSection] {
        return [
            AnnouncementSection(
                items: announcements.map { announcement in
                    AnnouncementItem(
                        id: announcement.id,
                        title: announcement.title,
                        endDate: announcement.date,
                        place: announcement.place?.name,
                        todoCount: announcement.todos?.count,
                        body: announcement.body,
                        createdDate: announcement.createdAt ?? .now,
                        onTap: {}
                    )
                }
            )
        ]
    }
}
