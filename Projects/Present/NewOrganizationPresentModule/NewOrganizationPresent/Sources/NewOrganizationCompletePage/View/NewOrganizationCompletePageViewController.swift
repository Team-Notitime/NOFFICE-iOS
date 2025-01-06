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
import MainEntity

class NewOrganizationCompletePageViewController: BaseViewController<NewOrganizationCompletePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationCompletePageReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { }
    
    override func setupStateBind() {
      reactor.state.map { "\(String(describing: $0.organization?.id))" }
            .bind(to: baseView.linkTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        baseView.goHomeButton.onTap
            .map { _ in .tapGoHomeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        baseView.copyLinkButton.onTap
            .map {
              BaseToast.show(in: self.view, message: "코드가 복사되었습니다", variant: .success)
            }
            .map { _ in .tapCopyLinkButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
