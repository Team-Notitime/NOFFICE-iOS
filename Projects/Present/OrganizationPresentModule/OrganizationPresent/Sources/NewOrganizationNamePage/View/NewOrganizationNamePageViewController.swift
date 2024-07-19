//
//  NewOrganizationNameViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationNamePageViewController: BaseViewController<NewOrganizationNamePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationNamePageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
        // - Next page button active state
        reactor.state.map { $0.nextPageButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextPageButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
        
        // - Text field text
        reactor.state.map { $0.name }
            .bind(to: baseView.nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        // - Text field text count
        reactor.state
            .map { "\($0.name.count)/\(OrganizationConstant.maxOrganizationNameLength)" }
            .bind(to: baseView.nameCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        // - Text field
        baseView.nameTextField.rx.text
            .orEmpty
            .map { text -> String in
                if text.count > OrganizationConstant.maxOrganizationNameLength {
                    return String(
                        text.prefix(OrganizationConstant.maxOrganizationNameLength)
                    )
                }
                return text
            }
            .map { NewOrganizationNamePageReactor.Action.changeName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
