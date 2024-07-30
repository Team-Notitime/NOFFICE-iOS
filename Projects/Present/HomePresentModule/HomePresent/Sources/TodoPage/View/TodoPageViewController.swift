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
        super.viewWillAppear(animated)
        
        reactor.action.onNext(.viewWillAppear)
    }
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { 
        reactor.state.map { $0.organizations }
            .withUnretained(self)
            .map { owner, entities in
                TodoPageConverter.convertToTodoSections(
                    entities,
                    onTodoItemTap: { [weak owner] todoEntity in
                        owner?.reactor.action.onNext(
                            .tapTodo(todoEntity)
                        )
                    }
                )
            }
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { }
}
