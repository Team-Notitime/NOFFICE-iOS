//
//  NewAnnouncementFunnelViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import UIKit

import Router
import DesignSystem

import Swinject
import RxSwift
import RxCocoa

public class NewAnnouncementFunnelViewController: BaseViewController<NewAnnouncementFunnelView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewAnnouncementFunnelReactor.self)!
    
    // MARK: Setup
    public override func setupViewBind() { }
    
    public override func setupStateBind() { }
    
    public override func setupActionBind() { 
        baseView.navigationBar
            .onTapBackButton
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let currentPage = owner.baseView.paginableView.currentPage
                else { return }
                
                if currentPage == .selectOrganization {
                    Router.shared.dismiss()
                } else {
                    owner.reactor.action.onNext(.movePreviousPage)
                }
            })
            .disposed(by: disposeBag)
    }
}
