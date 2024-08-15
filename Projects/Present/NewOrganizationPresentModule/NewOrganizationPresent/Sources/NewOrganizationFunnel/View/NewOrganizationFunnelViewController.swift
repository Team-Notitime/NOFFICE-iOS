//
//  NewOrganizationViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import Router
import DesignSystem

import Swinject
import RxSwift
import RxCocoa

public class NewOrganizationFunnelViewController: BaseViewController<NewOrganizationFunnelView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationFunnelReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() {
        reactor.state.map { $0.currentPage }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, page in
                owner.paginableView.currentPage = page
            })
          .disposed(by: self.disposeBag)
    }
    
    public override func setupActionBind() {
        baseView.navigationBar
            .onTapBackButton
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let currentPage = owner.baseView.paginableView.currentPage
                else { return }
                
                if currentPage == .name {
                    Router.shared.back()
                } else {
                    owner.reactor.action.onNext(.movePreviousPage)
                }
            })
            .disposed(by: disposeBag)
    }
}
