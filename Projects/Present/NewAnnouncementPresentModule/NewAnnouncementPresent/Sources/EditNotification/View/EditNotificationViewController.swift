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
    override func setupViewBind() { 
        baseView.reminderCollectionView
            .onChangeContentSize
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, size in
                guard let size = size else { return }
                
                owner.reminderCollectionView.snp.updateConstraints {
                    $0.height.equalTo(size.height)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func setupStateBind() { 
        reactor.state.map { $0.selectedTimeOptions }
            .distinctUntilChanged()
            .map {
                EditNotificationConverter.convertToReminder(
                    options: Array($0)
                        .sorted { $0.timeInterval < $1.timeInterval }
                )
            }
            .bind(to: baseView.reminderCollectionView.sectionBinder)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.timeOptions }
            .withUnretained(self)
            .map { owner, options in
                EditNotificationConverter.convertToTimeOption(
                    options: options,
                    selectedOptions: owner.reactor.currentState
                        .selectedTimeOptions,
                    onSelect: { [weak owner] option in
                        guard let owner = owner else { return false}
                        
                        let isOptionAlreadySelected = owner.reactor.currentState
                            .selectedTimeOptions
                            .contains(option)
                        
                        if !isOptionAlreadySelected {
                            owner.reactor.action.onNext(.selectReminder(option))
                        } else {
                            owner.reactor.action.onNext(.deselectReminder(option))
                        }
                        
                        return !isOptionAlreadySelected
                    }
                )
            }
            .bind(to: baseView.timeOptionCollectionView.sectionBinder)
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
        
        // - Tap back button
        baseView.saveButton
            .onTap
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
    }
}
