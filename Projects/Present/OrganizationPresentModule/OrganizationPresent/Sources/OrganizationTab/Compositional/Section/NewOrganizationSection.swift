//
//  OrganizationAddSection.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

struct NewOrganizationSection: CompositionalSection {
    // MARK: Compositional
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(1.0),
                    height: .estimated(42)
                ),
                groupSpacing: 16,
                items: [
                    .init(
                        width: .fractionalWidth(1.0),
                        height: .estimated(40)
                    )
                ],
                itemSpacing: 0
            ),
            sectionInset: .init(top: 16, leading: 18, bottom: 16, trailing: 18),
            scrollBehavior: .none
        )
    }
    
    // MARK: Data
    let items: [any CompositionalItem]
    
    init(
        items: [any CompositionalItem]
    ) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
    }
}
