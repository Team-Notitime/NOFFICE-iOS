//
//  AnnouncementSection.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 8/1/24.
//

import DesignSystem

struct AnnouncementSection: CompositionalSection {
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(width: .fractionalWidth(1.0), height: .estimated(42)),
                groupSpacing: 8,
                items: [
                    .item(size: .init(width: .fractionalWidth(1.0), height: .estimated(42)))
                ],
                itemSpacing: 0
            ),
            sectionInset: .init(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            ),
            scrollBehavior: .none
        )
    }
    
    private var identifier: String {
        String(describing: self)
    }
    
    let items: [any CompositionalItem]
    
    init(
        items: [any CompositionalItem]
    ) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
