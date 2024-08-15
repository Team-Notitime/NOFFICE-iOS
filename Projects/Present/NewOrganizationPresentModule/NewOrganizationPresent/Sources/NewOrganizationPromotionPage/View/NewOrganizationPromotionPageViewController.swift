//
//  NewOrganizationPromotionPageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationPromotionPageViewController: BaseViewController<NewOrganizationPromotionPageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationPromotionPageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
        // - Complete button active state
        reactor.state.map { $0.completePageButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.completeButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
        
        // - Promotion code text field
        reactor.state.map { $0.promotionCode }
            .bind(to: baseView.promotionTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() {
        // - Text field
        baseView.promotionTextField.rx.text
            .orEmpty
            .map { .changePromotionCode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap next page button
        baseView.completeButton
            .onTap
            .map { _ in .tapCompleteButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
