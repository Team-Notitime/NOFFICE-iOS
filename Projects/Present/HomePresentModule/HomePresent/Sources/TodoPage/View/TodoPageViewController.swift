//
//  TodoPageViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import TodoEntity
import DesignSystem

import RxSwift
import RxCocoa

class TodoPageViewController: BaseViewController<TodoPageView> {
    // MARK: Reactor
    let reactor = TodoPageReactor()
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        reactor.action.onNext(.viewWillAppear)
    }
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { 
        reactor.state.map { $0.organizations }
            .withUnretained(self)
            .map { owner, entities in
                owner.convertToSection(entities)
            }
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { }
    
    // MARK: Private
    /// Convert entity to compositional section
    private func convertToSection(
        _ entities: [TodoOrganizationEntity]
    ) -> [any CompositionalSection] {
        return entities.map { organizationEntity in
            TodoSection(
                organizationId: organizationEntity.id,
                organizationName: organizationEntity.name, 
                items: organizationEntity.todos.map { todoEntity in
                    TodoItem(
                        id: todoEntity.id,
                        contents: todoEntity.contents
                    )
                }
            )
        }
    }
}
