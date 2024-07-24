//
//  EditContentsPageViewController.swift
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
import RxGesture

class EditContentsPageViewController: BaseViewController<EditContentsPageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditContentsPageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
        // - Whether date and time are used
        reactor.state.map { $0.dateActive }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, active in
                owner.editDateTime.status = active ? .selected : .unselected
            })
            .disposed(by: disposeBag)
        
        // - Whether location is used
        reactor.state.map { $0.locationActive }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, active in
                owner.editLocation.status = active ? .selected : .unselected
            })
            .disposed(by: disposeBag)
        
        // - Whether to-do is used
        reactor.state.map { $0.todoActive }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, active in
                owner.editTodo.status = active ? .selected : .unselected
            })
            .disposed(by: disposeBag)
        
        // - Whether notification is used
        reactor.state.map { $0.notificationActive }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, active in
                owner.editNotification.status = active ? .selected : .unselected
            })
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() {
        // - Tap to edit date and time
        baseView.editDateTime
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                Router.shared.pushToPresent(EditDateTimeViewController())
            })
            .disposed(by: disposeBag)
        
        // - Tap to edit location
        baseView.editLocation
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                Router.shared.pushToPresent(EditPlaceViewController())
            })
            .disposed(by: disposeBag)
        
        // - Tap to edit to-do
        baseView.editTodo
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                Router.shared.pushToPresent(EditTodoViewController())
            })
            .disposed(by: disposeBag)
        
        // - Tap to edit notification
        baseView.editNotification
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                Router.shared.pushToPresent(EditNotificationViewController())
            })
            .disposed(by: disposeBag)
        
        // - Tap to complete
        baseView.completeButton
            .onTap
            .map { .tapCompleteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
