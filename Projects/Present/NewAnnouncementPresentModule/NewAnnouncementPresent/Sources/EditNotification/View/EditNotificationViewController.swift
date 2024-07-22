//
//  EditNotificationViewController.swift
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

class EditNotificationViewController: BaseViewController<EditNotificationView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditNotificationReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { 
        reactor.state.map { $0.selectedTimeOptions }
            .map {
                EditNotificationConverter.convert(options: $0)
            }
            .bind(to: baseView.selectedReminderCollectionView.sectionBinder)
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
    }
}
