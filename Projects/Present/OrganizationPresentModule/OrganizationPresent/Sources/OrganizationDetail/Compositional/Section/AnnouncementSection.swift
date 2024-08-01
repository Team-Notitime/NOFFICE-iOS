//
//  AnnouncementSection.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 8/1/24.
//

import Foundation

import DesignSystem

struct AnnouncementSection: CompositionalSection {
    // MARK: Constant
    static let ItemHeight: CGFloat = 166
    
    static let GroupSpacing: CGFloat = 8
    
    // MARK: Compositonal
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(1.0),
                    height: .estimated(Self.ItemHeight)
                ),
                groupSpacing: Self.GroupSpacing,
                items: [
                    .item(
                        size: .init(
                            width: .fractionalWidth(1.0),
                            height: .estimated(Self.ItemHeight)
                        )
                    )
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
    
    // MARK: Data
    private var identifier: String {
        String(describing: self)
    }
    
    let items: [any CompositionalItem]
    
    // MARK: Initializer
    init(
        items: [any CompositionalItem]
    ) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
