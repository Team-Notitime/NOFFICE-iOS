//
//  NewOrganizationCompletePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/20/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationCompletePageViewController: BaseViewController<NewOrganizationCompletePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationCompletePageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
        reactor.state.map { $0.link }
            .bind(to: baseView.linkTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        baseView.goHomeButton.onTap
            .map { _ in .tapGoHomeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        baseView.copyLinkButton.onTap
            .map { _ in .tapCopyLinkButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
