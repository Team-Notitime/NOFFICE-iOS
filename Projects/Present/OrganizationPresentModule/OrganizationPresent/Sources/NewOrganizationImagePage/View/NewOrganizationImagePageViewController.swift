//
//  NewOrganizationImagePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

public class NewOrganizationImagePageViewController: BaseViewController<NewOrganizationImagePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationCategoryPageReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() {
        // - Next page button active state
        reactor.state.map { $0.nextPageButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextPageButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
    }
    
    public override func setupActionBind() {
        // - Select category
//        baseView.categoryGroup
//            .onChangeSelectedOptions
//            .map { .changeSelectedCateogries($0)}
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
            
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
