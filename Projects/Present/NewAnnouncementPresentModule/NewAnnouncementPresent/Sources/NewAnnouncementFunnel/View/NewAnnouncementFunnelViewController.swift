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
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad)
    }
    
    // MARK: Setup
    public override func setupViewBind() {
        baseView.goHomeButton
            .onTap
            .subscribe(with: self, onNext: { owner, _ in
                owner.reactor.action.onNext(.toggleisOpenHasLeaderRoleOrganizationDialog)
                
                Router.shared.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    public override func setupStateBind() { 
        reactor.state.map { $0.currentPage }
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, page in
                owner.paginableView.currentPage = page
            })
          .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isOpenHasLeaderRoleOrganizationDialog }
            .skip(1)
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, isOpen in
                if isOpen {
                    owner.hasLeaderRoleOrganizationDialog.open()
                } else {
                    owner.hasLeaderRoleOrganizationDialog.close()
                }
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
                
                if currentPage == .selectOrganization 
                    || currentPage == .complete {
                    Router.shared.dismiss()
                } else {
                    owner.reactor.action.onNext(.movePreviousPage)
                }
            })
            .disposed(by: disposeBag)
    }
}
