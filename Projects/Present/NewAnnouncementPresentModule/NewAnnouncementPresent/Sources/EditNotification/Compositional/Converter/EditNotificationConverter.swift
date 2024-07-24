//
//  EditNotificationConverter.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import DesignSystem
import AnnouncementEntity

struct EditNotificationConverter {
    static func convertToReminder(
        options: [AnnouncementRemindNotification]
    ) -> [ReminderSection] {
        var optionItems: [any CompositionalItem] = options.map { option in
            ReminderItem(
                timeText: option.toKoreanString()
            )
        }
        
        optionItems.append(ReminderDescriptionItem())
        
        return [
            ReminderSection(
                items: optionItems
            )
        ]
    }
    
    static func convertToTimeOption(
        options: [AnnouncementRemindNotification],
        selectedOptions: Set<AnnouncementRemindNotification>,
        onSelect: @escaping (AnnouncementRemindNotification) -> Bool
    ) -> [TimeOptionSection] {
        let optionItems: [any CompositionalItem] = options.map { option in
            return TimeOptionItem(
                timeText: option.toKoreanString(),
                isSelected: selectedOptions.contains(option),
                onSelect: {
                    return onSelect(option)
                }
            )
        }
        
        return [
            TimeOptionSection(
                items: optionItems
            )
        ]
    }
}
