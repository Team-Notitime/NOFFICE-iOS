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
                        let actionSheet = UIAlertController(
                            title: "투두 삭제",
                            message: "삭제하시겠습니까?",
                            preferredStyle: .actionSheet
                        )
                        
                        // 액션 추가
                        let action1 = UIAlertAction(
                            title: "삭제",
                            style: .destructive,
                            handler: { [weak owner]_ in
                            owner?.reactor.action.onNext(.deleteTodo(todo))
                        }
                        )
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        
                        // 액션 시트에 액션들 추가
                        actionSheet.addAction(action1)
                        actionSheet.addAction(cancelAction)
                        
                        // 액션 시트 표시
                        owner?.present(actionSheet, animated: true, completion: nil)
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
        baseView.newTodoCompleteButton
            .onTap
            .withUnretained(self)
            .filter { !$0.0.reactor.currentState.todoContent.isEmpty }
            .compactMap { $0 }
            .map { _ in .tapCompleteButton }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            
            self.baseView.newTodoTextField.layer.opacity = 1.0
            self.baseView.newTodoCompleteButton.layer.opacity = 1.0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            
            self.baseView.newTodoTextField.layer.opacity = 0.0
            self.baseView.newTodoCompleteButton.layer.opacity = 0.0
        }
    }
}
