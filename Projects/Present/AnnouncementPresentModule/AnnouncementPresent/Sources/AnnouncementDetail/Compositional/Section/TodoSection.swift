//
//  TodoSection.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

struct TodoSection: CompositionalSection {
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(width: .fractionalWidth(1.0), height: .estimated(48)),
                groupSpacing: 8,
                items: [
                    .item(size: .init(width: .fractionalWidth(1.0), height: .estimated(48)))
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
