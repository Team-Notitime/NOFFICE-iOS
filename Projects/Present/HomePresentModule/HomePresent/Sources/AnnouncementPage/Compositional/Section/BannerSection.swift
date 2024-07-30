//
//  BannerSection.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

struct BannerSection: CompositionalSection {
    var layout: CompositionalLayout = .init(
        groupLayout: .init(
            size: .init(width: .fractionalWidth(1.0), height: .absolute(105)),
            groupSpacing: 16,
            items: [
                .item(
                    size: .init(
                        width: .fractionalWidth(1.0),
                        height: .fractionalHeight(1.0)
                    )
                )
            ],
            itemSpacing: 0
        ),
        sectionInset: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
        scrollBehavior: .none
    )
    
    var identifier: String
    var items: [any CompositionalItem]
    
    init(
        identifier: String,
        items: [any CompositionalItem]
    ) {
        self.items = items
        self.identifier = identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
