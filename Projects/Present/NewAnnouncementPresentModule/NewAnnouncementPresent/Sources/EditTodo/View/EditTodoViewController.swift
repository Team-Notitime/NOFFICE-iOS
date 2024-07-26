//
//  EditTodoViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import Router
import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class EditTodoViewController: BaseViewController<EditTodoView>, UITextFieldDelegate {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditTodoReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() {
        baseView.newTodoTextField.textField.delegate = self
    }
    
    override func setupStateBind() {
        // - Todo state
        reactor.state.map { $0.todos }
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .map { owner, todos in
                EditTodoConverter
                    .convertToTodoSections(todos: todos) { [weak owner] todo in
                        owner?.reactor.action.onNext(.deleteTodo(todo))
                    }
            }
            .bind(to: baseView.collectionView.sectionBinder)
            .disposed(by: disposeBag)
        
        // - Todo contents
        reactor.state.map { $0.todoContent }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.newTodoTextField.text)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        // - Tap back button
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
        
        // - Add todo
        baseView.newTodoTextField
            .textFieldEvent
            .filter { $0 == .editingDidEndOnExit }
            .map { _ in .pressEnter }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Edit new todo text field
        baseView.newTodoTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { .changeTodoContent($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Add todo button
        baseView.addTodoButton.onTap
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { owner, _ in
                UIView.animate(withDuration: 0.25) { [weak owner] in
                    owner?.baseView.newTodoTextField.layer.opacity = 1.0
                }
                
                owner.baseView.newTodoTextField.textField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
        
        // Tap save button
        baseView.saveButton.onTap
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            
            self.baseView.newTodoTextField.layer.opacity = 0.0
        }
    }
}
