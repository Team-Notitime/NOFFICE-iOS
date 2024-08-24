//
//  SelectOrganizationPageViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class SelectOrganizationPageViewController: BaseViewController<SelectOrganizationPageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SelectOrganizationPageReactor.self)!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad)
    }
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() { 
        // - Bind my organizations
        reactor.state.map { $0.myOrganizations }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance) 
            .withUnretained(self)
            .subscribe(onNext: { owner, value in
                owner.baseView.organizationGroup.updateSource(value)
            })
            .disposed(by: disposeBag)
        
        // - Bind next button
        reactor.state.map { $0.nextButtonActive }
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
    }
    
    override func setupActionBind() { 
        // - Select organization option
        baseView.organizationGroup
            .onChangeSelectedOption
            .map { option in
                return .changeSelectedOrganization(option)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // - Tap next page button
        baseView.nextButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
