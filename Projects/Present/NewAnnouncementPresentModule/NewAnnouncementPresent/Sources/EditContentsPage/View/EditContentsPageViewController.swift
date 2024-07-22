//
//  EditContentsPageViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa
import RxGesture

class EditContentsPageViewController: BaseViewController<EditContentsPageView> {
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { }
    
    override func setupActionBind() { 
        baseView.editDateTime
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in
                owner.editDateTime.status = .selected
                
                Router.shared.pushToPresent(EditDateTimeViewController())
            })
            .disposed(by: disposeBag)
        
        baseView.editLocation
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in
                owner.editDateTime.status = .selected
                
                Router.shared.pushToPresent(EditLocationViewController())
            })
            .disposed(by: disposeBag)
        
        baseView.editTodo
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in
                owner.editDateTime.status = .selected
                
                Router.shared.pushToPresent(EditTodoViewController())
            })
            .disposed(by: disposeBag)
        
        baseView.editNotification
            .rx.tapGesture()
            .when(.recognized)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in
                owner.editDateTime.status = .selected
                
                Router.shared.pushToPresent(EditNotificationViewController())
            })
            .disposed(by: disposeBag)
    }
}
