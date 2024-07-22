//
//  EditNotificationConverter.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import DesignSystem
import AnnouncementEntity

struct EditNotificationConverter {
    static func convert(
        options: [AnnouncementRemindNotification]
    ) -> [SelectedReminderSection] {
        var optionItems: [any CompositionalItem] = options.map { option in
            SelectedReminderItem(
                timeText: option.toKoreanString()
            )
        }
        
        optionItems.append(SelectedReminderDescriptionItem())
        
        return [
            SelectedReminderSection(
                items: optionItems
            )
        ]
    }
}
