//
//  SignupFunnelViewController.swift
//  SignupPresent
//
//  Created by DOYEON LEE on 7/18/24.
//

import UIKit

import Router
import DesignSystem
import Assets

import Swinject
import RxSwift
import RxCocoa
import ReactorKit

public class SignupFunnelViewController: BaseViewController<SignupFunnelView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(SignupFunnelReactor.self)!
    
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
            .withUnretained(self.baseView)
            .subscribe(onNext: { owner, _ in

                guard let currentPage = owner.paginableView.currentPage,
                      let currentPageIndex = owner.pages.firstIndex(where: { $0 == currentPage })
                else { return }
                
                if currentPageIndex < 1 {
                    Router.shared.dismiss()
                } else {
                    owner.paginableView.currentPage = owner.pages[currentPageIndex - 1]
                }
            })
            .disposed(by: disposeBag)
    }
}
