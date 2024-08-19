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
    // MARK: State
    private var keyboardSize: CGRect = .zero
    
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditContentsPageReactor.self)!
    
    // MARK: Sub view controller
    private let editDateTimeViewController = EditDateTimeViewController()
    
    private let editPlaceViewController = EditPlaceViewController()
    
    private let editTodoViewController = EditTodoViewController()
    
    private let editNotificationViewController = EditNotificationViewController()
    
    // MARK: Setup
    override func setupViewBind() {
        // - Add keyboard dismissal event when scrolling
        setupDismissKeyboardOnScroll(in: baseView.scrollView)
        
        // - 텍스트 뷰가 늘어날때 스크롤 위치 조정
        baseView.bodyTextView
            .onChange
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.adjustScrollForTextViewChange(
                    activeField: owner.baseView.bodyTextView
                )
            })
            .disposed(by: disposeBag)
        
        // - 텍스트 뷰에서 터치한 위치로 스크롤 위치 조정
        RxKeyboard.shared.keyboardSize
            .withUnretained(self)
            .subscribe(onNext: { owner, size in
                if size != .zero {
                    owner.keyboardSize = size
                }
                
                owner.adjustScrollForBeginEdit(
                    activeField: owner.baseView.bodyTextView
                )
            })
            .disposed(by: disposeBag)
    }
    
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
            .bind { owner, active in
                owner.editNotification.status = active ? .selected : .unselected
            }
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() {
        // - Change title textfield
        baseView.titleTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map {
                .changeTitle($0)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        baseView.bodyTextView
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map {
                .changeBody($0)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap to edit date and time
        baseView.editDateTime
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                Router.shared.pushToPresent(owner.editDateTimeViewController)
            }
            .disposed(by: disposeBag)
        
        // - Tap to edit location
        baseView.editLocation
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                Router.shared.pushToPresent(owner.editPlaceViewController)
            }
            .disposed(by: disposeBag)
        
        // - Tap to edit to-do
        baseView.editTodo
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                Router.shared.pushToPresent(owner.editTodoViewController)
            }
            .disposed(by: disposeBag)
        
        // - Tap to edit notification
        baseView.editNotification
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                Router.shared.pushToPresent(owner.editNotificationViewController)
            }
            .disposed(by: disposeBag)
        
        // - Tap to complete
        baseView.completeButton
            .onTap
            .map { .tapCompleteButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: Adjust scroll offset for text view
    func adjustScrollForBeginEdit(activeField: UIView) {
        let activeFieldFrame = activeField.convert(
            activeField.bounds,
            to: baseView.scrollView
        )
        
        let cursorAbsolutPostionY = activeFieldFrame.minY
            + baseView.bodyTextView.location.y
        
        let offsetY = max(0, cursorAbsolutPostionY - keyboardSize.height)

        baseView.scrollView.setContentOffset(
            CGPoint(x: 0, y: offsetY),
            animated: true
        )
    }
    
    func adjustScrollForTextViewChange(activeField: UIView) {
        let activeFieldFrame = activeField.convert(
            activeField.bounds,
            to: baseView.scrollView
        )
        
        let offsetY = max(0, activeFieldFrame.maxY - keyboardSize.height - 42)

        baseView.scrollView.setContentOffset(
            CGPoint(x: 0, y: offsetY),
            animated: false
        )
    }
}
