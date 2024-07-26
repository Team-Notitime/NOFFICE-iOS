//
//  OrganizationSection.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

struct OrganizationSection: CompositionalSection {
    // MARK: Compositional
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(1.0),
                    height: .estimated(80)
                ),
                groupSpacing: 0,
                items: [
                    .item(
                        size: .init(
                            width: .fractionalWidth(1.0),
                            height: .estimated(80)
                        )
                    )
                ],
                itemSpacing: 0
            ),
            sectionInset: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
            scrollBehavior: .none
        )
    }
    
    // MARK: Data
    let identifier = UUID()
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
