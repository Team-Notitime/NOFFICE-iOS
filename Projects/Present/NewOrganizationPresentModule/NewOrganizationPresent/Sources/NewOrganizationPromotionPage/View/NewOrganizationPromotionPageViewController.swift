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
      
        reactor.state.compactMap(\.promotionisValid)
          .withUnretained(self)
          .subscribe { owner, valid in
            owner.baseView.errorState = valid
          }
          .disposed(by: self.disposeBag)
    }
    
    override func setupActionBind() {
      baseView.promotionTextField.rx.text
        .orEmpty
        .map { $0.isEmpty }
        .withUnretained(self)
        .subscribe { owner, isEmpty in
          owner.baseView.errorLabel.isHidden = isEmpty
        }
        .disposed(by: disposeBag)
      
        // - Text field
        baseView.promotionTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(150), scheduler: MainScheduler.instance)
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
