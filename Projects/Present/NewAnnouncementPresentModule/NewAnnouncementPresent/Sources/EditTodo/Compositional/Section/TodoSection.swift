//
//  TodoSection.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import TodoEntity
import DesignSystem
import Assets

import RxSwift

struct TodoSection: CompositionalSection {
    var layout: CompositionalLayout {
        .init(
            groupLayout: .init(
                size: .init(
                    width: .fractionalWidth(1.0),
                    height: .estimated(42)
                ),
                groupSpacing: 0,
                items: [
                    .item(
                        size: .init(
                            width: .fractionalWidth(1.0),
                            height: .estimated(42)
                        )
                    )
                ],
                itemSpacing: GlobalViewConstant.PagePadding
            ),
            sectionInset: .init(
                top: 0,
                leading: GlobalViewConstant.PagePadding,
                bottom: 8,
                trailing: 0
            ),
            scrollBehavior: .none
        )
    }
    
    var todoId: Int
    var items: [any CompositionalItem]
    
    init(
        todoId: Int,
        items: [any CompositionalItem]
    ) {
        self.todoId = todoId
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(todoId)
    }
}
