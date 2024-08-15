//
//  NewOrganizationCategoryPageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationCategoryPageViewController: BaseViewController<NewOrganizationCategoryPageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationCategoryPageReactor.self)!
    
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
    }
    
    override func setupActionBind() {
        // - Select category
        baseView.categoryGroup
            .onChangeSelectedOptions
            .map { .changeSelectedCateogries($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
            
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
