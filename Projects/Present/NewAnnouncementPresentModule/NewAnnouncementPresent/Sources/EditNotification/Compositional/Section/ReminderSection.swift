//
//  SelectedReminderSection.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/23/24.
//

import Foundation

import DesignSystem
import Assets

struct ReminderSection: CompositionalSection {
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(1.0),
                    height: .estimated(29)
                ),
                groupSpacing: GlobalViewConstant.PagePadding / 2,
                items: [
                    .item(
                        size: .init(
                            width: .estimated(70),
                            height: .estimated(29)
                        )
                    )
                ],
                itemSpacing: GlobalViewConstant.PagePadding / 2
            ),
            sectionInset: .init(
                top: 0,
                leading: GlobalViewConstant.PagePadding,
                bottom: 8,
                trailing: GlobalViewConstant.PagePadding
            ),
            scrollBehavior: .none
        )
    }
    
    var identifier: String {
        "\(String(describing: self))"
    }
    var items: [any CompositionalItem]
    
    init(
        items: [any CompositionalItem]
    ) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
